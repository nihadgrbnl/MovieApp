//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 19.02.26.
//

import Foundation

final class MovieDetailViewModel {
    private var movieID : Int
    
    init(movieID: Int) {
        self.movieID = movieID
    }
    
    func getMovieDetail() {
        print("selected movie ID \(movieID)")
    }
    
}
