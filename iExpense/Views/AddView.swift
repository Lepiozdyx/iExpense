//
//  AddView.swift
//  iExpense
//
//  Created by Alex on 09.11.2023.
//

import SwiftUI
import SwiftData

struct AddView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var expense: Expenses
    
    let types = ["Personal", "Business"]
    
    var body: some View {
            Form {
                TextField("Name of expense..", text: $expense.name)
                    .onChange(of: expense.name) {
                        expense.isModified = true
                    }
                
                Picker("Type", selection: $expense.type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .navigationBarTitleDisplayMode(.inline)
            .onDisappear {
                if !expense.isModified {
                    modelContext.delete(expense)
                }
            }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Expenses.self, configurations: config)
        let example = Expenses(name: "", type: "Personal", amount: 0)
        return AddView(expense: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
