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
        //Placeholder color change: Login
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeHolder])
        
        //Placeholder color change: Login
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeHolder])
        
//        usernameTextField.layer.cornerRadius = 12
        usernameTextField.layer.masksToBounds = true
        
//        passwordTextField.layer.cornerRadius = 12
        passwordTextField.layer.masksToBounds = true
        
        loginBtn.layer.cornerRadius = 12
        loginBtn.layer.masksToBounds = true
        
        //Padding:Login
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
        do {
            let data = try Data(contentsOf: getFilePath())
            users = try JSONDecoder().decode([User].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func loginBtnTapped(_ sender: Any) {
        
        loadDataFromFile()
        
        if let username = usernameTextField.text,
           let password = passwordTextField.text {
            
            if users.contains(where: { $0.username == username && $0.password == password }) {
                
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                
                let controller = storyboard?.instantiateViewController(withIdentifier: "\(MainTabBarViewController.self)") as! MainTabBarViewController
                navigationController?.show(controller, sender: nil)
                
            } else {
                let alert = UIAlertController(title: "Invalid Attempt", message: "Please check your username or password", preferredStyle: .alert)
                
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
