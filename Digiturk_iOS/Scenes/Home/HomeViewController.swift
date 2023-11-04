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
    func displayMoviesWithGenre(viewModel: MovieList.View.ViewModel)
}

class HomeViewController: UIViewController {
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
        view.backgroundColor = .black
        setup()
        self.interactor?.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setUI()
        tableView.contentInset = UIEdgeInsets(top: -UIApplication.shared.statusBarFrame.height, left: 0, bottom: 0, right: 0)
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .dark
        }
    }
    
    func setTableView(){
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
    
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
        tableHeaderView = SwipeableHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height:430))
        tableView.tableHeaderView = tableHeaderView
    }
    private func setUI(){
        view.addSubview(controllerHeaderView)
        controllerHeaderView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(140)
        }
    }
 
}
extension HomeViewController: HomeDisplayLogic {
    func displayMoviesWithGenre(viewModel: MovieList.View.ViewModel) {
       // print(viewModel.movieList)
    }
    
    func displayTrendMovies(viewModel: MovieList.View.ViewModel) {
        print("movieler geldi")
        self.trendMovies = viewModel.movieList
        print(viewModel.movieList)
        tableHeaderView?.setMovies(movieList: self.trendMovies)
        reloadTable()
    }
    
    func displayViewDidLoad(viewModel: Home.View.ViewModel) {
        Loader.show()
        self.genreList = viewModel.genres
        print(viewModel.genres)
        reloadTable()
        Loader.hide()
    }
    
    //  func displayViewDidLoad(viewModel: Home.View.ViewModel) {
    //    if let error = viewModel.error {
    ////      self.showAlert(title: "Uyarı", message: error, firstButtonTitle: "Tamam")
    //    }
    //    self.genreList = viewModel.genres
    //    self.genreList[0].isSelected = true
    //    //self.genresCollectionView.reloadData()
    //    self.viewControllers = self.genreList.map({ genre in
    //      let destination = MovieListViewController()
    //      var datastore = destination.router?.dataStore
    //      datastore?.genreId = genre.id
    //      return destination
    //  }
    //    self.reloadData()
    
    private func setupGenreListData(itemIndex: Int) {
        for index in self.genreList.indices {
            self.genreList[index].isSelected = false
        }
        self.genreList[itemIndex].isSelected = true
        //    self.genresCollectionView.reloadData()
        //    self.genresCollectionView.scrollToItem(at: IndexPath(row: itemIndex, section: 0), at: .centeredHorizontally, animated: true)
        
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
        let cell = UITableViewCell()
        cell.backgroundColor = .white
        if let genreId = genreList[indexPath.section].id {
            print("GENRE ID : = \(genreId)")
           
            
        }
          
        return cell
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let contentOffsetY = scrollView.contentOffset.y

            // Set your desired conditions for changing the navigation bar color based on content offset
        print(contentOffsetY)
         if contentOffsetY < 0 {
            scrollView.contentOffset.y = 0
        }
            if contentOffsetY > 100 { // Adjust this value as needed
                controllerHeaderView.backgroundColor = .black
            } else if contentOffsetY < 100 {
                
                controllerHeaderView.backgroundColor = .clear
            }
        }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view =  GenreCellHeaderView()
        if let sectionTitle = genreList[section].name {
            view.setSectionTitle(sectionTitle: sectionTitle)
        }
        view.backgroundColor = .black
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 33
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
        let startColor = UIColor.black.withAlphaComponent(0.8)
        let endColor = UIColor.black
        self.view.applyGradient(colors: [startColor.cgColor, endColor.cgColor], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 0.2))
    }
}



