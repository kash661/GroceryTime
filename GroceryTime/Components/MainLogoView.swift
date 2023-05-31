//
//  MainLogoView.swift
//  GroceryTime
//
//  Created by Akash Desai on 2023-05-25.
//

import SwiftUI

struct MainLogoView: View {
    var body: some View {
        VStack {
            ZStack {
                Image("main-logo") // Replace "main-logo" with the name of your actual image asset
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 400)
                
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 2)
                    .frame(width: 200, height: 200)
                    .shadow(color: Color.black.opacity(0.4), radius: 4, x: 0, y: 2)
            }
        }
    }
}

struct MainLogoView_Previews: PreviewProvider {
    static var previews: some View {
        MainLogoView()
    }
}
