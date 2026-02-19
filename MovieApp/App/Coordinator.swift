//
//  Coordinator.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 18.02.26.
//

import UIKit

protocol Coordinator {
    var navigationController : UINavigationController { get set }
    
    func start()
    
}
