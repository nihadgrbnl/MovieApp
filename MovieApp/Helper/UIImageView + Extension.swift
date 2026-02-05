//
//  UIImageView + Extension.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 03.02.26.
//

import Foundation
import SDWebImage

extension UIImageView {
    func loadURL(data: String) {
        let url = URL(string: NetworkHelper.shared.configureImageURL(path: data))
        sd_setImage(with: url)
    }
}
