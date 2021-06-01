//
//  ContentView.swift
//  iExpress
//
//  Created by John Jeang on 5/31/21.
//

import SwiftUI

struct ContentView: View {
  
  @State var isShowingAddExpense = false
  
  @ObservedObject var expenses = Expenses()
  
  var body: some View {
    NavigationView{
      List{
        ForEach(expenses.items){ item in
          HStack{
            VStack{
              Text(item.name)
                .font(.headline)
              Text(item.type)
            }
            Spacer()
            Text("\(item.amount)")
          }

        }
        .onDelete(perform: removeItem)
      }
      .navigationBarTitle("iExpense")
      .navigationBarItems(trailing:
                            Button(action: {
                              isShowingAddExpense = true
                            }, label: {
                              Image(systemName:"plus")
                            })
      )
    }
    .sheet(isPresented: $isShowingAddExpense, content: {
      AddView(expenses: expenses)
    })
  }
  func removeItem(at offset: IndexSet){
    expenses.items.remove(atOffsets: offset)
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
