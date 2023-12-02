//
//  ContentView.swift
//  iExpense
//
//  Created by Alex on 09.11.2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path: [Expenses] = []
    @Query(sort: \Expenses.type) var expenses: [Expenses]
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(expenses) { expense in
                    NavigationLink(value: expense) {
                        ExpensesRowView(
                            expense: expense,
                            color: expense.type == "Personal" ? .gray : .cyan,
                            font: fontForAmount(expense.amount)
                        )
                    }
                }
                .onDelete(perform: deleteExpense)
            }
            .navigationTitle("iExpense")
            .navigationDestination(for: Expenses.self) { expense in
                AddView(expense: expense)
            }
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    let expense = Expenses(name: "", type: "Personal", amount: 0)
                    modelContext.insert(expense)
                    path = [expense]
                }
            }
        }
    }
    
    private func deleteExpense(at offsets: IndexSet) {
        for offset in offsets {
            let expense = expenses[offset]
            modelContext.delete(expense)
        }
    }
    
    private func fontForAmount(_ amount: Double) -> Font {
        return switch amount {
        case 0..<1000:
                .system(.subheadline, design: .monospaced, weight: .light)
        case 1000..<10000:
                .system(.headline, design: .monospaced, weight: .regular)
        default:
                .system(.headline, design: .monospaced, weight: .semibold)
        }
    }
}

#Preview {
    ContentView()
}
