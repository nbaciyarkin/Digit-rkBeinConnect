//
//  HomeViewController.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 1.11.2023.
//

import Foundation
import UIKit
import Alamofire
import SnapKit

protocol HomeDisplayLogic: AnyObject {
    func displayViewDidLoad(viewModel: Home.View.ViewModel)
    func displayTrendMovies(viewModel: MovieList.View.ViewModel)
    func displayMoviesWithGenre(viewModel: MovieList.View.ViewModel, indexPath: IndexPath)
}
class HomeViewController: BaseViewController {
    private lazy var tableView = UITableView()
    private var tableHeaderView: SwipeableHeaderView?
    let controllerHeaderView = HeaderView()
    
    private lazy var genreList: [MovieGenre] = []
    private var trendMovies: [Movie] = []
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setup()
        self.interactor?.viewDidLoad()
        setUI()
        tableView.contentInset = UIEdgeInsets(top: -UIApplication.shared.statusBarFrame.height, left: 0, bottom: 0, right: 0)
        
    }
    func setTableView(){
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(GenreTableCell.self, forCellReuseIdentifier: GenreTableCell.identifier)
        
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        tableView.showsVerticalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        if #available(iOS 11.0, *) {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        tableHeaderView = UtilityHelper.shared.isPad() ? SwipeableHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height:400)) : SwipeableHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height:350))
        tableView.tableHeaderView = tableHeaderView
    }
    private func setUI(){
        view.addSubview(controllerHeaderView)
        controllerHeaderView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(120)
        }
    }
}
extension HomeViewController: HomeDisplayLogic {
    func displayMoviesWithGenre(viewModel: MovieList.View.ViewModel, indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row, section: indexPath.section))  as? GenreTableCell {
            cell.movieList = viewModel.movieList
        }
    }
    func displayTrendMovies(viewModel: MovieList.View.ViewModel) {
        self.trendMovies = viewModel.movieList
        tableHeaderView?.setMovies(movieList: self.trendMovies)
    }
    func displayViewDidLoad(viewModel: Home.View.ViewModel) {
        Loader.show()
        self.genreList = viewModel.genres
        reloadTable()
        Loader.hide()
    }
    private func setupGenreListData(itemIndex: Int) {
        for index in self.genreList.indices {
            self.genreList[index].isSelected = false
        }
    }
}
extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return genreList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GenreTableCell.identifier, for: indexPath) as? GenreTableCell else {
            return UITableViewCell()
        }
        if let genreId = genreList.get(at: indexPath.section)?.id {
            self.interactor?.getMoviesWithGenre(genreId: String(genreId), indexPath: indexPath)
        }
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        if contentOffsetY < 0 {
            scrollView.contentOffset.y = 0
        }
        if contentOffsetY < 70 { // Adjust this value as needed
            controllerHeaderView.backgroundColor = .clear
        }else if contentOffsetY > 70 && contentOffsetY < 180 {
            controllerHeaderView.backgroundColor = Colors.black.withAlphaComponent(0.6)
        } else if contentOffsetY > 180 {
            controllerHeaderView.backgroundColor = Colors.black
        }
    }
}
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view =  GenreCellHeaderView()
        if let genre = genreList.get(at: section){
            view.delegate = self
            view.backgroundColor = Colors.black
            view.setSection(genre: genre)
            return view
        }
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
extension HomeViewController {
    func reloadTable(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
extension HomeViewController {
    func setBackGround(){
        let startColor = Colors.black.withAlphaComponent(0.8)
        let endColor = Colors.black
        self.view.applyGradient(colors: [startColor.cgColor, endColor.cgColor], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 0.2))
    }
}
extension HomeViewController: GenreCellHeaderViewDelegate {
    func didTappedGenreHeaderView(genre: MovieGenre) {
        self.router?.navigate(genre: genre)
    }
}




