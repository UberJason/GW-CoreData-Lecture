//
//  AddAccountViewController.swift
//  CoreDataExampleApp
//
//  Created by Jason Ji on 11/30/17.
//  Copyright © 2017 Jason Ji. All rights reserved.
//

import UIKit

protocol AddAccountDelegate: class {
    func didCreateAccount(named accountName: String, withId accountId: String)
    func didCancel()
}

class AddAccountTableViewController: UITableViewController {

    let cellTitles = ["Account Name", "Account ID"]
    var accountName: String?
    var accountId: String?

    weak var delegate: AddAccountDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        delegate?.didCancel()
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        tableView.endEditing(true)
        
        guard let accountName = accountName, let accountId = accountId else {
            let alert = UIAlertController(title: "Error", message: "Enter an account name and an account ID.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        delegate?.didCreateAccount(named: accountName, withId: accountId)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
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

extension AddAccountTableViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            accountName = textField.text
        case 1:
            accountId = textField.text
        default: break
        }
    }
}
