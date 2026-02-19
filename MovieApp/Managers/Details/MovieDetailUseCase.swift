//
//  MovieDetailUseCase.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 19.02.26.
//

import Foundation

protocol MovieDetailUseCase {
    func getMovieDetails(movieID: String, completion: @escaping((MovieDetail? , String?) -> Void)) 
}
