//
//  ServiceManager.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 1.11.2023.
//

import Foundation
import Alamofire

class ServiceManager {
    static let shared: ServiceManager = ServiceManager()
}

enum IError: Error {
    case failedToGetData
}

extension ServiceManager {    
    func fetch<T>(path: String, onSuccess: @escaping (T) -> Void, onError: @escaping (AFError) -> Void) where T: Codable {
        AF.request(path, method: .get).validate().responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let model):
                onSuccess(model)
            case .failure(let error):
                onError(error)
            }
        }
    }
}
