//
//  CreateGroceryView.swift
//  GroceryTime
//
//  Created by Akash Desai on 2023-05-26.
//

import SwiftUI

struct CreateGroceryView: View {
    @ObservedObject private var viewModel: CreateGroceryViewModel
    @State private var isAddItemViewPresented = false
    
    init(viewModel: CreateGroceryViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                groupNameTextField
                startDatePicker
                endDatePicker
                Spacer()
                errorMessageView
                continueButton
            }
            .navigationTitle("Create Grocery List")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: closeButton)
        }
    }
}

private extension CreateGroceryView {
    var groupNameTextField: some View {
        TextField("Grocery Group Name", text: $viewModel.groceryGroupName)
            .padding()
    }
    
    var startDatePicker: some View {
        DatePicker("Start Date", selection: $viewModel.startDate, in: viewModel.currentDate..., displayedComponents: .date)
            .padding()
    }
    
    var endDatePicker: some View {
        DatePicker("End Date", selection: $viewModel.endDate, in: viewModel.currentDate..., displayedComponents: .date)
            .padding()
    }
    
    var errorMessageView: some View {
        ErrorMessageView(errorMessage: viewModel.errorMessage)
    }
    
    var continueButton: some View {
        NavigationLink(
            destination: AddItemView(viewModel: viewModel.addItemViewModel())
        ) {
            Text("Continue")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding()
        }
        .disabled(viewModel.shouldContinue)
        .onTapGesture {
            viewModel.continueTapped()
        }
    }
    
    private var closeButton: some View {
        Button(action: {
            viewModel.dismissHandler()
        }) {
            Image(systemName: "xmark")
                .imageScale(.medium)
                .foregroundColor(.black) // Set button color to black
                .font(Font.system(size: 20, weight: .bold)) // Set button font size and weight
        }
    }
}


struct CreateGroceryView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGroceryView(viewModel: CreateGroceryViewModel(uid: "", dismissHandler: {}))
    }
}
