//
//  ContentView.swift
//  iExpense
//
//  Created by Alex on 09.11.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ExpensesViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                Section(!viewModel.personalExpenses.isEmpty
                            ? "Personal expenses"
                            : "There will be your personal expenses.."
                ) {
                    ForEach(viewModel.personalExpenses) { item in
                        ExpensesRowView(
                            item: item,
                            color: .gray,
                            font: fontForAmount(item.amount)
                        )
                    }
                    .onDelete { offsets in
                        viewModel.removeItems(at: offsets, from: "Personal")
                    }
                }
                
                Section(!viewModel.businessExpenses.isEmpty
                            ? "Business expenses"
                            : "There will be your business expenses.."
                ) {
                    ForEach(viewModel.businessExpenses) { item in
                        ExpensesRowView(
                            item: item,
                            color: .teal,
                            font: fontForAmount(item.amount)
                        )
                    }
                    .onDelete { offsets in
                        viewModel.removeItems(at: offsets, from: "Business")
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    viewModel.showingAddExpense = true
                }
            }
            .sheet(isPresented: $viewModel.showingAddExpense) {
                AddView(viewModel: viewModel)
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
