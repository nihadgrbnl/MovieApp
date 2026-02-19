//
//  MovieDetailController.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 19.02.26.
//

import UIKit

class MovieDetailController: BaseController {
    
    private var viewModel : MovieDetailViewModel
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureUI() {
        view.backgroundColor = .red
    }
    
    override func configureViewModel() {
        viewModel.getMovieDetail()
    }
}
