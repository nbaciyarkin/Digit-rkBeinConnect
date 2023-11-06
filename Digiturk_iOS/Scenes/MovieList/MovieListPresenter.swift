//
//  MovieListPresenter.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 5.11.2023.
//

import Foundation
import UIKit
protocol MovieListPresentationLogic {
    func presentMovies(response: MovieList.View.Response)
}
final class MovieListPresenter: MovieListPresentationLogic {
    weak var viewController: MovieListDisplayLogic?
    func presentMovies(response: MovieList.View.Response) {
        let viewModel = MovieList.View.ViewModel(movieList: response.movieList, error: response.error)
        self.viewController?.displayMovies(viewModel: viewModel)
    }
}
