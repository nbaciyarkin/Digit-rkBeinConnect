//
//  Extension+Collection.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 1.11.2023.
//

import Foundation
extension Collection {
    func get(at index: Index?) -> Iterator.Element? {
        guard let index = index, indices.contains(index) else { return nil }
        return self[index]
    }
}

