//
//  Expenses.swift
//  iExpense
//
//  Created by Alex on 22.11.2023.
//

import Foundation

@Observable
final class Expenses {
    var items: [ExpenseItem] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.setValue(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode(
                [ExpenseItem].self,
                from: savedItems
            ) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}
