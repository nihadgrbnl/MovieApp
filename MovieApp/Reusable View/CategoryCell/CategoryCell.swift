//
//  CategoryCell.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 12.01.26.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    private let lineView: UIView = {
            let view = UIView()
        view.backgroundColor = .orangeLetterboxd
            view.translatesAutoresizingMaskIntoConstraints = false
            view.isHidden = true
            return view
        }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        contentView.addSubview(lineView)
                NSLayoutConstraint.activate([
                    lineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                    lineView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                    lineView.widthAnchor.constraint(equalToConstant: 100),
                    lineView.heightAnchor.constraint(equalToConstant: 2)
                ])
    }
    
    func configure(title: String, isSelected: Bool) {
            titleLabel.text = title
            
            if isSelected {
                titleLabel.textColor = .white
                titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
                lineView.isHidden = false
            } else {
                titleLabel.textColor = .gray
                titleLabel.font = .systemFont(ofSize: 16, weight: .regular)
                lineView.isHidden = true
            }
        }

}
