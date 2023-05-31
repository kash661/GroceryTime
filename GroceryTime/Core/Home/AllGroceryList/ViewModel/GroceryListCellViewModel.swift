//
//  GroceryListCellViewModel.swift
//  GroceryTime
//
//  Created by Akash Desai on 2023-05-28.
//

import Foundation
import Firebase

class GroceryListCellViewModel: ObservableObject {
    var item: Item
    
    init(item: Item) {
        self.item = item
    }
    
    @Published var isChecked: Bool = false
    
    func toggleChecked() {
        self.isChecked.toggle()
    }
}
