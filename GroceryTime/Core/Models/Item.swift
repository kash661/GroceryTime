//
//  Item.swift
//  GroceryTime
//
//  Created by Akash Desai on 2023-05-26.
//

import Foundation

struct Item: Hashable, Identifiable {
    let id: UUID
    var name: String
    var quantity: Int = 1
    var isChecked: Bool
    
    func dictionaryRepresentation() -> [String: Any] {        
        return [
            "id": id.uuidString,
            "name": name,
            "quantity": quantity,
            "isChecked": isChecked
        ]
    }
}
