//
//  Expense.swift
//  iExpress
//
//  Created by John Jeang on 6/1/21.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
  let id = UUID()
  let name: String
  let type: String
  let amount: Int
}

class Expenses: ObservableObject {
  @Published var items = [ExpenseItem](){
    didSet {
      let encoder = JSONEncoder()
      if let data = try? encoder.encode(items){
        UserDefaults.standard.set(data, forKey: "Items")
      }
    }
  }
  
  init() {
    if let items = UserDefaults.standard.data(forKey: "Items"){
      let decoder = JSONDecoder()
      if let decoded = try? decoder.decode([ExpenseItem].self, from: items){
        self.items = decoded
        return
      }
    }
    self.items = []
  }
  
}
