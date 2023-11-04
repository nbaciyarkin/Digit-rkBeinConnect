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

class CollectionViewTableViewCell: UITableViewCell {

    static let identifier = "CollectionViewTableViewCell"
    
    weak var delegate: CollectionViewTableViewCellDelegate?
    
    private var movieList: [Movie] = []
    private var genre:String?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // I WANT MY COLLECTION VİEW TO BE THE ENTIRE BODY OF THE CELL
        collectionView.frame = contentView.bounds
    }
    
    public func configure(with movies: [Movie]){
        self.movieList = movies
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
//        guard let model = titles[indexPath.row].poster_path else {
//            return UICollectionViewCell()
//        }
        cell.configure(with: movieList[indexPath.row])
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
//        
//        let moview = movieList[indexPath.row]
//        //guard let titleName = moview.original_title ?? title.original_name else {return}
//        
//        ApiCaller.shared.getMovie(with: titleName + " trailer") { result in
//            switch result{
//            case .success(let videoElement):
//                let title = self.titles[indexPath.row]
//                guard let titleOverView = title.overview else {return}
//                let viewModel = TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: titleOverView)
//                self.delegate?.collectionViewTableViewCellDidTap(_cell: self, viewModel: viewModel)
//                
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
}