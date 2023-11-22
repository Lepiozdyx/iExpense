//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Alex on 22.11.2023.
//

import Foundation

struct ExpenseItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
