//
//  AddView.swift
//  iExpense
//
//  Created by Alex on 09.11.2023.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: ExpensesViewModel
    
    let types = ["Personal", "Business"]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name of expense..", text: $viewModel.name)
                
                Picker("Type", selection: $viewModel.type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $viewModel.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close", role: .cancel, action: { dismiss() })
                        .foregroundStyle(.red)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.saveNewExpenses()
                        dismiss()
                    }
                    .disabled(viewModel.isDisable())
                }
            }
        }
    }
}

#Preview {
    AddView()
        .environmentObject(ExpensesViewModel())
}
