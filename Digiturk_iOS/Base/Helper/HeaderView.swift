//
//  HeaderView.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 3.11.2023.
//

import Foundation
import UIKit
import SnapKit

class HeaderView: UIView {
    var homeGenreList = ["Yabancı Filmler", "Yerli Filmler", "Betimleme"]

    private var leftButton: UIButton = {
        let btn = UIButton()
        let image = UIImage(named: "back-icon")?.withRenderingMode(.alwaysTemplate)
        btn.setImage(image, for: .normal)
        btn.tintColor = .white
        return btn
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "FİLM"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private var rightButton: UIButton = {
        let btn = UIButton()
        let image = UIImage(named: "black-search")?.withRenderingMode(.alwaysTemplate)
        btn.setImage(image, for: .normal)
        btn.tintColor = .white
        btn.sizeToFit()
        return btn
    }()
    
    private lazy var genresCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(GenreCollectionCell.self, forCellWithReuseIdentifier: GenreCollectionCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setUI()
        self.backgroundColor = .clear
        setUI()
        
    }
    
    func setUI(){
        self.addSubview(leftButton)
        leftButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.equalToSuperview().offset(12)
            make.width.equalTo(22)
            make.height.equalTo(22)
        }
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
            make.width.equalTo(45)
            make.height.equalTo(25)
        }
        
        self.addSubview(rightButton)
        rightButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().offset(-12)
            make.width.equalTo(22)
            make.height.equalTo(22)
        }
        self.addSubview(genresCollectionView)
        genresCollectionView.snp.makeConstraints { make in
            make.height.equalTo(35)
            make.leading.equalTo(leftButton.snp.trailing).offset(-1)
            make.trailing.equalTo(rightButton.snp.leading).offset(1)
            make.bottom.equalToSuperview().offset(-1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setGradientBlackColor(){
        let startColor = UIColor(named: "grayColor")!.withAlphaComponent(0.1)
        let endColor = UIColor.black
        self.applyGradient(colors: [startColor.cgColor, endColor.cgColor], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 0.3))
        self.layoutSubviews()
    }
    
    func setClearColor(){
        self.backgroundColor = .clear
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
extension HeaderView: UICollectionViewDelegate {
    
}

extension HeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeGenreList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = genresCollectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionCell.identifier, for: indexPath) as? GenreCollectionCell else {
            return UICollectionViewCell()
        }
        cell.configure(title: homeGenreList[indexPath.row])
        return cell
    }
    
    
}
extension HeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfElements: CGFloat = 3 // Number of elements in the collection view
        let collectionViewWidth = collectionView.frame.width
        let itemWidth = collectionViewWidth / numberOfElements
        return CGSize(width: itemWidth, height: 30) // You can adjust the height as per your requirement
    }
    
}
