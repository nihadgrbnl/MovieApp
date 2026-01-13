//
//  SearchListCell.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 13.01.26.
//

import UIKit

class SearchListCell: UICollectionViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var runtimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
        self.layer.cornerRadius = 12
        
    }
    
    private func configureUI() {
        posterImage.layer.cornerRadius = 25
        posterImage.clipsToBounds = true
        
        
    }
    
    func configure(movie : MovieModel) {
        titleLabel.text = movie.title
        
        if !movie.genre!.isEmpty {
            let allGenres = movie.genre?.joined(separator: ", ")
            genreLabel.text = allGenres
        } else {
            genreLabel.text = ""
        }
        
        if let releaseDate = movie.releaseDate {
            releaseDateLabel.text = "\(releaseDate)"
        } else {
            releaseDateLabel.text = "--"
        }
        
        if let runtime = movie.runtime {
            runtimeLabel.text = "\(runtime) minutes"
        } else {
            runtimeLabel.text = "--"
        }
        
        posterImage.image = UIImage(named: movie.posterImage!)
        
    }
    
    

}

