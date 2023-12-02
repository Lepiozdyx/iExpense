//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Alex on 09.11.2023.
//

import SwiftUI
import SwiftData

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expenses.self)
    }
}
