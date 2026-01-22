//
//  TrendingMovieCell.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 09.01.26.
//

import UIKit
import SDWebImage

class TrendingMovieCell: UICollectionViewCell {
    
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var rankLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        posterImage.layer.cornerRadius  = 12
        posterImage.contentMode = .scaleAspectFill
        posterImage.clipsToBounds = true
        
        self.clipsToBounds = false
        self.contentView.clipsToBounds = false
        rankLabel.clipsToBounds = false
        self.contentView.bringSubviewToFront(rankLabel)
    }
    
    func configure(movie: Movie, rank: Int) {
        
        if let path = movie.posterPath{
            let fullURL = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
            posterImage.sd_setImage(with: fullURL)
        }
//        posterImage.image = UIImage(named: movie.posterImage!)
        
        let strokeTextAttributes: [NSAttributedString.Key : Any] = [
            .strokeColor : UIColor.clear,
            .foregroundColor : UIColor.onBoardBtn.withAlphaComponent(0.9),
                    .strokeWidth : -2.0,
            .font : UIFont.italicSystemFont(ofSize: 90)
                ]
        rankLabel.layer.shadowColor = UIColor.black.cgColor
                rankLabel.layer.shadowRadius = 1.0
                rankLabel.layer.shadowOpacity = 1.0
                rankLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
                rankLabel.layer.masksToBounds = false
        
        let rankString = String(rank)
        rankLabel.attributedText = NSAttributedString(string: rankString, attributes: strokeTextAttributes)
        
        
    }
    
}
