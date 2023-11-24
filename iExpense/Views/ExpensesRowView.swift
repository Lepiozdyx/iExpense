//
//  ExpensesRowView.swift
//  iExpense
//
//  Created by Alex on 11.11.2023.
//

import SwiftUI

struct ExpensesRowView: View {
    let item: ExpenseItem
    let color: Color
    let font: Font
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.title2)
                
                Text(item.type)
                    .foregroundStyle(color)
            }
            
            Spacer()
            
            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .font(font)
        }
    }
}

#Preview {
    ExpensesRowView(item: ExpenseItem(
        name: "Lunch",
        type: "Business",
        amount: 599
    ), color: .gray, font: .body)
}
