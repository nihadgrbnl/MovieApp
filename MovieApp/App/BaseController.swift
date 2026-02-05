//
//  BaseController.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 03.02.26.
//

import UIKit

class BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureViewModel()
        configureConstraints()
    }
    
    func configureUI() {}
    
    func configureViewModel() {}
    
    func configureConstraints() {}
   
}
