//
//  AddItemViewModel.swift
//  GroceryTime
//
//  Created by Akash Desai on 2023-05-26.
//

import Foundation
import Firebase

enum AddItemStatus: Equatable {
    case creating
    case adding
}

class AddItemViewModel: ObservableObject {
    
    var addItemStatus: AddItemStatus
    @Published var groceryGroup: GroceryGroup
    var dismiss: () -> Void
    
    init(
        groceryGroup: GroceryGroup,
        addItemStatus: AddItemStatus,
        dismiss: @escaping () -> Void
    ) {
        self.groceryGroup = groceryGroup
        self.addItemStatus = addItemStatus
        self.dismiss = dismiss
    }
    
    @Published var newItems: [Item] = []
    @Published var newItemName: String = ""
    @Published var newItemQuantity: String = "1"

    var submitButtonName: String {
        addItemStatus == .creating ? "Create" : "Add"
    }
    
    var addButtonText: String {
        newItemName.isEmpty ? "" : "Add"
    }
    
    func addItemToList() {
        guard !newItemName.isEmpty else {
            return
        }
        
        let newItem = Item(id: UUID(), name: newItemName, quantity: Int(newItemQuantity) ?? 1, isChecked: false)
        newItems.append(newItem)
        groceryGroup.items.append(newItem)
        resetValues()
    }
    
    func deleteItem(_ item: Item) {
        if let index = groceryGroup.items.firstIndex(of: item) {
            groceryGroup.items.remove(at: index)
        }
    }
    
    func resetValues() {
        newItemName = ""
        newItemQuantity = "1"
    }
    
    func submitTapped() {
        switch addItemStatus {
        case .creating:
            if let userId = Auth.auth().currentUser?.uid {
                Database.database().reference().ref.child("GroceryTime")
                    .child("lists")
                    .child(uniqueName())
                    .child("creator")
                    .setValue(userId)
                
                Database.database().reference().ref.child("GroceryTime")
                    .child("lists")
                    .child(uniqueName())
                    .setValue(groceryGroup.dictionaryRepresentation())
                
                let databaseRef = Database.database().reference()
                let groceryListsRef = databaseRef.child("GroceryTime")
                    .child("users")
                    .child(userId)
                    .child("groceryListsRef")
                
                groceryListsRef.observeSingleEvent(of: .value) { [weak self] snapshot in
                    var existingArray = snapshot.value as? [String] ?? []
                    if let uniqueName = self?.uniqueName(), !existingArray.contains(uniqueName) {
                        existingArray.append(uniqueName)
                        groceryListsRef.setValue(existingArray)
                    }
                }
            }
        case .adding:
            Database.database().reference().ref.child("GroceryTime")
                .child("lists")
                .child(uniqueName())
                .child("items")
                .setValue(groceryGroup.items.map { $0.dictionaryRepresentation() })
        }
    }
    
    func uniqueName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let dateString = dateFormatter.string(from: groceryGroup.startDate)
        return "\(groceryGroup.uniqueName)_\(dateString)"
    }
}
