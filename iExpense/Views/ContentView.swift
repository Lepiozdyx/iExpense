//
//  ContentView.swift
//  iExpense
//
//  Created by Alex on 09.11.2023.
//

import SwiftUI
import SwiftData

enum ExpensesType: String, CaseIterable {
    case personal = "Personal"
    case business = "Business"
    case all = "All"
}

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path: [Expenses] = []
    @State private var showingType: ExpensesType = .all
    @State private var sortOrder = [
        SortDescriptor(\Expenses.type),
        SortDescriptor(\Expenses.name),
        SortDescriptor(\Expenses.amount)
    ]
    
    var body: some View {
        NavigationStack(path: $path) {
            ExpensesView(type: showingType, sortOrder: sortOrder)
            .navigationTitle("iExpense")
            .navigationDestination(for: Expenses.self) { expense in
                AddView(expense: expense)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Expense", systemImage: "plus") {
                        let expense = Expenses(name: "", type: "Personal", amount: 0)
                        modelContext.insert(expense)
                        path = [expense]
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Menu("Sort", systemImage: "line.3.horizontal.decrease.circle") {
                        Picker("Types", selection: $showingType) {
                            ForEach(ExpensesType.allCases, id: \.self) { type in
                                Text(type.rawValue)
                                    .tag(type)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
