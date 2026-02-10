//
//  MovieModel.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 06.01.26.
//

import Foundation
import CoreData


protocol BaseResponse:  Sendable {
    var success: Bool? { get }
    var statusCode: Int? { get }
    var statusMessage: String? { get }
}


struct MovieResponse: BaseResponse ,Sendable {
    
    let success: Bool?
    let statusCode: Int?
    let statusMessage: String?
    
    let results: [Movie]?
    let page: Int?
    let totalPages: Int?
    let totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case results
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

extension MovieResponse: Codable {}

struct Movie: Sendable {
    let id: Int
    let title: String?
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double?
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
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
}

extension Movie: Codable{}

extension MovieItem {
    func toMovieStruct() -> Movie {
        return Movie(id: Int(self.id),
                     title: self.title,
                     originalTitle: nil,
                     overview: self.overview,
                     posterPath: self.poster_path,
                     backdropPath: self.backdrop_path,
                     voteAverage: self.vote_average,
                     releaseDate: self.release_date)
    }
}

extension Movie {
    
    @discardableResult
    func toMovieItem(in context: NSManagedObjectContext) -> MovieItem {
        let item = MovieItem(context: context)
        item.id = Int64(self.id)
        item.title = self.title
        item.overview = self.overview
        item.poster_path = self.posterPath
        item.vote_average = self.voteAverage ?? 0.0
        item.release_date = self.releaseDate
        item.backdrop_path = self.backdropPath
        return item
    }
}

struct VideoResponse: BaseResponse, Sendable {
    let success: Bool?
    let statusCode: Int?
    let statusMessage: String?
    
    let id: Int?
    let results: [VideoResult]?
    
    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case id
        case results
    }
}


struct VideoResult: Sendable {
    let id: String?
    let iso6391: String?
    let iso31661: String?
    let key: String?
    let name: String?
    let official: Bool?
    let publishedAt: String?
    let site: String?
    let size: Int?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case id, key, name, official, site, size, type
        case iso6391 = "iso_639_1"
        case iso31661 = "iso_3166_1"
        case publishedAt = "published_at"
    }
    
    var badgeColor: String {
        switch type {
        case "Trailer": return "🔴" // Kırmızı
        case "Teaser": return "🟡"  // Sarı
        case "Featurette": return "🔵" // Mavi
        default: return "Hz"         // Gri
        }
    }
}
extension VideoResponse: Codable{}
extension VideoResult: Codable{}



