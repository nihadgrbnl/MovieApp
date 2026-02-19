//
//  MovieDetailCoordinator.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 18.02.26.
//

import UIKit

class MovieDetailCoordinator : Coordinator {
    var movieID : Int
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, movieID : Int) {
        self.movieID = movieID
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = MovieDetailController(viewModel: .init(movieID: movieID, useCase: MovieDetailManager()))
        controller.hidesBottomBarWhenPushed = true
        navigationController.show(controller, sender: nil)
    }
}


