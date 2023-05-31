//
//  GroceryGroup.swift
//  GroceryTime
//
//  Created by Akash Desai on 2023-05-28.
//

import Foundation

struct GroceryGroup: Hashable {
    var uniqueName: String
    var creator: String
    var startDate: Date
    var endDate: Date
    var items: [Item]
    
    func dictionaryRepresentation() -> [String: Any] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let startDateString = dateFormatter.string(from: startDate)
        let endDateString = dateFormatter.string(from: endDate)
        
        return [
            "uniqueName": uniqueName,
            "creator": creator,
            "startDate": startDateString,
            "endDate": endDateString,
            "items": items.map { $0.dictionaryRepresentation() }
        ]
    }
    
    func itemsDictionaryRepresentation() -> [[String: Any]] {
        return items.map { $0.dictionaryRepresentation() }
    }
}
