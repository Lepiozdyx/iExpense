//
//  ContentView.swift
//  iExpense
//
//  Created by Alex on 09.11.2023.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

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

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    private var personalExpenses: [ExpenseItem] {
        expenses.items.filter { $0.type == "Personal" }
    }
    
    private var businessExpenses: [ExpenseItem] {
        expenses.items.filter { $0.type == "Business" }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section(!personalExpenses.isEmpty 
                            ? "Personal expenses"
                            : "There will be your personal expenses.."
                ) {
                    ForEach(personalExpenses) { item in
                        ExpensesRowView(
                            item: item,
                            color: .gray,
                            font: fontForAmount(item.amount)
                        )
                    }
                    .onDelete { offsets in
                        removeItems(at: offsets, from: "Personal")
                    }
                }
                
                Section(!businessExpenses.isEmpty 
                            ? "Business expenses"
                            : "There will be your business expenses.."
                ) {
                    ForEach(businessExpenses) { item in
                        ExpensesRowView(
                            item: item,
                            color: .teal,
                            font: fontForAmount(item.amount)
                        )
                    }
                    .onDelete { offsets in
                        removeItems(at: offsets, from: "Business")
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    private func removeItems(at offsets: IndexSet, from type: String) {
        let itemsToRemove = type == "Personal" ? personalExpenses : businessExpenses
        for offset in offsets {
            if let index = expenses.items.firstIndex(of: itemsToRemove[offset]) {
                expenses.items.remove(at: index)
            }
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
