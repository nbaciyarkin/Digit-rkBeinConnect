//
//  ApiCaller.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 1.11.2023.
//

import Foundation
class ApiCaller {

}
extension ApiCaller {
    enum ServiceEndPoint: String {
        case API_KEY = "8f85fd80267138372986d22648d9c24f"
        case baseUrl = "https://api.themoviedb.org/3"
        case trendmovies = "/trending/all/day?api_key="
        case genreList = "/genre/movie/list?api_key="
        case discover = "/discover/movie?"
        case page = "&page="
        case genre = "&with_genres="
        
   
                
        static func trendmovies() -> String {
            return "\(baseUrl.rawValue)\(trendmovies.rawValue)\(API_KEY.rawValue)"
        }
        
        static func getGenreList() -> String {
            return "\(baseUrl.rawValue)\(genreList.rawValue)\(API_KEY.rawValue)"
        }
        
        static func getMoviesWithGenre(genreId: String, pageNumber: String) -> String {
            return "\(baseUrl.rawValue)\(discover.rawValue)\(API_KEY.rawValue)\(page.rawValue)\(pageNumber)\(genre.rawValue)\(genreId)"
        }
        
        //
        //        static func getSecondHorizontalList() -> String {
        //            let token = UserDefaults.standard.getToken()
        //            return  "\(Base_URL.rawValue)\(discoverSecondHorizontalList.rawValue)"
        //        }
        //
        //        static func getThirthTwoColumnList() -> String {
        //            let token = UserDefaults.standard.getToken()
        //            return  "\(Base_URL.rawValue)\(discoverThirthTwoColumnList.rawValue)"
        //        }
        //
        
    }
}
