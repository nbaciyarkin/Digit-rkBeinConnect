//
//  Entity.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 2.11.2023.
//

import Foundation
import Foundation
struct MovieGenre: Codable {
    let id: Int?
    let name: String?
    var isSelected: Bool? = false
}
struct MovieGenreList: Codable {
    let genres: [MovieGenre]?
}
