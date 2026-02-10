//
//  MovieManager.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 10.02.26.
//

import Foundation

class MovieManager {
    private let manager = NetworkManager()
    
    func getMovies(endpoint: MovieEndpoint, completion: @escaping((NewMovieModel?, String?) -> Void)) {
        manager.request(model: NewMovieModel.self,
                        endpoint: endpoint.rawValue,
                        completion: completion)
    }
}
