//
//  WelcomeViewController.swift
//  Chat
//
//  Created by Alexander on 07.09.2021.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.isNavigationBarHidden = true
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            navigationController?.isNavigationBarHidden = false
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            titleLabel.text = ""
            var charIndex = 0.0
            let titleText = "⚡️FlashChat"
            for letter in titleText {
                Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                    self.titleLabel.text?.append(letter)
                }
                charIndex += 1
            }
           
        }
    
    
    
}
