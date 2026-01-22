//
//  MovieGridCell.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 09.01.26.
//

import UIKit
import SDWebImage

class MovieGridCell: UICollectionViewCell {

    @IBOutlet weak var gridPosterImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        gridPosterImage.layer.cornerRadius = 12
        gridPosterImage.clipsToBounds = true
    }
    
    func configure(movie: Movie) {
        if let path = movie.posterPath {
            let fullURL = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
            gridPosterImage.sd_setImage(with: fullURL)
        }
    }

}
