//
//  VidePlayerView.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 5.11.2023.
//

import Foundation
import UIKit
import AVKit
typealias VoidCallback = (() -> Void)

final class VideoPlayerView: UIView {
    // MARK: Components
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.white.withAlphaComponent(0.5)
        return view
    }()
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "back-icon"), for: .normal)
        button.tintColor = Colors.white
        button.setTitle(nil, for: .normal)
        button.addTarget(self, action: #selector(backButtonClicked(_:)), for: .touchUpInside)
        return button
    }()
    private lazy var videoTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.white
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        return label
    }()
    private lazy var videoTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.textColor = Colors.white
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    private lazy var videoTimeSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .gray
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        return slider
    }()
    private lazy var videoFullScreenButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "screenMax"), for: .normal)
        button.addTarget(self, action: #selector(fullScreenClicked(_:)), for: .touchUpInside)
        button.tintColor = Colors.white
        return button
    }()
    private lazy var videoPlayButton: UIButton = {
        let button = UIButton(type: .custom)
        //button.setImage(Asset.Images.pause.image, for: .normal)
        button.addTarget(self, action: #selector(playButtonClicked(_:)), for: .touchUpInside)
        button.tintColor = Colors.white
        return button
    }()
    // MARK: Variables
    static let shared = VideoPlayerView()
    private var isMinimized: Bool = false
    private var avPlayer = AVPlayer()
    private var avPlayerLayer = AVPlayerLayer()
    private var avPlayerItem : AVPlayerItem?
    private var point: CGPoint = .zero
    private var size: CGSize = .zero
    private var title: String = ""
    private var totalDurationTime: Int = 0
    // MARK: Object Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func show(movie: Movie) {
        self.shared.setupPlayer(movie: movie)
        self.shared.addObservers()
        DispatchQueue.main.async {
            if let hasView = UIApplication.kWindow?.subviews.contains(self.shared.containerView), hasView {
                self.shared.play()
            } else {
                UIApplication.kWindow?.addSubview(self.shared.containerView)
                self.shared.setLayouts()
                self.shared.play()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.shared.hideViews()
                }
            }
        }
    }
    static func hide() {
        DispatchQueue.main.async {
            self.shared.setupUIWhenScreenSizeChanged()
            self.shared.setDefaultsLayouts()
            self.shared.stop()
            self.shared.removeObservers()
            self.shared.containerView.removeFromSuperview()
        }
    }
}
// MARK: - EXTENSIONS -
// MARK: - Setup UI's
extension VideoPlayerView {
    private func setupUI() {
        self.isMinimized = false
        self.containerView.layer.masksToBounds = true
        self.avPlayerLayer.frame = UIScreen.main.bounds
        self.avPlayerLayer.masksToBounds = true
        self.containerView.addSubview(self.videoFullScreenButton)
        self.containerView.addSubview(self.backButton)
        self.containerView.addSubview(self.videoTitleLabel)
        self.containerView.addSubview(self.videoTimeLabel)
        self.containerView.addSubview(self.videoTimeSlider)
        self.containerView.addSubview(self.videoPlayButton)
        self.containerView.isUserInteractionEnabled = true
        self.containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped(_:))))
        self.setupUIWhenScreenSizeChanged()
        self.setDefaultsLayouts()
    }
    private func setupPlayer(movie: Movie) {
        self.videoTitleLabel.text = movie.title
        let videoURL = URL(string: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8")!
        let asset = AVAsset(url: videoURL)
        self.avPlayerItem =  AVPlayerItem(asset: asset)
        self.avPlayer = AVPlayer(playerItem: self.avPlayerItem)
        self.avPlayerLayer.player = self.avPlayer
        self.totalDurationTime = Int(CMTimeGetSeconds(asset.duration))
        self.containerView.layer.insertSublayer(self.avPlayerLayer, at: 0)
    }
    
    private func play(completion: VoidCallback? = nil) {
        self.avPlayer.play()
        self.videoPlayButton.setImage(UIImage(named: "pause"), for: .normal)
        completion?()
    }
    private func pause(completion: VoidCallback? = nil) {
        self.avPlayer.pause()
        self.videoPlayButton.setImage(UIImage(named: "play"), for: .normal)
        completion?()
    }
    private func stop(completion: VoidCallback? = nil) {
        self.avPlayer.seek(to: .zero)
        self.avPlayer.pause()
        self.videoPlayButton.setImage(UIImage(named: "play"), for: .normal)
        completion?()
    }
    private func calcuteTimeLabel(_ time: Int) -> String {
        let second = time % 60
        let minute = (time/60) % 60
        let hour = (time / 3600) % 60
        return String(format:"%02d:%02d:%02d", arguments: [hour,minute,second])
    }
    private func hideViews() {
        UIView.animate(withDuration: 0.5) { [unowned self] in
            self.videoTitleLabel.isHidden = true
            self.videoPlayButton.isHidden = true
            self.backButton.isHidden = true
            self.videoTimeLabel.isHidden = true
            self.videoTimeSlider.isHidden = true
            self.videoFullScreenButton.isHidden = true
        }
    }
    private func showViews() {
        UIView.animate(withDuration: 0.5) { [unowned self] in
            self.videoTitleLabel.isHidden = false
            self.videoPlayButton.isHidden = false
            self.backButton.isHidden = false
            self.videoTimeLabel.isHidden = false
            self.videoTimeSlider.isHidden = false
            self.videoFullScreenButton.isHidden = false
        }
    }
}
// MARK: - Setup Actions
extension VideoPlayerView {
    @objc
    private func playButtonClicked(_ sender: UIButton) {
        if self.avPlayer.timeControlStatus == .playing {
            self.pause()
            self.showViews()
        } else {
            self.play()
        }
    }
    @objc
    private func tapped(_ sender: UIGestureRecognizer) {
        self.showViews()
        if self.avPlayer.timeControlStatus == .playing {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [unowned self] in
                self.hideViews()
            }
        }
    }
    @objc
    private func backButtonClicked(_ sender: UIButton) {
        VideoPlayerView.hide()
    }
    @objc
    private func sliderValueChanged(_ sender: UISlider) {
        self.avPlayer.seek(to: CMTime(seconds: Double(sender.value * Float(totalDurationTime)), preferredTimescale: 1))
    }
    @objc
    private func deviceOrientationDidChange() {
        DispatchQueue.main.async {
            self.setupUIWhenScreenSizeChanged()
            self.setLayouts()
        }
    }
    @objc
    private func fullScreenClicked(_ sender: UIButton) {
        self.isMinimized.toggle()
        self.setupUIWhenScreenSizeChanged()
        self.setLayouts()
    }
    @objc
    private func videoDidFinish(_ notification: Notification) {
        self.showViews()
    }
}
// MARK: - Setup Layouts
extension VideoPlayerView {
    private func setLayouts() {
        switch UIDevice.current.orientation {
        case .portrait, .portraitUpsideDown:
            if self.isMinimized {
                self.setupMinimizeLayouts()
            } else {
                self.setDefaultsLayouts()
            }
            // MARK: TODO
        case .unknown, .faceUp, .faceDown, .landscapeLeft, .landscapeRight:
            self.avPlayerLayer.setAffineTransform(.identity)
        @unknown default:
            self.avPlayerLayer.setAffineTransform(.identity)
        }
    }
    private func setDefaultsLayouts() {
        self.videoFullScreenButton.snp.remakeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.leading.equalToSuperview().offset(8)
            make.width.height.equalTo(36)
        }
        self.backButton.snp.remakeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.width.height.equalTo(32)
            make.top.equalToSuperview().offset(28)
        }
        self.videoTitleLabel.snp.remakeConstraints { make in
            make.trailing.equalToSuperview().offset(120)
            make.top.equalToSuperview().offset(214)
            make.width.equalTo(300)
            make.height.equalTo(36)
        }
        self.videoTimeLabel.snp.remakeConstraints { make in
            make.leading.equalToSuperview().offset(-6)
            make.top.equalToSuperview().offset(64)
            make.width.equalTo(68)
            make.height.equalTo(24)
        }
        self.videoTimeSlider.snp.remakeConstraints { [unowned self] make in
            make.bottom.equalTo(0).offset(-48)
            make.top.equalTo(self.videoTimeLabel.snp.bottom).offset(8)
            make.width.equalTo(UIScreen.main.bounds.height - 156)
            make.height.equalTo(32)
            make.centerX.equalTo(self.videoTimeLabel.snp.centerX)
        }
        self.videoPlayButton.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(40)
        }
        self.videoTitleLabel.transform = .identity
        self.backButton.transform = CGAffineTransform(rotationAngle: .pi / 2)
        self.videoTitleLabel.transform = self.videoTitleLabel.transform.rotated(by: .pi/2)
        self.videoTimeLabel.transform = CGAffineTransform(rotationAngle: .pi / 2)
        self.videoTimeSlider.transform = CGAffineTransform(rotationAngle: .pi / 2)
        self.videoPlayButton.transform = CGAffineTransform(rotationAngle: .pi / 2)
    }
    private func setupMinimizeLayouts() {
        self.videoFullScreenButton.snp.remakeConstraints { make in
            make.trailing.bottom.equalToSuperview().offset(-16)
            make.width.height.equalTo(36)
        }
        self.backButton.snp.remakeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(32)
            make.top.equalToSuperview().offset(8)
        }
        self.videoTitleLabel.snp.remakeConstraints { [unowned self] make in
            make.leading.equalTo(self.backButton.snp.trailing).offset(16)
            make.centerY.equalTo(self.backButton.snp.centerY)
        }
        self.videoTimeLabel.snp.remakeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(68)
            make.height.equalTo(24)
            make.bottom.equalToSuperview().offset(-16)
        }
        self.videoTimeSlider.snp.remakeConstraints { [unowned self] make in
            make.leading.equalTo(self.videoTimeLabel.snp.trailing).offset(16)
            make.trailing.equalTo(self.videoFullScreenButton.snp.leading).offset(-16)
            make.height.equalTo(24)
            make.bottom.equalToSuperview().offset(-16)
        }
        self.videoPlayButton.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(40)
        }
        self.backButton.transform = .identity
        self.videoTitleLabel.transform = .identity
        self.videoTimeLabel.transform = .identity
        self.videoTimeSlider.transform = .identity
        self.videoPlayButton.transform = .identity
    }
    private func setupUIWhenScreenSizeChanged() {
        switch UIDevice.current.orientation {
        case .portrait :
            self.avPlayerLayer.videoGravity = self.isMinimized ? .resize : .resizeAspectFill
            let height: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 180 : 360
            self.size = self.isMinimized ? CGSize(width: UIScreen.main.bounds.width, height: height) : CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            self.point = self.isMinimized ? CGPoint(x: 0, y: UIScreen.main.bounds.height - height) : .zero
            self.videoFullScreenButton.isHidden = false
        case  .portraitUpsideDown:
            self.avPlayerLayer.videoGravity = self.isMinimized ? .resize : .resizeAspectFill
            let height: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 180 : 360
            self.size = self.isMinimized ? CGSize(width: UIScreen.main.bounds.width, height: height) : CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            self.point = self.isMinimized ? CGPoint(x: 0, y: UIScreen.main.bounds.height - height) : .zero
            self.videoFullScreenButton.isHidden = false
        case .unknown, .landscapeLeft, .landscapeRight, .faceUp, .faceDown:
            self.isMinimized = false
            self.avPlayerLayer.videoGravity = .resizeAspectFill
            self.size = UIScreen.main.bounds.size
            self.point = .zero
            self.videoFullScreenButton.isHidden = true
        @unknown default:
            self.isMinimized = false
            self.avPlayerLayer.videoGravity = .resizeAspectFill
            self.size = UIScreen.main.bounds.size
            self.point = .zero
            self.videoFullScreenButton.isHidden = true
        }
        switch UIDevice.current.orientation {
        case .portrait:
            self.avPlayerLayer.setAffineTransform(.identity)
            self.avPlayerLayer.setAffineTransform(self.isMinimized ? .identity : CGAffineTransform(rotationAngle: .pi / 2))
        case .portraitUpsideDown:
            self.avPlayerLayer.setAffineTransform(.identity)
            self.avPlayerLayer.setAffineTransform(self.isMinimized ? .identity : CGAffineTransform(rotationAngle: .pi))
        case .unknown, .faceUp, .faceDown, .landscapeLeft, .landscapeRight:
            self.avPlayerLayer.setAffineTransform(.identity)
        @unknown default:
            self.avPlayerLayer.setAffineTransform(.identity)
        }
        self.containerView.frame = CGRect(origin: point,
                                          size: size)
        self.avPlayerLayer.frame = CGRect(origin: .zero,
                                          size: size)
        
        self.videoFullScreenButton.setImage(!self.isMinimized ? UIImage(named: "screenMin") : UIImage(named: "screenMax"), for: .normal)
    }
}
// MARK: - Setup Observers
extension VideoPlayerView {
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.deviceOrientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
        self.avPlayerItem?.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        self.avPlayer.addPeriodicTimeObserver(
            forInterval: CMTime(value: 1, timescale: 1),
            queue: .main) { [unowned self] (time) in
                let currentDuration = Int(time.seconds)
                self.videoTimeLabel.text = self.calcuteTimeLabel(currentDuration)
                self.videoTimeSlider.value = Float(currentDuration) / Float(self.totalDurationTime)
            }
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.videoDidFinish(_:)),
            name: Notification.Name.AVPlayerItemDidPlayToEndTime,
            object: nil)
    }
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" {
            if self.avPlayer.status == .readyToPlay {
                self.avPlayer.play()
            }
        }
    }
}
