//
//  LoginViewController.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 06.01.26.
//

import UIKit

class LoginViewController: UIViewController {
    
    var users = [User]()
    
    @IBOutlet weak var loginBanner: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureUI()
        loadDataFromFile()
    }
    
    func configureUI () {
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeHolder])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeHolder])
        
        usernameTextField.layer.masksToBounds = true
        
        //        passwordTextField.layer.cornerRadius = 12
        passwordTextField.layer.masksToBounds = true
        
        loginBtn.layer.cornerRadius = 12
        loginBtn.layer.masksToBounds = true
        
        let freeSpaceUsername = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 10))
        usernameTextField.leftView = freeSpaceUsername
        usernameTextField.leftViewMode = .always
        
        let freeSpacePassword = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 10))
        passwordTextField.leftView = freeSpacePassword
        passwordTextField.leftViewMode = .always
        
    }
    
    private func getFilePath() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        let url = urls[0].appendingPathComponent("UserList.json")
        
        //        print(url)
        return url
    }
    
    private func loadDataFromFile() {
        let fileURL = getFilePath()
                if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                let data = try Data(contentsOf: fileURL)
                users = try JSONDecoder().decode([User].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        } else {
        }
    }
    
    @IBAction func loginBtnTapped(_ sender: Any) {
        
        loadDataFromFile()
        
        if let username = usernameTextField.text,
           let password = passwordTextField.text {
            
            if users.contains(where: { $0.username == username && $0.password == password }) {
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainTabBar = storyboard.instantiateViewController(withIdentifier: "MainTabBarViewController")
                
                if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate,
                   let window = sceneDelegate.window {
                    
                    window.rootViewController = mainTabBar
                }
                
            } else {
                let alert = UIAlertController(title: "Error", message: "Invalid username or password", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                present(alert, animated: true)
            }
        }
    }
    
    @IBAction func signUpBtnTapped(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "\(RegisterViewController.self)") as! RegisterViewController
        present(controller, animated: true)
    }
}
