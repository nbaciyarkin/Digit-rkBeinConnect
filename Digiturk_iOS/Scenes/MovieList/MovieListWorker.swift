//
//  MovieListWorker.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 5.11.2023.
//

import Foundation
import Alamofire
final class MovieListWorker {
    func getMoviesWithGenre(genreId: String,page: String, completion: @escaping (Result<MoviePageResponse, AFError>) -> Void) {
        Service.getMoviesWithGenre(withGenreId: genreId, page: page){ response in
            completion(.success(response))
        } onError: { error in
            completion(.failure(error))
        }
    }
}
