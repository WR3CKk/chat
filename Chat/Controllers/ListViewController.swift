//
//  ListViewController.swift
//  Chat
//
//  Created by Alexander on 07.09.2021.
//

import UIKit
import Firebase

class ListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var usersArray = [String]()
    var filteredUsers = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
    }
    
    
}


//MARK: - UITableView methods

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK: - UISearchBarDelegate

extension ListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredUsers = []

        if searchText == "" {
            filteredUsers = usersArray
        } else {
            for user in usersArray {
                if user.lowercased().contains(searchText.lowercased()) {
                    filteredUsers.append(user)
                }
            }
        }
        
        tableView.reloadData()
    }
    
}
