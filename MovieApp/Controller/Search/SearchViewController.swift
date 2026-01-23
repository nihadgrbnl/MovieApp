////
////  SearchViewController.swift
////  MovieApp
////
////  Created by Nihad Gurbanli on 07.01.26.
////
//
//import UIKit
//
//class SearchViewController: UIViewController {
//
//    @IBOutlet weak var searchBar: UISearchBar!
//    @IBOutlet weak var collection: UICollectionView!
//    @IBOutlet weak var imageCell: UIImageView!
//    
//    
//    
//    var allMovies: [Movie] = []
//    var filteredMovies: [Movie] = []
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        loadData()
//        
//        collection.keyboardDismissMode = .onDrag
//    }
//    
//    private func setupUI() {
//        collection.delegate = self
//        collection.dataSource = self
//        collection.register(UINib(nibName: "SearchListCell", bundle: nil), forCellWithReuseIdentifier: "SearchListCell")
//
//        
//        searchBar.delegate = self
//        searchBar.placeholder = "Search Movie..."
//        
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: view.frame.width - 20, height: 190)
//        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        collection.collectionViewLayout = layout
//        
//    }
//    
//    private func loadData() {
//        guard let url = Bundle.main.url(forResource: "movies", withExtension: "json") else {
//            print("Error: Json file could not find")
//            return
//        }
//        
//        do {
//            let data = try Data(contentsOf: url)
//            let decoder  = JSONDecoder()
//            self.allMovies = try decoder.decode([MovieModel].self, from: data)
//            self.filteredMovies = []
//            self.collection.reloadData()
//            
//            print("Data loaded - All Movie count are \(allMovies.count)")
//        } catch {
//            print("Json could not read \(error.localizedDescription)")
//        }
//    }
//}
//
//extension SearchViewController : UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return filteredMovies.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchListCell", for: indexPath) as! SearchListCell
//        
//        let movie = filteredMovies[indexPath.item]
//        cell.configure(movie: movie)
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//        let selectedMovie = filteredMovies[indexPath.item]
//        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let detailController = storyboard.instantiateViewController(withIdentifier: "DetailController") as? DetailController {
//            detailController.movie = selectedMovie
//            
//            if let navigationController = self.navigationController {
//                navigationController.show(detailController, sender: nil)
//            } else {
//                present(detailController, animated: true)
//            }
//        }
//            
//    }
//    
//    
//}
//
//extension SearchViewController : UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        
//        if searchText.isEmpty {
//            filteredMovies = []
//            collection.reloadData()
//            return
//        }
//        
//        filteredMovies = allMovies.filter { movie in
//            return movie.title!.lowercased().contains(searchText.lowercased())
//        }
//        collection.reloadData()
//    }
//}
