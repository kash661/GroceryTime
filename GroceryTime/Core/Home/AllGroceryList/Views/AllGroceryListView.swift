//
//  AllGroceryListView.swift
//  GroceryTime
//
//  Created by Akash Desai on 2023-05-25.
//

import SwiftUI

struct AllGroceryListsView: View {
    @ObservedObject private var viewModel: AllGroceryListsViewModel
    
    init(viewModel: AllGroceryListsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            groceryListView
                .onAppear(perform: viewModel.getGroceryGroups)
        }
    }
}

private extension AllGroceryListsView {
    var groceryListView: some View {
        List {
            ForEach(viewModel.groceryGroupNames, id: \.self) { name in
                NavigationLink(
                    destination: GroceryListView(viewModel: viewModel.groceryListViewModel(selectedGroceryGroup: name))
                ) {
                    Text(name.removingAfterFirstUnderscore())
                        .font(.headline)
                }
            }
        }
        .navigationTitle("All Grocery Lists")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            leading: Button(action: {
                viewModel.logoutTapped()
            }) {
                Text("Log Out")
            },
            trailing: Button(action: {
                viewModel.createButtonTapped()
            }) {
                Text("Create")
            }
        )
    }
}

struct AllGroceryLists_Previews: PreviewProvider {
    static var previews: some View {
        AllGroceryListsView(viewModel: AllGroceryListsViewModel(uid: "", logoutTapped: {}, createButtonTapped: {}))
    }
}
