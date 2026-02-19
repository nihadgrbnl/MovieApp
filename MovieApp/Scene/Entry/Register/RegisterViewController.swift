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
        signUpUsername.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeHolder])
        //        signUpUsername.layer.cornerRadius = 12
        signUpUsername.layer.masksToBounds = true
        
        signUpEmail.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeHolder])
        //        signUpEmail.layer.cornerRadius = 12
        signUpEmail.layer.masksToBounds = true
        
        signUpPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeHolder])
        //        signUpPassword.layer.cornerRadius = 12
        signUpPassword.layer.masksToBounds = true
        
        signUpBtn.layer.cornerRadius = 12
        signUpBtn.layer.masksToBounds = true
        
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
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func signUpBtnTapped(_ sender: Any) {
        let username = signUpUsername.text ?? ""
        let email = signUpEmail.text ?? ""
        let password = signUpPassword.text ?? ""
        
        if username.isEmpty {
            makeAlert(titleInput: "Error", messageInput: "Please enter username.")
            return
        }
        if email.isEmpty {
            makeAlert(titleInput: "Error", messageInput: "Please enter Email.")
            return
        }
        if password.isEmpty {
            makeAlert(titleInput: "Error", messageInput: "Please enter password.")
            return
        }
        if password.count < 6 {
            makeAlert(titleInput: "Security alert", messageInput: "Password must be at least 6 character.")
            return
        }
        
        let user = User(username: username, email: email, password: password)
        users.append(user)
        saveDataToFile()
        
        let successAlert = UIAlertController(title: "Success", message: "Registration created", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true)
        }
        
        successAlert.addAction(okButton)
        self.present(successAlert, animated: true)
    }
}
