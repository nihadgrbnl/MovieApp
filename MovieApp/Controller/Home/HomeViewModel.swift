//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 09.01.26.
//

import Foundation

class HomeViewModel {
    private var allMovies : [MovieModel] = []
    
    
    var trendingMovies : [MovieModel] = []
    var categories : [String] = []
    var gridMovies : [MovieModel] = []
    
    var selectedCategoryIndex : Int = 0
    
    var onDataUpdated : (() -> Void)?
    
    func fetchData() {
        
        self.allMovies = MovieService.shared.fetchMovies()
        
        self.trendingMovies = Array(allMovies.prefix(10))
        
        var uniqueGenres = Set<String>()
        for movie in allMovies {
            if let genres = movie.genre {
                for genre in genres {
                    uniqueGenres.insert(genre)
                }
            }
        }
        self.categories = ["All"] + uniqueGenres.sorted()
        
        self.gridMovies = allMovies
        
        self.onDataUpdated?()
    }
    
    func selectedCategory(at index : Int) {
        self.selectedCategoryIndex = index
        let selectedTitle = categories[index]
        
        if selectedTitle == "All" {
            gridMovies = allMovies
        } else {
            gridMovies = allMovies.filter{ movie in
                return movie.genre?.contains(selectedTitle) ?? false
            }
        }
        onDataUpdated?()
    }
}
