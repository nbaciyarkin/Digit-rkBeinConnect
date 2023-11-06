//
//  MovieListViewController.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 4.11.2023.
//

import Foundation
import UIKit
import SnapKit
protocol MovieListDisplayLogic: AnyObject {
    func displayMovies(viewModel: MovieList.View.ViewModel)
}
class MovieListViewController: BaseViewController {
    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        layout.itemSize =  UIDevice.current.userInterfaceIdiom == .pad ? CGSize(width: UIScreen.main.bounds.width / 3 - 5 , height: 300) : CGSize(width: UIScreen.main.bounds.width / 3 - 5 , height: 200)
        layout.minimumInteritemSpacing = 4
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    private let controllerHeaderView = HeaderView()
    private var movieList: [Movie] = []
    private var genre: MovieGenre?
    var interactor: MovieListBusinessLogic?
    var router: (NSObjectProtocol & MovieListRoutingLogic & MovieListDataPassing)?
    
    private var pageNumber = 1
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = MovieListInteractor()
        let presenter = MovieListPresenter()
        let router = MovieListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        if let genreId = genre?.id {
            self.interactor?.viewDidLoad(genreId: String(genreId), page: String(pageNumber))
        }
    }
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setUI()
    }
    private func setUI(){
        self.view.backgroundColor = Colors.black
        controllerHeaderView.setForMovieListScreen()
        controllerHeaderView.delegate = self
        controllerHeaderView.backgroundColor = Colors.black
        view.addSubview(controllerHeaderView)
        controllerHeaderView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(120)
        }
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(controllerHeaderView.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
    func setMovieGenre(genre: MovieGenre){
        self.genre = genre
        if let genreName = genre.name{
            controllerHeaderView.setGenreName(genreName: genreName)
        }
    }
}
extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: movieList.get(at: indexPath.row))
        return cell
    }
}
// FIXME: pagination is working but maybe it can create  memory issue
extension MovieListViewController: UICollectionViewDelegate{
    
    //    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    //        if indexPath.row == movieList.count - 1 {
    //            print("fetch page 2 and reload Data")
    //            if let genreId = genre?.id {
    //                self.pageNumber += 1
    //                self.interactor?.viewDidLoad(genreId: String(genreId), page: String(self.pageNumber))
    //            }
    //        }
    //    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        VideoPlayerView.show(movie: self.movieList[indexPath.row])
    }
}
extension MovieListViewController: MovieListDisplayLogic {
    func displayMovies(viewModel: MovieList.View.ViewModel) {
        Loader.show()
        self.movieList.append(contentsOf: viewModel.movieList)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
        Loader.hide()
    }
}
extension MovieListViewController: HeaderViewDelegate {
    func didTappedBackButton() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
}
