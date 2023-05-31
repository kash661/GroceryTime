//
//  AddItemView.swift
//  GroceryTime
//
//  Created by Akash Desai on 2023-05-26.
//

import SwiftUI

struct AddItemView: View {
    @ObservedObject private var viewModel: AddItemViewModel
    @Environment(\.presentationMode) var presentationMode

    init(viewModel: AddItemViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            addItemSection
            itemsListSection
            submitButton
        }
    }
}

private extension AddItemView {
    var addItemSection: some View {
        VStack {
            Text("Add Items")
                .font(.title2)
                .bold()
            VStack {
                HStack {
                    Text("Name:")
                        .padding(.leading)
                    TextField("New Item", text: $viewModel.newItemName)
                        .padding()
                }
                HStack {
                    Text("Qty:")
                        .padding(.leading)
                    TextField("Quantity", text: $viewModel.newItemQuantity)
                        .padding()
                        .keyboardType(.numberPad)
                }
                HStack {
                    Button(action: {
                        viewModel.addItemToList()
                    }, label: {
                        Text(viewModel.addButtonText)
                    })
                    .padding()
                }.padding(.horizontal)
            }
        }
    }
    
    var itemsListSection: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
            VStack {
                List {
                    ForEach(viewModel.groceryGroup.items, id: \.self) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text("Qty: \(item.quantity)")
                            }
                            Spacer()
                            Image(systemName: "minus.circle")
                                .foregroundColor(.red)
                                .onTapGesture {
                                    viewModel.deleteItem(item)
                                }
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .padding()
        }
    }
    
    var submitButton: some View {
        Button(action: {
            viewModel.submitTapped()
            switch viewModel.addItemStatus {
            case .creating:
                viewModel.dismiss()
            case .adding:
                presentationMode.wrappedValue.dismiss()
            }
        }, label: {
            Text(viewModel.submitButtonName)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        })
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(viewModel: AddItemViewModel(groceryGroup: GroceryGroup(uniqueName: "", creator: "", startDate: Date(), endDate: Date(), items: []), addItemStatus: .creating, dismiss: {}))
    }
}
