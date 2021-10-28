//
//  ViewController.swift
//  Chat
//
//  Created by Alexander on 07.09.2021.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    self.performAlert(message: error.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: "goToChat", sender: self)
                }
            }
        }
    }
    
    
    


}

