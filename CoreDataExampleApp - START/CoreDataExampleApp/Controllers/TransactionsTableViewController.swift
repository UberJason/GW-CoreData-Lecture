//
//  TransactionsTableViewController.swift
//  CoreDataExampleApp
//
//  Created by Jason Ji on 11/30/17.
//  Copyright © 2017 Jason Ji. All rights reserved.
//

import UIKit

class TransactionsTableViewController: UITableViewController {

    // TODO: declare Account, Transactions
    
    let currencyFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .currency
        return f
    }()
    let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        return f
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: set title as Account title
        
        reloadTransactionsArray()
    }
    
    func reloadTransactionsArray() {
        // TODO: get transactions from Account and sort by date
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: implement using number of Transactions
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as! TransactionCell
        
        // TODO: set cell.nameLabel, cell.amountLabel, cell.dateLabel
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        if identifier == "addTransactionSegue" {
            let navVC = segue.destination as! UINavigationController
            let addTransactionVC = navVC.topViewController as! AddTransactionTableViewController
            addTransactionVC.delegate = self
        }
    }
}

extension TransactionsTableViewController: AddTransactionDelegate {
    func didCancel() {
        dismiss(animated: true, completion: nil)
    }
    func didCreateTransaction(_ transactionData: TransactionData) {
        // TODO: create Transaction from TransactionData struct,
        // assign to this Account,
        // add to transactions array
        
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
}
