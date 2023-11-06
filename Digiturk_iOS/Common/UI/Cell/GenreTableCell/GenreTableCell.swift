//
//  GenreTableCell.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 4.11.2023.
//

import Foundation
import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject {
    //func collectionViewTableViewCellDidTap(_cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel)
}

class GenreTableCell: UITableViewCell {
    static let identifier = "GenreTableCell"
    
    weak var delegate: CollectionViewTableViewCellDelegate?
    private var genre:String?
    var movieList: [Movie] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 180)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        return collectionView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = Colors.black
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    public func configure(with movies: [Movie]){
        self.movieList = movies
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}
extension GenreTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: movieList[indexPath.row])
        cell.isHomeView = true
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        VideoPlayerView.show(movie: movieList[indexPath.row])
    }
}
