//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 09.01.26.
//

import Foundation

class HomeViewModel {
    var trendingMovies = [MovieModel]()
    var gridMovies = [MovieModel]()
    
    var onDataUpdated : (() -> Void)?
    
    func fetchData() {
        let allMovies = MovieService.shared.fetchMovies()
        
        self.trendingMovies = Array(allMovies.prefix(10))
        
        self.gridMovies = allMovies
        
        self.onDataUpdated?()
    }
    
    
}
