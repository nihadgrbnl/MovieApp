//
//  SearchViewController.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 07.01.26.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var imageCell: UIImageView!
    
    private let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setUpBindings()
        
    }
    
    private func setupUI() {
        collection.delegate = self
        collection.dataSource = self
        collection.keyboardDismissMode = .onDrag
        collection.register(UINib(nibName: "SearchListCell", bundle: nil), forCellWithReuseIdentifier: "SearchListCell")
        
        
        searchBar.delegate = self
        searchBar.placeholder = "Search Movie..."
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width - 20, height: 190)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collection.collectionViewLayout = layout
        
    }
    
    private func setUpBindings() {
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.collection.reloadData()
            }
        }
    }
}

extension SearchViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchListCell", for: indexPath) as! SearchListCell
        
        let movie = viewModel.getMovie(at: indexPath.item)
        cell.configure(movie: movie)
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//        let selectedMovie = viewModel.getMovie(at: indexPath.item)
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
//    }
}

extension SearchViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchMovie(query: searchText)
    }
        
       
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            viewModel.searchMovie(query: "")
            searchBar.text = ""
            searchBar.resignFirstResponder()
        }
    }

