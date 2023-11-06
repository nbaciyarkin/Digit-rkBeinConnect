//
//  MovieListInteractor.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 5.11.2023.
//

import Foundation
import UIKit
protocol MovieListBusinessLogic {
    func viewDidLoad(genreId:String,page: String)
}
protocol MovieListDataStore {
    var genreId: Int? { get set }
}
class MovieListInteractor: MovieListBusinessLogic, MovieListDataStore {
    var presenter: MovieListPresentationLogic?
    private lazy var worker: MovieListWorker = MovieListWorker()
    var genreId: Int?
    func viewDidLoad(genreId:String, page: String) {
        self.getMoviesWithGenre(genreId: genreId, page: page)
    }
    func getMoviesWithGenre(genreId: String, page:String){
        self.worker.getMoviesWithGenre(genreId: genreId, page: page) {[weak self] response in
            switch response {
            case .failure(let error):
                print(error)
            case .success(let response):
                let response = MovieList.View.Response(movieList: response.results , error: nil)
                self?.presenter?.presentMovies(response: response)
            }
        }
    }
}
