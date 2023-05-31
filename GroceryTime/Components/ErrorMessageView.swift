//
//  ErrorMessageView.swift
//  GroceryTime
//
//  Created by Akash Desai on 2023-05-26.
//

import SwiftUI

struct ErrorMessageView: View {
    var errorMessage: String
    
    var body: some View {
        Text(errorMessage)
            .foregroundColor(.red)
            .font(.footnote)
            .fontWeight(.semibold)
            .padding(.top, 4)
            .lineLimit(nil)
    }
}

struct ErrorMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorMessageView(errorMessage: "ERRROR")
    }
}
