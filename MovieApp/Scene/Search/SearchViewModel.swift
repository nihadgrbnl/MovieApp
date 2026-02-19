//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 22.01.26.
//

import Foundation

class SearchViewModel {
    
    var movies: [Movie] = []
    var onDataUpdated: (() -> Void)?
    
    func searchMovie(query: String) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            self.movies = []
            self.onDataUpdated?()
            return
        }
        NetworkManager.shared.searchMovie(query: query){ [weak self] result in
            switch result {
            case .success(let moviesFromAPI):
                self?.movies = moviesFromAPI
                self?.onDataUpdated?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getMovie(at index: Int) -> Movie {
        return movies[index]
    }
}
