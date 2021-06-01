//
//  AddView.swift
//  iExpress
//
//  Created by John Jeang on 6/1/21.
//

import SwiftUI

struct AddView: View {
  @State private var name = ""
  @State private var type = "Personal"
  @State private var amount = ""
  @ObservedObject var expenses: Expenses
  @Environment(\.presentationMode) var presentationMode
  
  
  static let types = ["Business", "Personal"]
  
  var body: some View {
    NavigationView{
      Form{
        TextField("Add Name", text: $name)
        Picker("Add type", selection: $type) {
          ForEach(Self.types, id: \.self){
            Text($0)
          }
        }
        TextField("Add amount", text: $amount)
      }
      .navigationBarTitle("Add Expense")
      .navigationBarItems(trailing:
                            Button("Save"){
                              if let intAmount = Int(amount){
                                let item = ExpenseItem(name: name, type: type, amount: intAmount)
                                expenses.items.append(item)
                              }
                              presentationMode.wrappedValue.dismiss()
                            }
      )
    }

  }
}

struct AddView_Previews: PreviewProvider {
  static var previews: some View {
    AddView(expenses: Expenses())
  }
}
