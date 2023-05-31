//
//  CheckList.swift
//  GroceryTime
//
//  Created by Akash Desai on 2023-05-24.
//

import Foundation

struct ChecklistItem: Identifiable {
    let id = UUID()
    var text: String
    var isChecked = false
}
