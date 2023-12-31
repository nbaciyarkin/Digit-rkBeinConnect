//
//  HomePresenter.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 1.11.2023.
//

import Foundation
protocol HomePresentationLogic {
    func presentViewDidLoad(response: Home.View.Response)
    func presentTrendMovies(response: MovieList.View.Response)
    func presentMoviesWithGenre(response: MovieList.View.Response, indexPath: IndexPath)
}
final class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?
    func presentMoviesWithGenre(response: MovieList.View.Response, indexPath:IndexPath) {
        let viewModel = MovieList.View.ViewModel(movieList: response.movieList, error: response.error)
        self.viewController?.displayMoviesWithGenre(viewModel: viewModel, indexPath: indexPath)
    }
    
    func presentTrendMovies(response: MovieList.View.Response) {
        let viewModel = MovieList.View.ViewModel(movieList: response.movieList, error: response.error)
        self.viewController?.displayTrendMovies(viewModel: viewModel)
    }
    
    func presentViewDidLoad(response: Home.View.Response) {
        let viewModel = Home.View.ViewModel(genres: response.genres, error: response.error)
        self.viewController?.displayViewDidLoad(viewModel: viewModel)
    }
}
