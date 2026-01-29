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


