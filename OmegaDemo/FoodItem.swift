//
//  FoodItem.swift
//  OmegaDemo
//
//  Created by Administrator on 7/28/17.
//  Copyright © 2017 Hussein Jaber. All rights reserved.
//

import Foundation


struct FoodItem {
    let name: String!
    let unitPrice: Float
    var quantity: UInt?

    init(name: String, unitPrice: Float, quantity: UInt?) {
        self.name = name
        self.unitPrice = unitPrice
        self.quantity = quantity
    }
}
