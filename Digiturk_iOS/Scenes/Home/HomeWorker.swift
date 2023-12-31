//
//  HomeWorker.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 2.11.2023.
//

import Foundation
import Alamofire
final class HomeWorker {
    func getGenres(completion: @escaping (Result<MovieGenreList, AFError>) -> Void) {
        Service.getGenres { response in
            completion(.success(response))
        } onError: { error in
            completion(.failure(error))
        }
    }
    func getTrendMovies(completion: @escaping (Result<MoviePageResponse, AFError>) -> Void) {
        Service.getMovies { response in
            completion(.success(response))
        } onError: { error in
            completion(.failure(error))
        }
    }
    func getMoviesWithGenre(genreId: String,completion: @escaping (Result<MoviePageResponse, AFError>) -> Void) {
        Service.getMoviesWithGenre(withGenreId: genreId, page: "1"){ response in
            completion(.success(response))
        } onError: { error in
            completion(.failure(error))
        }
    }
}
