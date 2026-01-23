//
//  MainTabBarViewController.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 07.01.26.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpController()

    }
    
    func setUpController() {
        let home = storyboard?.instantiateViewController(withIdentifier: "\(HomeViewController.self)") as! HomeViewController
        home.tabBarItem = .init(title: "Home",
                                image: UIImage(systemName: "house"),
                                tag: 0)
        let homeNavigation = UINavigationController(rootViewController: home)
        
        let search = storyboard?.instantiateViewController(withIdentifier: "\(SearchViewController.self)") as! SearchViewController
        search.tabBarItem = .init(title: "Search",
                                image: UIImage(systemName: "magnifyingglass"),
                                tag: 1)
        let searchNavigation = UINavigationController(rootViewController: search)
        
//        let watchList = storyboard?.instantiateViewController(withIdentifier: "\(WatchListViewController.self)") as! WatchListViewController
//        watchList.tabBarItem = .init(title: "Watchlist",
//                                image: UIImage(systemName: "bookmark"),
//                                tag: 2)
//        let watchListNavigation = UINavigationController(rootViewController: watchList)
        
        self.tabBar.backgroundColor = .appMainBackground
        viewControllers = [homeNavigation, searchNavigation, /*watchListNavigation,*/]
        
        
    }

}
