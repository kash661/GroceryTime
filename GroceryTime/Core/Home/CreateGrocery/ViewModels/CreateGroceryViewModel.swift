//
//  CreateGroceryViewModel.swift
//  GroceryTime
//
//  Created by Akash Desai on 2023-05-26.
//

import Foundation

class CreateGroceryViewModel: ObservableObject {
    @Published var groceryGroupName = ""
    @Published var errorMessage: String = ""
    @Published var startDate = Date()
    @Published var endDate = Date()
    
    var uid: String
    var dismissHandler: () -> Void
    
    init(
        uid: String,
        dismissHandler: @escaping () -> Void
    ) {
        self.uid = uid
        self.dismissHandler = dismissHandler
    }
    
    var currentDate: Date {
        Date()
    }
    
    var shouldContinue: Bool {
        groceryGroupName.isEmpty
    }
    
    func continueTapped() {
        if groceryGroupName.isEmpty {
            errorMessage = "Please assign a name to the list"
        }
        print("hi")
    }
    
    func addItemViewModel() -> AddItemViewModel {
        AddItemViewModel(
            groceryGroup:
                GroceryGroup(
                    uniqueName: groceryGroupName,
                    creator: uid, startDate: startDate,
                    endDate: endDate,
                    items: []),
            addItemStatus: .creating,
            dismiss: self.dismissHandler
        )
    }
}
