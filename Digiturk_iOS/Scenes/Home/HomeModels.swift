//
//  HomeModels.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 2.11.2023.
//

import Foundation
enum Home {
  enum View {
    struct Request {
    }
    struct Response {
      let genres: [MovieGenre]
      let error: String?
    }
    struct ViewModel {
      let genres: [MovieGenre]
      let error: String?
    }
  }
}

enum MovieList {
  enum View {
    struct Request {
    }
    struct Response {
      let movieList: [Movie]
      let error: String?
    }
    struct ViewModel {
      let movieList: [Movie]
      let error: String?
    }
  }
}


