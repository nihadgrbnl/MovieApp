//
//  RegisterViewController.swift
//  MovieApp
//
//  Created by Nihad Gurbanli on 07.01.26.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var signUpUsername: UITextField!
    @IBOutlet weak var signUpEmail: UITextField!
    @IBOutlet weak var signUpPassword: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        loadDataFromFile()
        
    }
    
    func configureUI () {
        //Placeholder color change: Login
        signUpUsername.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeHolder])
        
        //Placeholder color change: Email
        signUpEmail.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeHolder])
        
        //Placeholder color change: Login
        signUpPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeHolder])
        
        signUpUsername.layer.cornerRadius = 12
        signUpUsername.layer.masksToBounds = true
        
        signUpEmail.layer.cornerRadius = 12
        signUpEmail.layer.masksToBounds = true
        
        signUpPassword.layer.cornerRadius = 12
        signUpPassword.layer.masksToBounds = true
        
        signUpBtn.layer.cornerRadius = 12
        signUpBtn.layer.masksToBounds = true
        
        //Padding:Login
        let freeSpaceUsername = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 10))
        signUpUsername.leftView = freeSpaceUsername
        signUpUsername.leftViewMode = .always
        
        let freeSpacePassword = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 10))
        signUpPassword.leftView = freeSpacePassword
        signUpPassword.leftViewMode = .always
        
        let freeSpaceEmail = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 10))
        signUpEmail.leftView = freeSpaceEmail
        signUpEmail.leftViewMode = .always
        
    }
    
    private func getFilePath() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        let url = urls[0].appendingPathComponent("UserList.json")
        print(url)
        return url
    }
    
    private func loadDataFromFile(){
        do {
            let data = try Data(contentsOf: getFilePath())
            users = try JSONDecoder().decode([User].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func saveDataToFile () {
        do {
            let data = try JSONEncoder().encode(users)
            try data.write(to: getFilePath())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    @IBAction func signUpBtnTapped(_ sender: Any) {
        guard let username = signUpUsername.text,
              let email = signUpEmail.text,
              let password = signUpPassword.text
        else { return }
        
        let user = User(username: username, email: email, password: password)
        users.append(user)
        saveDataToFile()
        
        self.dismiss(animated: true)
    }
    
}
