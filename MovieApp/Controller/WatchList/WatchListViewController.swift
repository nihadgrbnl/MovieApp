////
////  WatchListViewController.swift
////  MovieApp
////
////  Created by Nihad Gurbanli on 07.01.26.
////
//
//import UIKit
//
//class WatchListViewController: UIViewController {
//    
//    @IBOutlet weak var collection: UICollectionView!
//    
//    var movies : [MovieModel] = []
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setUpCollectionView()
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        fetchData()
//    }
//    
//    private func setUpCollectionView() {
//        collection.delegate = self
//        collection.dataSource = self
//        collection.register(UINib(nibName: "SearchListCell", bundle: nil), forCellWithReuseIdentifier: "SearchListCell")
//        
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: view.frame.width - 20, height: 170)
//        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        collection.collectionViewLayout = layout
//        
//    }
//    
//    private func fetchData() {
//        self.movies = CoreDataManager.shared.fetchAllMovies()
//        collection.reloadData()
//    }
//}
//
//extension WatchListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return movies.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchListCell", for: indexPath) as! SearchListCell
//        let movie = movies[indexPath.item]
//        cell.configure(movie: movie)
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let selectedMovie = movies[indexPath.item]
//        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let detailController = storyboard.instantiateViewController(withIdentifier: "DetailController") as? DetailController {
//            detailController.movie = selectedMovie
//            
//            if let navigation = navigationController {
//                navigation.pushViewController(detailController, animated: true)
//            } else {
//                present(detailController, animated: true)
//            }
//        }
//        
//    }
//    
//    
//}
