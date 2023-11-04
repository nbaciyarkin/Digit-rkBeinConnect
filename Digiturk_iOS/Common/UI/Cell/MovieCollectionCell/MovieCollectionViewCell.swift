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
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "square.and.arrow.up.fill")
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    var movieModel: Movie?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    func setTitle(movieTitle: String){
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
        
        }
    }
    
    public func configure(with movieModel: Movie?) {
        guard let posterPath = movieModel?.posterPath else {return}
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") else {
            return
        }
        posterImageView.sd_setImage(with: url, completed: nil)
    }
}
