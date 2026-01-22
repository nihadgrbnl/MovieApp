//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 09.01.26.
//

import Foundation

class HomeViewModel {
    private var movies : [Movie] = []
    
    
    var trendingMovies : [Movie] = []
    var categories : [String] = ["All", "Action", "Comedy", "Drama", "Horror", "Sci-Fi"]
    var gridMovies : [Movie] = []
    
    var selectedCategoryIndex : Int = 0
    
    var onDataUpdated : (() -> Void)?
    
    func fetchData() {
        
        //        self.allMovies = MovieService.shared.fetchMovies()
        
        NetworkManager.shared.getTrendingMovies { [weak self] result in
            switch result{
            case .success(let moviesFromAPI):
                self?.movies = moviesFromAPI
                print("\(moviesFromAPI.count) films came from API")
                self?.processMovies()
                self?.onDataUpdated?()
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
        
        
        
        //        var uniqueGenres = Set<String>()
        //        for movie in movies {
        //            if let genres = movie.genre {
        //                for genre in genres {
        //                    uniqueGenres.insert(genre)
        //                }
        //            }
        //        }
        //        self.categories = ["All"] + uniqueGenres.sorted()
        
        
        
        self.onDataUpdated?()
    }
    
    private func processMovies() {
        self.trendingMovies = Array(movies.prefix(10))
        self.gridMovies = movies
    }
    
    func selectedCategory(at index : Int) {
        self.selectedCategoryIndex = index
        let selectedTitle = categories[index]
        
        if selectedTitle == "All" {
            gridMovies = movies
        } else {
            //            gridMovies = movies.filter{ movie in
            //                return movie.genre?.contains(selectedTitle) ?? false
            
            gridMovies = movies
        }
        onDataUpdated?()
    }
    
    func getMovie(at index: Int) -> Movie {
        if index < self.gridMovies.count {
            return self.gridMovies[index]
        }
        return self.gridMovies[0]
    }

    
}


