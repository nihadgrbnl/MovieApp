//
//  MovieDetailManager.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 19.02.26.
//

import Foundation


class MovieDetailManager: MovieDetailUseCase {
 
    private let manager = NetworkManager()
    
    func getMovieDetails(movieID: String, completion: @escaping((MovieDetail? , String?) -> Void)) {
        manager.request(model: MovieDetail.self,
                        endpoint: MovieDetailEndpoint.details(movieID: movieID).path,
                        completion: completion)
    }
}
