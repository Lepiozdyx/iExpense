//
//  ExpensesRowView.swift
//  iExpense
//
//  Created by Alex on 11.11.2023.
//

import SwiftUI

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
                    .foregroundStyle(color)
            }
            
            Spacer()
            
            Text(expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .font(font)
        }
    }
}

#Preview {
    ExpensesRowView(expense: Expenses(
        name: "Lunch",
        type: "Business",
        amount: 599
    ), color: .gray, font: .body)
}
