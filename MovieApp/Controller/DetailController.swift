//
//  DetailController.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 12.01.26.
//

import UIKit

class DetailController: UIViewController {

    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie : MovieModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()

    }
    
    private func configureUI() {
        guard let movie = movie else { return }
        
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        
        if let date = movie.releaseDate {
            releaseDateLabel.text = "\(date)"
        }
        
        if let backdropPath = movie.backdropImage {
            backdropImage.image = UIImage(named: backdropPath)
        }
        
        if let posterPath = movie.posterImage {
            posterImage.image = UIImage(named: posterPath)
        }
        
        posterImage.layer.cornerRadius = 12
        posterImage.clipsToBounds = true
        
        backdropImage.contentMode = .scaleAspectFill
    }
    
}
