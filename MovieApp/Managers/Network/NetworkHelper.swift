//
//  NetworkHelper.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 03.02.26.
//

import Foundation
import Alamofire

enum EncodingType {
    case url, json
}

class NetworkHelper {
    static let shared = NetworkHelper()
    
    private let baseUrl = "https://api.themoviedb.org/"
    private let version = "3"
    
    private let imageSize = "w500"
    private let imageBaseURL = "https://image.tmdb.org/t/p/"

    let headers: HTTPHeaders = [
        "Accept" : "application/json",
        "Authorization" : "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NjMyM2EwMWU3NTNjZDcxYmQyZWY5NTIxNDc0ZDY4MiIsIm5iZiI6MTc1NTA4MjMyNC45OTUwMDAxLCJzdWIiOiI2ODljNmU1NDY1YjMxZTM3Y2Y4ZWJjMWYiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.c6LkWmJfy7Kr6DiFJu9pHMCaelRAEBUGp4Tee_fVKNU"
    ]
    
    func configureURL(endpoint: String) -> String{
        baseUrl + version + "/" + endpoint
    }
    
    func configureImageURL(path: String) -> String {
        imageBaseURL + imageSize + path
    }
}
