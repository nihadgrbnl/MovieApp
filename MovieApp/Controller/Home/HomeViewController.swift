//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 07.01.26.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {

    @IBOutlet weak var collection: UICollectionView!
    
    private let viewModel = HomeViewModel()
    
    let manager = MovieService.shared
    var movieItems = [MovieModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureData()
    }
    
    private func configureUI() {
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: "HomeHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HomeHeader")
        collection.register(UINib(nibName: "MovieGridCell", bundle: nil), forCellWithReuseIdentifier: "MovieGridCell")
        collection.backgroundColor = .appMainBackground
        
    }
    
    private func configureData() {
            viewModel.onDataUpdated = { [weak self] in
                DispatchQueue.main.async {
                    print(" Film count: \(self?.viewModel.gridMovies.count ?? 0)") 
                    self?.collection.reloadData()
                }
            }
            viewModel.fetchData()
        }
    

}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
 
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.gridMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
            let movie = viewModel.gridMovies[indexPath.item]
            cell.layer.cornerRadius = 20

            cell.configure(movie: movie)
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let totalWidth = collectionView.frame.width
            
            let padding : CGFloat = 60
            let cellwidth = (totalWidth - padding) / 3
            return CGSize(width: cellwidth, height: cellwidth * 1.5)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 100, left: 10, bottom: 10, right: 10)
        }
    
       func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
           let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HomeHeader", for: indexPath) as! HomeHeader
           header.configure(movies: viewModel.trendingMovies)
           return header
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
           .init(width: 144, height: 210)
       }
    
    
    
}

#Preview {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: "HomeViewController")
}
