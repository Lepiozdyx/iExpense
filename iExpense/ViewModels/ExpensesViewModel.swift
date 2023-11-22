//
//  ExpensesViewModel.swift
//  iExpense
//
//  Created by Alex on 22.11.2023.
//

import SwiftUI

final class ExpensesViewModel: ObservableObject {
    @Published var expenses = Expenses()
    @Published var showingAddExpense = false
    @Published var name = ""
    @Published var type = "Personal"
    @Published var amount = 0.0
    
    var personalExpenses: [ExpenseItem] {
        expenses.items.filter { $0.type == "Personal" }
    }
    
    var businessExpenses: [ExpenseItem] {
        expenses.items.filter { $0.type == "Business" }
    }
        
    func removeItems(at offsets: IndexSet, from type: String) {
        let itemsToRemove = type == "Personal" ? personalExpenses : businessExpenses
        for offset in offsets {
            if let index = expenses.items.firstIndex(of: itemsToRemove[offset]) {
                expenses.items.remove(at: index)
            }
        }
    }
    
    func saveNewExpenses() {
        let item = ExpenseItem(name: name, type: type, amount: amount)
        expenses.items.append(item)
        name = ""
        type = "Personal"
        amount = 0.0
    }
    
    func isDisable() -> Bool {
        name.isEmpty
    }
}
