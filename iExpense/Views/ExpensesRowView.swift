//
//  ExpensesRowView.swift
//  iExpense
//
//  Created by Alex on 11.11.2023.
//

import SwiftUI
import SwiftData

struct ExpensesRowView: View {
    let expense: Expenses
    let color: Color
    let font: Font
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(expense.name)
                    .font(.title2)
                
                Text(expense.type)
                    .font(.subheadline)
                    .foregroundStyle(color)
            }
            
            Spacer()
            
            Text(expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .font(font)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Expenses.self, configurations: config)
        let example = Expenses(name: "Lunch", type: "Business", amount: 511.99)
        return ExpensesRowView(expense: example, color: .cyan, font: .headline)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
