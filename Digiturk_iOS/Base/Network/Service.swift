//
//  Service.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 1.11.2023.
//

import Foundation
import Alamofire
import Combine

enum APIError: Error {
    case requestFailed
    case decodingFailed
    // Add more error cases as needed
}

class Service {
    
    // MARK: - MDB Get Methods
    static func getMovies(onSucces: @escaping (MoviePageResponse) -> (), onError: @escaping (AFError) -> ()) {
        ServiceManager.shared.fetch(path: ApiCaller.ServiceEndPoint.trendmovies()) { (response: MoviePageResponse) in
            onSucces(response)
        } onError: { error in
            onError(error)
        }
    }
    static func getMoviesWithGenre(withGenreId:String, page: String, onSucces: @escaping (MoviePageResponse) -> (), onError: @escaping (AFError) -> ()) {
        ServiceManager.shared.fetch(path: ApiCaller.ServiceEndPoint.getMoviesWithGenre(genreId: withGenreId, pageNumber: page)) { (response: MoviePageResponse) in
            onSucces(response)
        } onError: { error in
            onError(error)
        }
    }
    
    static func getGenres(onSucces: @escaping (MovieGenreList) -> (), onError: @escaping (AFError) -> ()) {
        ServiceManager.shared.fetch(path: ApiCaller.ServiceEndPoint.getGenreList()) { (response: MovieGenreList) in
            onSucces(response)
        } onError: { error in
            onError(error)
        }
    }
}
