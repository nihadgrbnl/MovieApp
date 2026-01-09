//
//  MovieGridCell.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 09.01.26.
//

import UIKit

class MovieGridCell: UICollectionViewCell {

    @IBOutlet weak var gridPosterImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        gridPosterImage.layer.cornerRadius = 12
        gridPosterImage.clipsToBounds = true
    }
    
    func configure(movie: MovieModel) {
        gridPosterImage.image = UIImage(named: movie.posterImage!)
    }

}
