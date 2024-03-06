//
//  TransactionDetailViewController.swift
//  Assignment
//
//  Created by Gauravkumar Thummar on 2022-04-22.
//

import Foundation
import UIKit

class TransactionDetailViewController: UIViewController, UIGestureRecognizerDelegate {
    var transactionDetail: transaction = transaction.empty
    @IBOutlet private var mainContainer:               UIView?
    @IBOutlet private var merchantNameLabel:           UILabel?
    @IBOutlet private var amountLabel:                 UILabel?
    @IBOutlet private var transactionTypeLabel:        UILabel?
    @IBOutlet private var transactionTypeImageView:    UIImageView?
    @IBOutlet private weak var heightToolTipView:      NSLayoutConstraint?
    @IBOutlet private weak var toolTipView:            UIView?
    @IBOutlet private weak var toolTipTopLabel:        UILabel?
    @IBOutlet private weak var toolTipBottomLabel:     UILabel?
    @IBOutlet private weak var closeButton:            UIButton?
    let defaultHeight = 70.0
    let expectedHeight = 140.0
    var state: Bool = false

    // MARK: - View life cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        navigationItem.hidesBackButton = true
        merchantNameLabel?.text = transactionDetail.merchant_name
        mainContainer?.layer.masksToBounds = true
        mainContainer?.layer.borderColor = UIColor.lightGray.cgColor
        mainContainer?.layer.borderWidth = 1.0
        self.heightToolTipView?.constant = self.defaultHeight
        toolTipView?.layer.masksToBounds = true
        toolTipView?.layer.borderColor = UIColor.lightGray.cgColor
        toolTipView?.layer.borderWidth = 1.0
        if transactionDetail.transaction_type == "DEBIT" {
            let amount = String(transactionDetail.amount.value)
            amountLabel?.text = "\("-$")\(amount)"
            transactionTypeLabel?.text = "Debit transaction"
            transactionTypeImageView?.setImageColor(color: UIColor.red)

        } else {
            let amount = String(transactionDetail.amount.value)
            amountLabel?.text = "\("$")\(amount)"
            transactionTypeLabel?.text = "Credit transaction"
        }
        let toolTipTopString = NSMutableAttributedString(string: "Transactions are processed Monday to Friday (excluding holidays). Show more", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13.0, weight: .semibold)])
        toolTipTopString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemBlue, range: NSRange(location:66,length:9))
        self.toolTipTopLabel?.attributedText = toolTipTopString
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.showToolTipAction(_:)))
        toolTipView?.addGestureRecognizer(tap)
    }

    // MARK: - Action Method
    
    @IBAction private func closeButtonTapped(_ button: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func showToolTipAction(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
                self.state = !self.state
                self.heightToolTipView?.constant = CGFloat(self.state ? self.expectedHeight: self.defaultHeight)
                let toolTipBottomString = NSMutableAttributedString(string: "Transactions made before 8:30 pm ET Monday to Friday (excluding holidays) will show up in your account the same day. Show less", attributes: [NSAttributedString.Key.font :UIFont.systemFont(ofSize: 13.0, weight: .semibold)])
                toolTipBottomString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemBlue, range: NSRange(location:117,length:9))
                self.toolTipBottomLabel?.attributedText = toolTipBottomString
                if self.state {
                    let toolTipTopString = NSMutableAttributedString(string: "Transactions are processed Monday to Friday (excluding holidays).", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13.0, weight: .semibold)])
                    self.toolTipTopLabel?.attributedText = toolTipTopString
                }  else {
                    let toolTipTopString = NSMutableAttributedString(string: "Transactions are processed Monday to Friday (excluding holidays). Show more", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13.0, weight: .semibold)])
                    toolTipTopString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemBlue, range: NSRange(location:66,length:9))
                    self.toolTipTopLabel?.attributedText = toolTipTopString
                }
        })
    }
}

