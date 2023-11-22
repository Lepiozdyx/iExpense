//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Alex on 09.11.2023.
//

import SwiftUI

@main
struct iExpenseApp: App {
    @StateObject private var viewModel = ExpensesViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
