//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 19.02.26.
//

import Foundation

final class MovieDetailViewModel {
    private var useCase : MovieDetailUseCase
    
    var detailItems: MovieDetail?
    private var movieID: Int

    
    var success : (() -> Void)?
    var error : ((String) -> Void)?
    
    init(movieID: Int, useCase: MovieDetailUseCase) {
        self.useCase = useCase
        self.movieID = movieID
    }
    
    func getMovieDetail() {
        let movieID1 = "\(movieID)"
        useCase.getMovieDetails(movieID: movieID1) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.detailItems = data
                self.success?()
                print(data)
            }
        }
    }
    
}
