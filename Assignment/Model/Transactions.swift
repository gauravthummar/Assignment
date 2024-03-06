//
//  Transactions.swift
//  Assignment
//
//  Created by Gauravkumar Thummar on 2022-04-22.
//

import Foundation

struct Transactions: Codable, Hashable {
    let transactions: [transaction]?
}
 
struct transaction: Codable, Hashable {
    public static let empty = transaction.init(transaction_type: "", merchant_name: "", description: "", amount: Amount(value: 0.0))
    
    let transaction_type: String
    let merchant_name: String
    let description: String?
    let amount: Amount
}

struct Amount: Codable, Hashable {
    let value: Float
}
