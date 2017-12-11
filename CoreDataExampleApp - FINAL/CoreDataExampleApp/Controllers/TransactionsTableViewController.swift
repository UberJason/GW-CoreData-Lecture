//
//  TransactionsTableViewController.swift
//  CoreDataExampleApp
//
//  Created by Jason Ji on 11/30/17.
//  Copyright © 2017 Jason Ji. All rights reserved.
//

import UIKit

class TransactionsTableViewController: UITableViewController {

    var account: Account!
    var transactions: [Transaction] = []
    
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

        title = account.accountName
        reloadTransactionsArray()
    }
    
    func reloadTransactionsArray() {
        transactions = account.transactions?.allObjects as? [Transaction] ?? []
        transactions.sort { $0.date! > $1.date! }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let transaction = transactions[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as! TransactionCell
        
        cell.nameLabel.text = transaction.name!
        cell.amountLabel.text = currencyFormatter.string(from: NSNumber(value: transaction.amount))
        cell.dateLabel.text = dateFormatter.string(from: transaction.date!)

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
        
        let transaction = Transaction(context: AppDelegate.persistentContainer.viewContext)
        transaction.name = transactionData.name
        transaction.amount = transactionData.amount
        transaction.date = transactionData.date
        transaction.account = account
//        account.addToTransactions(transaction)
        
        reloadTransactionsArray()
        try! AppDelegate.persistentContainer.viewContext.save()
        
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
}
