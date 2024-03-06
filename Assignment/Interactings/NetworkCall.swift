//
//  NetworkCall.swift
//  CodeExercise
//
//  Created by Gauravkumar Thummar on 2022-04-22.
//

import Foundation

class NetworkCall: ObservableObject {
    func getTransaction(_ completion: @escaping (AnyObject?) -> Void) {
        if let path = Bundle.main.path(forResource: "transaction-list", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let decoder = JSONDecoder()
                    do {
                        // get the data from JSON file with help of struct and Codable
                        let transactionsModel = try decoder.decode(Transactions.self, from: data)
                        // from here you can populate data in tableview
                        completion(transactionsModel as AnyObject)
                    }catch{
                        print(error) // shows error
                        print("Decoding failed")// local message
                    }
                } catch {
                    print(error) // shows error
                    print("Unable to read file")// local message
                }
            }
        }
    }

