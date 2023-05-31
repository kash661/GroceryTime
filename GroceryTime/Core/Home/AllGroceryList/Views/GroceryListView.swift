//
//  GroceryListView.swift
//  GroceryTime
//
//  Created by Akash Desai on 2023-05-27.
//

import SwiftUI

struct GroceryListView: View {
    @ObservedObject private var viewModel: GroceryListViewModel
    @State var isChecked: Bool = false
    
    init(viewModel: GroceryListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            switch viewModel.viewState {
            case .empty:
                ZStack {
                    VStack {
                        Text("Start Shopping!")
                            .font(.title)
                            .bold()
                        Text("Add an Item")
                            .font(.title2)
                    }
                    HStack {
                        Spacer()
                        addButton
                    }
                }
            case .error:
                ZStack {
                    VStack {
                        Text("Error Loading ...")
                            .font(.title)
                            .bold()
                            .foregroundColor(.red)
                    }
                    HStack {
                        Spacer()
                        addButton
                    }
                }
            case .loaded:
                ZStack(alignment: .bottomTrailing) {
                    groceryList
                    addButton
                }
            case .loading:
                VStack {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onAppear {
            viewModel.getGroceryList()
        }
    }
}

private extension GroceryListView {
    
    var groceryList: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible(), spacing: 16)], spacing: 16) {
                if let items = viewModel.groceryGroup?.items {
                    ForEach(items, id: \.self) { item in
                        GroceryListViewCell(item: item, isChecked: Binding(get: {
                            item.isChecked
                        }, set: { newValue in
                            if let index = items.firstIndex(where: { $0.id == item.id }) {
                                viewModel.groceryGroup?.items[index].isChecked = newValue
                                viewModel.updateDataBase()
                            }
                        }))
                    }
                }
            }
            .padding(16)
        }
    }
    
    var addButton: some View {
        VStack {
            Spacer()
            NavigationLink(destination: AddItemView(viewModel: viewModel.addItemViewModel())) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.blue)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 16))
            .offset(x: -16, y: -16)
        }
    }
}

struct GroceryListView_Previews: PreviewProvider {
    static var previews: some View {
        GroceryListView(viewModel: GroceryListViewModel(selectedGroceryGroup: ""))
    }
}
