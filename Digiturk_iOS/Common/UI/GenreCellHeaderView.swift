//
//  GenreCellHeaderView.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 4.11.2023.
//

import Foundation
import UIKit
import SnapKit

class GenreCellHeaderView: UIView {
    private let sectionTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(){
        self.addSubview(sectionTitle)
        sectionTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.height.equalTo(25)
            make.centerY.equalToSuperview()
            make.width.equalTo(150)
        }
    }
    
    func setSectionTitle(sectionTitle: String){
        self.sectionTitle.text = sectionTitle
    }
}
