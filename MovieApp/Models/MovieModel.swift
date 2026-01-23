//
//  MovieModel.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 06.01.26.
//

import Foundation


class BaseResponse: Codable {
    let success: Bool?
    let status_code: Int?
    let status_message: String?
    
    enum CodingKeys: String, CodingKey {
        case success
        case status_code
        case status_message
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decodeIfPresent(Bool.self, forKey: .success)
        self.status_code = try container.decodeIfPresent(Int.self, forKey: .status_code)
        self.status_message = try container.decodeIfPresent(String.self, forKey: .status_message)
    }
}


class MovieResponse: BaseResponse {
    let results: [Movie]?
    
    enum CodingKeys: String, CodingKey {
            case results
        }

        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.results = try container.decodeIfPresent([Movie].self, forKey: .results)
            try super.init(from: decoder)
        }
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


