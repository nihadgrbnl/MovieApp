//
//  MovieService.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 06.01.26.
//

import Foundation

//class MovieService {
//    
//    var movieItem = [MovieModel]()
//    
//    static let shared = MovieService()
//    
//    private init() {}
//    
//    func  fetchMovies () -> [MovieModel] {
//        guard let url = Bundle.main.url(forResource: "movies", withExtension: "json") else {
//            print("movies.json file could not find")
//            return []
//        }
//        
//        
//        do {
//            let data = try Data(contentsOf: url)
//            let movies = try JSONDecoder().decode([MovieModel].self, from: data)
//            self.movieItem = movies
//            return movies 
//            
//        } catch {
//            print("Json could not parsed \(error.localizedDescription)")
//            return []
//        }
//    }
//}
