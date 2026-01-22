//
//  MovieModel.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 06.01.26.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let title: String?
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double
    let releaseDate: String?
    
    // let genre: [String]?
    // let viewCount: Int?
    // let director: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path" // Düzeltildi
        case voteAverage = "vote_average"   // Düzeltildi
        case releaseDate = "release_date"
    }
}


