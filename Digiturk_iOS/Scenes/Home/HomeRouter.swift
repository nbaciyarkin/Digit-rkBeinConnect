//
//  HomeRouter.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 1.11.2023.
//

import Foundation
protocol HomeRoutingLogic {
}
protocol HomeDataPassing {
  var dataStore: HomeDataStore? { get }
}
final class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {
  weak var viewController: HomeViewController?
  var dataStore: HomeDataStore?
}
