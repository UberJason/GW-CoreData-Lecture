//
//  AccountsTableViewController.swift
//  CoreDataExampleApp
//
//  Created by Jason Ji on 11/30/17.
//  Copyright © 2017 Jason Ji. All rights reserved.
//

import UIKit

class AccountsTableViewController: UITableViewController {
    
    // TODO: declare [Account]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAccounts()
    }
    
    func fetchAccounts() {
        // TODO: fetch existing Accounts saved in Core Data
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: implement using number of Accounts
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "accountCell", for: indexPath)
        
        // TODO: set cell.textLabel.text, cell.detailTextLabel.text
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "addAccountSegue":
            let navVC = segue.destination as! UINavigationController
            let addAccountVC = navVC.topViewController as! AddAccountTableViewController
            addAccountVC.delegate = self
        case "showAccountSegue":
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                // TODO: Get selected account and pass it to the TransactionsTableViewController
                // ...
                let transactionsVC = segue.destination as! TransactionsTableViewController
                // ...
                
            }
            
        default: break
        }
    }
}

extension AccountsTableViewController: AddAccountDelegate {
    func didCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    func didCreateAccount(named accountName: String, withId accountId: String) {
        // TODO: create an account from the name and ID and add it to our Accounts array
        
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
}
