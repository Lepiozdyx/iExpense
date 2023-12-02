//
//  Expenses.swift
//  iExpense
//
//  Created by Alex on 22.11.2023.
//

import SwiftUI
import SwiftData

@Model
final class Expenses {
    var name: String
    var type: String
    var amount: Double
    
    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}
