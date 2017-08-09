//
//  FoodItem.swift
//  OmegaDemo
//
//  Created by Administrator on 7/28/17.
//  Copyright © 2017 Hussein Jaber. All rights reserved.
//

import Foundation
import UIKit

struct FoodItem {
    let name: String!
    let unitPrice: CGFloat
    var quantity: UInt?

    init(name: String, unitPrice: CGFloat, quantity: UInt?) {
        self.name = name
        self.unitPrice = unitPrice
        self.quantity = quantity
    }
}
