//
//  GroceryListViewModel.swift
//  GroceryTime
//
//  Created by Akash Desai on 2023-05-27.
//

import Foundation
import Firebase

class GroceryListViewModel: ObservableObject {
    
    enum GrocerListViewState {
        case empty
        case loading
        case loaded
        case error
    }
    
    @Published var groceryGroup: GroceryGroup?
    @Published var viewState: GrocerListViewState = .loading
    var selectedGroceryGroup: String
    
    private let dateFormatter = DateFormatter()
    
    init(selectedGroceryGroup: String) {
        self.selectedGroceryGroup = selectedGroceryGroup
    }
    
    func getGroceryList() {
        self.viewState = .loading
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let reference = Database.database().reference().child("GroceryTime").child("lists").child(selectedGroceryGroup)
        
        reference.observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                print("Invalid snapshot format.")
                print("Snapshot value: \(snapshot.value ?? "")")
                return
            }
            
            guard let strongSelf = self else { return }
            
            var groceryItems: [Item] = []
            
            if let groceryItemsData = value["items"] as? [[String: Any]] {
                for itemData in groceryItemsData {
                    guard let id = itemData["id"] as? String,
                          let name = itemData["name"] as? String,
                          let quantity = itemData["quantity"] as? Int,
                          let isChecked = itemData["isChecked"] as? Bool
                    else {
                        continue
                    }
                    let stringValue = id
                    if let uuid = UUID(uuidString: stringValue) {
                        let item = Item(id: uuid, name: name, quantity: quantity, isChecked: isChecked)
                        groceryItems.append(item)
                    }
                }
            }
            strongSelf.viewState = groceryItems.isEmpty ? .empty : .loaded

            let uniqueName = value["uniqueName"] as? String ?? ""
            let creator = value["creator"] as? String ?? ""
            
            if let startDateString = value["startDate"] as? String,
               let endDateString = value["endDate"] as? String,
               let startDate = strongSelf.dateFormatter.date(from: startDateString),
               let endDate = strongSelf.dateFormatter.date(from: endDateString) {
                let groceryGroup = GroceryGroup(uniqueName: uniqueName, creator: creator, startDate: startDate, endDate: endDate, items: groceryItems)
                strongSelf.groceryGroup = groceryGroup
            }
        } withCancel: { error in
            print("Error fetching grocery items:", error.localizedDescription)
            self.viewState = .error
        }
    }
    
    func addItemViewModel() -> AddItemViewModel {
        let uniqueName = groceryGroup?.uniqueName ?? ""
        let startDate = groceryGroup?.startDate ?? Date()
        let endDate = groceryGroup?.endDate ?? Date()
        let items = groceryGroup?.items ?? []
        
        return AddItemViewModel(groceryGroup:
                                    GroceryGroup(
                                        uniqueName: uniqueName,
                                        creator: "",
                                        startDate: startDate,
                                        endDate: endDate,
                                        items: items),
                                addItemStatus: .adding,
                                dismiss: {}
        )
    }
    
    func groceryListCellViewModel(selectedItem: Item) -> GroceryListCellViewModel {
        GroceryListCellViewModel(item: selectedItem)
    }
    
    func updateDataBase() {
        Database.database().reference().child("GroceryTime")
            .child("lists")
            .child(selectedGroceryGroup)
            .child("items")
            .setValue(groceryGroup?.itemsDictionaryRepresentation())
    }
}
