//
//  TrendingMovieCell.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 09.01.26.
//

import UIKit

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
        
        rankLabel.backgroundColor = .red
        rankLabel.collisionBoundingPath.stroke()
    }
    
    func configure(movie: MovieModel, rank: Int) {
        posterImage.image = UIImage(named: movie.posterImage!)
        
        let rankString = String(rank)
        
        let strokeTextAttributes: [NSAttributedString.Key : Any] = [
                    .strokeColor : UIColor.systemBlue, 
                    .foregroundColor : UIColor.black.withAlphaComponent(0.5),
                    .strokeWidth : -4.0,
                    .font : UIFont.systemFont(ofSize: 100, weight: .heavy)
                ]
        
        rankLabel.attributedText = NSAttributedString(string: rankString, attributes: strokeTextAttributes)
        
        
    }

}
