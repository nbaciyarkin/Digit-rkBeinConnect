//
//  HomeRouter.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 1.11.2023.
//

import Foundation
protocol HomeRoutingLogic {
    func navigate(genre:MovieGenre)
}
protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}
final class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
    func navigate(genre:MovieGenre) {
        let destination = MovieListViewController()
        destination.setMovieGenre(genre: genre)
        self.viewController?.navigationController?.pushViewController(destination, animated: true)
    }
}
