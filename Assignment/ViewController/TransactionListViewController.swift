//
//  ViewController.swift
//  Assignment
//
//  Created by Gauravkumar Thummar on 2022-04-22.
//

import UIKit

class TransactionListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var transactionArray: [transaction] = []
    @IBOutlet private weak var transactionTable: UITableView?
    private let networkCall = NetworkCall()
    var selectedIndexPath: IndexPath?
    
    // MARK: - View life cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }

    func setupData() {
        networkCall.getTransaction { [weak self] result in
            if let transactionArray = result as? Transactions {
                self?.transactionArray = transactionArray.transactions ?? []
                self?.transactionTable?.delegate = self
                self?.transactionTable?.dataSource = self
                self?.transactionTable?.reloadData()
            }
        }
    }
    // MARK: - TableView Method
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  transactionArray.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath)
        // set the text from the data model
        let transaction = transactionArray[indexPath.row]
        cell.textLabel?.text = transaction.merchant_name
        if transaction.transaction_type == "DEBIT" {
            let amount = String(transaction.amount.value)
            cell.detailTextLabel?.text = "\("-$")\(amount)"
        } else {
            let amount = String(transaction.amount.value)
            cell.detailTextLabel?.text = "\("$")\(amount)"
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        selectedIndexPath = indexPath
        self.performSegue(withIdentifier: "transactionDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TransactionDetailViewController
        destinationVC.transactionDetail = transactionArray[selectedIndexPath?.row ?? 0]
    }
}

