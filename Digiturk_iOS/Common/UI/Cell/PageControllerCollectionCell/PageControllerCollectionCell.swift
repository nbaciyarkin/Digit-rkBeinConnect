//
//  PageControllerCollectionCell.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 3.11.2023.
//

import Foundation
import UIKit
import SnapKit

class PageControllerCollectionCell: UICollectionViewCell {
    override var isSelected: Bool {
        didSet {
            container.backgroundColor = isSelected ? Colors.white : .clear
        }
    }
    static let identifier = "PageControllerCollectionCell"
    lazy var container: UIView = {
        let label = UIView()
        //label.textAlignment = .center
        label.backgroundColor = UIColor(named: "white")
        label.clipsToBounds = true // Ensure that the label clips its contents to its bounds
        label.layer.cornerRadius = min(frame.size.width, frame.size.height) / 2 // Make the label circular
        label.layer.borderColor = Colors.white.cgColor
        label.layer.borderWidth = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setUI()
        container.layer.cornerRadius = self.frame.size.width / 2
        self.layer.cornerRadius = self.frame.size.width / 2
        contentView.backgroundColor = .clear
        //        container.applyGradient(colors: [UIColor(named: "gold_dark")!.cgColor, UIColor(named: "gold_opac")!.cgColor], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0.3, y: 0))
        container.layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(){
        contentView.addSubview(container)
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(1) // Set the label's edges to the edges of the content view with an inset
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        container.layer.cornerRadius = container.frame.size.width / 2
        self.layer.cornerRadius = self.frame.size.width / 2
    }
    
}
