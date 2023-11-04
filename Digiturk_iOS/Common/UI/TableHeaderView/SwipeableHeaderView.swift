//
//  GenreCollectionCell.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 2.11.2023.
//

import Foundation
import UIKit

class SwipeableHeaderView: UIView {
    private lazy var MoviePosterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 500)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets.zero
            layout.headerReferenceSize = CGSize.zero
            layout.footerReferenceSize = CGSize.zero
            layout.sectionHeadersPinToVisibleBounds = true
            layout.sectionFootersPinToVisibleBounds = true
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    private lazy var PageControllerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 12, height: 12)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 4
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(PageControllerCollectionCell.self, forCellWithReuseIdentifier: PageControllerCollectionCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    private(set)var trendMoviesList: [Movie] = []
    private(set)var sectionList = [SwipeableHeaderSectionItem]()
    private(set)var currentPosterIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        self.backgroundColor = .clear
    }
    
    func setUI(){
        self.addSubview(MoviePosterCollectionView)
        MoviePosterCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalToSuperview()
            make.top.equalToSuperview()
        }
        self.addSubview(PageControllerCollectionView)
        PageControllerCollectionView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(175)
            make.height.equalTo(20)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
    private func selectPageControllerItem(at index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        PageControllerCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .left)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setMovies(movieList:[Movie]){
        let lastIndex = movieList.count - 1
        let startIndex = lastIndex - 9 // Starting index for the last 6 elements
        let lastTenElements = movieList[startIndex...lastIndex]
        // Convert the sliced elements back to an array
        self.trendMoviesList = Array(lastTenElements)
        self.MoviePosterCollectionView.reloadData()
        self.PageControllerCollectionView.reloadData()
    }
}

extension SwipeableHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendMoviesList.isEmpty ? 0 : trendMoviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView{
        case MoviePosterCollectionView:
            guard let cell = MoviePosterCollectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: trendMoviesList[indexPath.row])
            return cell
        case PageControllerCollectionView:
            guard let pageCell = PageControllerCollectionView.dequeueReusableCell(withReuseIdentifier: PageControllerCollectionCell.identifier, for: indexPath) as? PageControllerCollectionCell else {
                return UICollectionViewCell()
            }
            selectPageControllerItem(at: currentPosterIndex)
            return pageCell
        default: return UICollectionViewCell()
        }
    }
}

extension SwipeableHeaderView: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            let layout = self.MoviePosterCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
            let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing

            var offset = targetContentOffset.pointee
            let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
            let roundedIndex = round(index)

            offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
            targetContentOffset.pointee = offset
        }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
         if scrollView == MoviePosterCollectionView {
             let currentIndex = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
             currentPosterIndex = currentIndex
             selectPageControllerItem(at: currentPosterIndex)
         }
     }
}
