//
//  SeeAllViewModel.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 14.02.26.
//

import Foundation


class SeeAllViewModel {
    
    var movies: [NewMovieResult] = []
    private let manager = MovieManager()
    
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    func getSeeAllMovies(endpoint: MovieEndpoint, title: String) {
        manager.getMovies(endpoint: endpoint) {  data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.movies = data.results ?? []
                self.success?()
            }
        }
    }
    
    //    func startPagination(index: Int) {
    //        if index > items.count - 2 &&
    //            (actorData?.page ?? 0 <= actorData?.totalPages ?? 0) {
    //            getActorDatas()
    //        }
    //    }
    
}
