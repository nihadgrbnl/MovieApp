//
//  MovieUseCase.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 19.02.26.
//

import Foundation

protocol MovieUseCase {
    func getMovies(endpoint: MovieEndpoint, completion: @escaping((NewMovieModel?, String?) -> Void))
}
