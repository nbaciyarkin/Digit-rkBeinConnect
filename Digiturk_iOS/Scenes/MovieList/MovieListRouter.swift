//
//  MovieListRouter.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 4.11.2023.
//

import UIKit
import UIKit
protocol MovieListRoutingLogic {
}
protocol MovieListDataPassing {
    var dataStore: MovieListDataStore? { get }
}
final class MovieListRouter: NSObject, MovieListRoutingLogic, MovieListDataPassing {
    weak var viewController: MovieListViewController?
    var dataStore: MovieListDataStore?
    
}
