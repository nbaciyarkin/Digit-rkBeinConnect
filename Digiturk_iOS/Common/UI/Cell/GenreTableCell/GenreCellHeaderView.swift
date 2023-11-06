//
//  GenreCellHeaderView.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 4.11.2023.
//

import Foundation
import UIKit
import SnapKit
protocol GenreCellHeaderViewDelegate: AnyObject {
    func didTappedGenreHeaderView(genre:MovieGenre)
}
class GenreCellHeaderView: UIView {
    private let sectionTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .left
        label.textColor = Colors.white
        return label
    }()
    private var rightButton: UIButton = {
        let btn = UIButton()
        let image = UIImage(named: "menu_icon")?.withRenderingMode(.alwaysTemplate)
        btn.setImage(image, for: .normal)
        btn.tintColor = Colors.white
        btn.sizeToFit()
        return btn
    }()
    
    private lazy var tapButton: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(didTappedCell), for: .touchUpInside)
        btn.backgroundColor = .clear
        return btn
    }()
    var genre: MovieGenre?
    weak var delegate:GenreCellHeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func didTappedCell(){
        if let movieGenre = genre{
            delegate?.didTappedGenreHeaderView(genre: movieGenre)
        }
    }
    func setUI(){
        self.addSubview(sectionTitle)
        sectionTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.height.equalTo(30)
            make.centerY.equalToSuperview()
            make.width.equalTo(150)
        }
        self.addSubview(rightButton)
        rightButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(18)
            make.centerY.equalToSuperview()
            make.width.equalTo(18)
        }
        self.addSubview(tapButton)
        tapButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.height.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    func setSection(genre: MovieGenre ){
        self.genre = genre
        self.sectionTitle.text = genre.name
    }
}
