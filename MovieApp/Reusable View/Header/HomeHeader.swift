//
//  HomeHeader.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 09.01.26.
//

import UIKit

class HomeHeader: UICollectionReusableView {
    @IBOutlet weak var collection: UICollectionView!
    
    private var movies : [MovieModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpCollectionView()
    }
    
    func setUpCollectionView () {
        collection.delegate = self
        collection.dataSource = self
        
        collection.register(UINib(nibName: "TrendingMovieCell", bundle: nil),
                            forCellWithReuseIdentifier: "TrendingMovieCell")
        collection.backgroundColor = .appMainBackground

    }
    
    func configure(movies : [MovieModel]) {
        self.movies = movies
        collection.reloadData()
    }
    
}

extension HomeHeader : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingMovieCell", for: indexPath) as! TrendingMovieCell
        
        let movie = movies[indexPath.item]
        
        cell.configure(movie: movie, rank: indexPath.item + 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 144, height: collectionView.frame.height)
        
    }
}
