//
//  HomeInteractor.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 1.11.2023.
//

import Foundation
import UIKit

protocol HomeBusinessLogic {
    func viewDidLoad()
    func getMoviesWithGenre(genreId: String, indexPath: IndexPath)
}

protocol HomeDataStore {
    var genres: [MovieGenre] { get set }
    var trendMovies: MovieList? { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
    private lazy var worker: HomeWorker = HomeWorker()
    var genres: [MovieGenre] = []
    var trendMovies: MovieList?
    func viewDidLoad() {
        if !self.genres.isEmpty {
            self.presenter?.presentViewDidLoad(response: Home.View.Response(genres: self.genres, error: nil))
        } else {
            self.getGenreList()
        }
        guard trendMovies != nil else {
            return getMovies()
        }
    }
    private func getMovies(){
        self.worker.getTrendMovies {[weak self] response in
            switch response {
            case .failure(let error):
                print(error)
            case .success(let response):
                let response = MovieList.View.Response(movieList: response.results , error: nil)
                self?.presenter?.presentTrendMovies(response: response)
            }
        }
    }
    func getMoviesWithGenre(genreId: String, indexPath: IndexPath){
        self.worker.getMoviesWithGenre(genreId: genreId) {[weak self] response in
            switch response {
            case .failure(let error):
                print(error)
            case .success(let response):
                let response = MovieList.View.Response(movieList: response.results , error: nil)
                self?.presenter?.presentMoviesWithGenre(response: response, indexPath: indexPath)
            }
        }
    }
    private func getGenreList() {
        self.worker.getGenres { [weak self] result in
            switch result {
            case .failure(let error):
                self?.presenter?.presentViewDidLoad(response: Home.View.Response(genres: [], error: error.localizedDescription))
            case .success(let list):
                self?.presenter?.presentViewDidLoad(response: Home.View.Response(genres: list.genres ?? [], error: nil))
            }
        }
    }
}
