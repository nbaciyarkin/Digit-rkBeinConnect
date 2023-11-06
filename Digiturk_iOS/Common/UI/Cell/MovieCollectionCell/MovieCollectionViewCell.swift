//
//  MovieCollectionViewCell.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 3.11.2023.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    static let identifier = "MovieCollectionViewCell"
    var isHomeView = false
    
    private lazy var containerView: UIView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "square.and.arrow.up.fill")
        imageView.layer.cornerRadius = 3
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "square.and.arrow.up.fill")
        imageView.layer.cornerRadius = 3
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.backgroundColor = UIColor(named: "grayColor")
        return label
    }()
    
    var movieModel: Movie?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hideTitleLabel() {
        titleLabel.isHidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0))
    }
    
    func setUI(){
        contentView.addSubview(containerView)
        containerView.addSubview(posterImageView)
        posterImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview()
        }
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(30)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
        }
        contentView.layer.cornerRadius = 4
        contentView.layer.masksToBounds = true
    }
    
    public func configure(with movieModel: Movie?) {
        guard let posterPath = movieModel?.posterPath else {return}
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") else {
            return
        }
        posterImageView.sd_setImage(with: url, completed: nil)
        if let title = movieModel?.title {
            self.titleLabel.text = title
        }
    }
}
