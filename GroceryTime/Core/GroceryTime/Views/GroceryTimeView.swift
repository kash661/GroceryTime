//
//  GroceryTimeView.swift
//  GroceryTime
//
//  Created by Akash Desai on 2023-05-24.
//

import SwiftUI

struct GroceryTimeView: View {
    
    @ObservedObject private var viewModel: GroceryTimeViewModel
    
    init(viewModel: GroceryTimeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            groceryListView
                .navigationTitle("Grocery List")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            // Perform action when plus button is tapped
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
        }
    }
}

private extension GroceryTimeView {
    var groceryListView: some View {
        List {
            ForEach(viewModel.checklistItems) { item in
                HStack {
                    Image(systemName: item.isChecked ? "checkmark.square.fill" : "square")
                        .foregroundColor(item.isChecked ? .green : .black)
                        .padding(.trailing)
                    Text(item.text)
                    Spacer()
                }
                .padding(.vertical)
                .contentShape(Rectangle()) // Make the entire row tappable
                .onTapGesture {
                    viewModel.toggleItem(item)
                }
                .listRowSeparator(.hidden)
            }
            .onDelete(perform: viewModel.deleteItem) // Add onDelete modifier
        }
        .listStyle(.plain)
    }
}


struct GroceryTimeView_Previews: PreviewProvider {
    static var previews: some View {
        GroceryTimeView(viewModel: GroceryTimeViewModel())
    }
}
