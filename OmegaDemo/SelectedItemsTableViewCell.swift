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
    @IBOutlet weak var quantityStepper: UIStepper!
    weak var delegate: SelectedItemsCellDelegate?
    public var cellId: Int?

    override func awakeFromNib() {
        super.awakeFromNib()
        quantityStepper.tintColor = UIColor.oliveColor
        quantityStepper.stepValue = 1
        quantityStepper.minimumValue = 1
        quantityStepper.autorepeat = true
        let font = UIFont.openSansFont(type: .regular, size: 16)
        quantityLabel.font = font
        itemNameLabel.font = font
        unitPriceLabel.font = font
        totalPriceLabel.font = font
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setCell(itemName: String!, quantity: UInt!, unitPrice: CGFloat) {
        var totalPrice: CGFloat = 0
        totalPrice = CGFloat(quantity) * unitPrice
        quantityLabel.text = "\(quantity!)"
        itemNameLabel.text = itemName
        unitPriceLabel.text = unitPrice.cleanValue
        totalPriceLabel.text = totalPrice.cleanValue
    }

    @IBAction func stepperValueChangeAction(_ sender: UIStepper) {
        quantityLabel.text = "\(Int(quantityStepper.value))"
        delegate?.didChangeQuantity(cellId: cellId!, newValue: UInt(quantityStepper.value))
    }

}

protocol SelectedItemsCellDelegate: class {
    func didChangeQuantity(cellId: Int, newValue: UInt)
}

