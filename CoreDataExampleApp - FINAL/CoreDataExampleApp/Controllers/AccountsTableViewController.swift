//
//  AccountsTableViewController.swift
//  CoreDataExampleApp
//
//  Created by Jason Ji on 11/30/17.
//  Copyright © 2017 Jason Ji. All rights reserved.
//

import UIKit
import CoreData

class AccountsTableViewController: UITableViewController {
    
    var accounts: [Account] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAccounts()
    }
    
    func fetchAccounts() {
        // TODO: fetch existing Accounts saved in Core Data
        let fetchRequest: NSFetchRequest<Account> = Account.fetchRequest()
        accounts = try! AppDelegate.persistentContainer.viewContext.fetch(fetchRequest)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let account = accounts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "accountCell", for: indexPath)
        
        cell.textLabel?.text = account.accountName
        cell.detailTextLabel?.text = account.accountId
        
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
                let account = accounts[indexPath.row]
                let transactionsVC = segue.destination as! TransactionsTableViewController
                transactionsVC.account = account
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
        
        let account = Account(context: AppDelegate.persistentContainer.viewContext)
        account.accountName = accountName
        account.accountId = accountId
        accounts.append(account)
        
        try! AppDelegate.persistentContainer.viewContext.save()
        
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
}
