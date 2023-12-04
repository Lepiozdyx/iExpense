//
//  ExpensesView.swift
//  iExpense
//
//  Created by Alex on 04.12.2023.
//

import SwiftUI
import SwiftData

struct ExpensesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expenses]
    
    var body: some View {
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
    }
    
    init(type: ExpensesType) {
        switch type {
        case .personal:
            _expenses = Query(filter: #Predicate<Expenses> { $0.type == "Personal" }, sort: \Expenses.name)
        case .business:
            _expenses = Query(filter: #Predicate<Expenses> { $0.type == "Business" }, sort: \Expenses.name)
        case .all:
            _expenses = Query(sort: \Expenses.name)
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
    ExpensesView(type: ExpensesType.all)
}
