//
//  SelectedItemsTableViewCell.swift
//  OmegaDemo
//
//  Created by Administrator on 7/26/17.
//  Copyright © 2017 Hussein Jaber. All rights reserved.
//

import UIKit

class SelectedItemsTableViewCell: UITableViewCell {
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var unitPriceLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCell(itemName: String!, quantity: String!, unitPrice: String) {
        var totalPrice: Float = 0
        if let qty = Float(quantity), let uPrice = Float(unitPrice) {
            totalPrice = qty * uPrice
        }
        quantityLabel.text = quantity
        itemNameLabel.text = itemName
        unitPriceLabel.text = unitPrice
        totalPriceLabel.text = "\(totalPrice)"
    }

}
