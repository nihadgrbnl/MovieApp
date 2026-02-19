//
//  MovieDetailEndpoint.swift.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 19.02.26.
//

import Foundation

enum MovieDetailEndpoint {
    case details(movieID: String)
    
    var path : String {
        switch self {
        case .details(let movieID) :
            return "movie/\(movieID)"
        }
    }
}

