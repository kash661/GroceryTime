//
//  GroceryListViewCell.swift
//  GroceryTime
//
//  Created by Akash Desai on 2023-05-28.
//

import SwiftUI

struct GroceryListViewCell: View {
    var item: Item
    @Binding var isChecked: Bool

    init(item: Item, isChecked: Binding<Bool>) {
        self.item = item
        self._isChecked = isChecked
    }

    var body: some View {
        ZStack {
            Button(action: {
                isChecked.toggle()
            }) {
                HStack {
                    if isChecked {
                        LottieView(filename: "check-animation")
                            .frame(width: 50, height: 50)
                    } else {
                        Image(systemName: "circle")
                            .frame(width: 50, height: 50)
                            .imageScale(.medium)
                            .foregroundColor(.green)
                    }
                    Text(item.name)
                        .fontWeight(.semibold)
                        .foregroundColor(isChecked ? .gray : .primary)
                    Spacer()
                }
                .contentShape(Rectangle())
                .padding(4)
            }
            .buttonStyle(PlainButtonStyle())
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.white)
                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
            )
        }
    }
}

struct GroceryListViewCell_Previews: PreviewProvider {
    static var previews: some View {
        GroceryListViewCell(item: Item(id: UUID(), name: "", isChecked: true), isChecked: .constant(false))
    }
}
