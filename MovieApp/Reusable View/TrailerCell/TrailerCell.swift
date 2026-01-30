//
//  TrailerCell.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 30.01.26.
//

import UIKit
import SDWebImage

class TrailerCell: UITableViewCell {
    
    private let thumbImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.backgroundColor = .darkGray
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 2
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureConstraints()
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        addSubview(thumbImageView)
        addSubview(titleLabel)
        addSubview(typeLabel)
        
        NSLayoutConstraint.activate([
            thumbImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            thumbImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            thumbImageView.widthAnchor.constraint(equalToConstant: 100),
            thumbImageView.heightAnchor.constraint(equalToConstant: 60),
            
            titleLabel.leadingAnchor.constraint(equalTo: thumbImageView.trailingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: thumbImageView.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            typeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            typeLabel.bottomAnchor.constraint(equalTo: thumbImageView.bottomAnchor)
        ])
    }
    
    func configure(video: VideoResult) {
        titleLabel.text = video.name
        typeLabel.text = "\(video.site ?? "Video")   \(video.type ?? "Clip")"
        
        if let key = video.key, let url = URL(string: "https://img.youtube.com/vi/\(key)/mqdefault.jpg") {
            thumbImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"))
        } else {
            thumbImageView.image = UIImage(systemName: "play.slash")
        }
    }
    
}
