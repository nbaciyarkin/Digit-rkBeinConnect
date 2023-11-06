//
//  GenreCollectionCell.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 2.11.2023.
//
import Foundation
import UIKit
import SnapKit

class GenreCollectionCell: UICollectionViewCell {
    static let identifier = "GenreCollectionCell"
    private var infoLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "GENRE NAME"
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = Colors.white
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    func configure(title: String){
        self.infoLabel.text = title
    }
    func setUp(){
        contentView.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //           contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2))
    }
}
