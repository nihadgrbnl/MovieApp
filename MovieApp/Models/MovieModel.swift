//
//  MovieModel.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 06.01.26.
//

import Foundation

struct MovieModel : Codable {
    let id : String?
    let title : String?
    let overview : String?
    let posterImage : String?
    let backdropImage : String?
    let rating : Double?
    let releaseDate : Int?
    let genre : [String]?
    let viewCount : Int?
    let director : String?
    let runtime : Int?
}
