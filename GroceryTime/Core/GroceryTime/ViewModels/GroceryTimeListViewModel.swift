//
//  GroceryTimeListViewModel.swift
//  GroceryTime
//
//  Created by Akash Desai on 2023-05-25.
//

import Foundation

class GroceryTimeViewModel: ObservableObject {
    
    required init() { }
    
    @Published var checklistItems = [
        ChecklistItem(text: "Item 1"),
        ChecklistItem(text: "Item 2"),
        ChecklistItem(text: "Item 3"),
        ChecklistItem(text: "Item 2"),
        ChecklistItem(text: "Item 3"),
        ChecklistItem(text: "Item 2"),
        ChecklistItem(text: "Item 3"),
        ChecklistItem(text: "Item 2"),
        ChecklistItem(text: "Item 3")
    ]
    
    var formattedDate: String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none        
        return dateFormatter.string(from: currentDate)
    }
    
    func toggleItem(_ item: ChecklistItem) {
        if let index = checklistItems.firstIndex(where: { $0.id == item.id }) {
            checklistItems[index].isChecked.toggle()
        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        checklistItems.remove(atOffsets: offsets)
    }
}
