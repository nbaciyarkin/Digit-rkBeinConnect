//
//  Movie.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 2.11.2023.
//

import Foundation
struct Movie: Codable {
  let id: Int
  let title: String?
  let genreIds: [Int]?
  let overview: String?
  let posterPath: String?
  let backdropPath: String?
  let releaseDate: String?
  let voteAverage: Double?
  private enum CodingKeys: String, CodingKey {
    case id
    case title
    case overview
    case genreIds = "genre_ids"
    case posterPath = "poster_path"
    case backdropPath = "backdrop_path"
    case releaseDate = "release_date"
    case voteAverage = "vote_average"
  }
}
struct MoviePageResponse: Codable {
    let page: Int
    let results: [Movie]
    
}
