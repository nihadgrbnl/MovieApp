//
//  OnBoardController.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 06.01.26.
//

import UIKit

class OnBoardController: UIViewController {

    @IBOutlet weak var bannerImage: UIImageView!
    
    @IBOutlet weak var onBoardLogo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func onBoardBtnTapped(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "\(LoginViewController.self)") as! LoginViewController
        navigationController?.show(controller, sender: nil)
    }
}
