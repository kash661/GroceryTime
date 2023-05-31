//
//  AllGroceryListsViewModel.swift
//  GroceryTime
//
//  Created by Akash Desai on 2023-05-26.
//

import Foundation
import Firebase

class AllGroceryListsViewModel: ObservableObject {
    
    @Published var groceryGroupNames: [String] = []
    
    private let dateFormatter = DateFormatter()
    var uid: String
    var logoutTapped: () -> Void
    var createButtonTapped: () -> Void
    
    init(uid: String, logoutTapped: @escaping () -> Void, createButtonTapped: @escaping () -> Void) {
        self.uid = uid
        self.logoutTapped = logoutTapped
        self.createButtonTapped = createButtonTapped
    }
    
    func getGroceryGroups() {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let reference = Database.database().reference().child("GroceryTime").child("users").child(uid).child("groceryListsRef")
        
        reference.observe(.value) { [weak self] snapshot in
            var names: [String] = []
            if let snapshotValue = snapshot.value as? [String] {
                snapshotValue.forEach { value in
                    names.append(value)
                }
                self?.groceryGroupNames = names
            }
        } withCancel: { error in
            print(error.localizedDescription)
        }
    }
    
    func groceryListViewModel(selectedGroceryGroup: String) -> GroceryListViewModel {
        GroceryListViewModel(selectedGroceryGroup: selectedGroceryGroup)
    }
}
