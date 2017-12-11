//
//  AddTransactionTableViewController.swift
//  CoreDataExampleApp
//
//  Created by Jason Ji on 11/30/17.
//  Copyright © 2017 Jason Ji. All rights reserved.
//

import UIKit

protocol AddTransactionDelegate: class {
    func didCreateTransaction(_ transactionData: TransactionData)
    func didCancel()
}

struct TransactionData {
    let name: String
    let amount: Double
    let date: Date
}

class AddTransactionTableViewController: UITableViewController {

    let cellTitles = ["Transaction Name", "Amount", "Date"]
    var transactionName: String?
    var transactionAmount: Double?
    var transactionDate: Date?
    
    let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "MM/dd/yyyy"
        return f
    }()
    
    weak var delegate: AddTransactionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func cancelTapped(_ sender: Any) {
        delegate?.didCancel()
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        tableView.endEditing(true)
        
        guard let transactionName = transactionName, let transactionAmount = transactionAmount, let transactionDate = transactionDate else {
            let alert = UIAlertController(title: "Error", message: "Enter transaction name, amount and date.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        delegate?.didCreateTransaction(TransactionData(name: transactionName, amount: transactionAmount, date: transactionDate))
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelTextFieldCell", for: indexPath) as! LabelTextFieldCell
        cell.label.text = cellTitles[indexPath.row]
        cell.textField.delegate = self
        cell.textField.tag = indexPath.row
        return cell
    }
}

extension AddTransactionTableViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        switch textField.tag {
        case 0:
            transactionName = text
        case 1:
            transactionAmount = Double(text)
        case 2:
            transactionDate = dateFormatter.date(from: text)
        default: break
        }
    }
}
