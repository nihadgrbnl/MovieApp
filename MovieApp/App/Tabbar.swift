//
//  MainTabBarViewController.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 07.01.26.
//

import UIKit

class Tabbar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpController()
    }
    
    func setUpController() {
        let home = HomeController(viewModel: .init(useCase: MovieManager()))
        let homeNavigation = UINavigationController(rootViewController: home)
        homeNavigation.tabBarItem = .init(title: "Home",
                                image: UIImage(systemName: "house"),
                                tag: 0)
        
        
        let search = storyboard?.instantiateViewController(withIdentifier: "\(SearchViewController.self)") as! SearchViewController
        let searchNavigation = UINavigationController(rootViewController: search)
        searchNavigation.tabBarItem = .init(title: "Search",
                                image: UIImage(systemName: "magnifyingglass"),
                                tag: 1)
        
        let actor = ActorController(viewModel: .init(useCase: ActorManager()))
        let actorNavigation = UINavigationController(rootViewController: actor)
        actorNavigation.tabBarItem = .init(title: "Actor",
                                image: UIImage(systemName: "person.fill"),
                                tag: 2)
        
//        let watchList = storyboard?.instantiateViewController(withIdentifier: "\(WatchListViewController.self)") as! WatchListViewController
//        watchList.tabBarItem = .init(title: "Watchlist",
//                                image: UIImage(systemName: "bookmark"),
//                                tag: 2)
//        let watchListNavigation = UINavigationController(rootViewController: watchList)
        
        self.tabBar.backgroundColor = .appMainBackground
        viewControllers = [homeNavigation, searchNavigation, actorNavigation /*watchListNavigation,*/]
        
        
    }

}
