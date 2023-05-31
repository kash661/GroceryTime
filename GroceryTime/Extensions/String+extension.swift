//
//  String+extension.swift
//  GroceryTime
//
//  Created by Akash Desai on 2023-05-27.
//

import Foundation

extension String {
    func removingAfterFirstUnderscore() -> String {
        if let range = self.range(of: "_") {
            return String(self[..<range.lowerBound])
        }
        return self
    }
}
