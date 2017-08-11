//
//  MainViewController.swift
//  OmegaDemo
//
//  Created by Administrator on 7/24/17.
//  Copyright © 2017 Hussein Jaber. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var holdOrderBtn: UIButton!
    @IBOutlet weak var recallOrderBtn: UIButton!
    @IBOutlet weak var printBtn: UIButton!
    @IBOutlet weak var cmdBtn: UIButton!
    @IBOutlet weak var cashBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var lowerStackView: UIStackView!
    @IBOutlet weak var totalsView: UIView!
    @IBOutlet var totalSum: [UILabel]!

    var searchResults = [FoodItem]()
    var searchBar: UISearchBar?
    var isSearchBarActive: Bool = false

    enum TableCellsID {
        static let header = "HeaderCell"
        static let item = "TableCell"
    }

    enum ButtonProperty {
        static let backgroundColor = UIColor.oliveColor
        static let cornerRadius: CGFloat = 10
    }
    let collectionViewSize = CGSize.init(width: 100, height: 80)
    let collectionCellId = "CollectionCell"

    let itemsArray: [FoodItem] = [FoodItem.init(name: "Burger", unitPrice: 5500, quantity: 1),
                                  FoodItem.init(name: "Pizza", unitPrice: 13000, quantity: 1),
                                  FoodItem.init(name: "Steak", unitPrice: 16000, quantity: 1),
                                  FoodItem.init(name: "Fish", unitPrice: 26000, quantity: 1),
                                  FoodItem.init(name: "Shrimps", unitPrice: 43000, quantity: 1),
                                  FoodItem.init(name: "Fattush", unitPrice: 7500, quantity: 1),
                                  FoodItem.init(name: "Pepsi", unitPrice: 1500, quantity: 1),
                                  FoodItem.init(name: "Seven Up", unitPrice: 1500, quantity: 1),
                                  FoodItem.init(name: "Fries", unitPrice: 4000, quantity: 1),
                                  FoodItem.init(name: "Pasta", unitPrice: 12500, quantity: 1),
                                  FoodItem.init(name: "Chicken Breast", unitPrice: 11000, quantity: 1),
                                  FoodItem.init(name: "Cheese Burger", unitPrice: 5500, quantity: 1),
                                  FoodItem.init(name: "Tabboleh", unitPrice: 13000, quantity: 1),
                                  FoodItem.init(name: "Tuna Salad", unitPrice: 16000, quantity: 1),
                                  FoodItem.init(name: "Ceasar Salad", unitPrice: 26000, quantity: 1),
                                  FoodItem.init(name: "Farrouj", unitPrice: 43000, quantity: 1),
                                  FoodItem.init(name: "Argile", unitPrice: 7500, quantity: 1),
                                  FoodItem.init(name: "Orange Juice", unitPrice: 1500, quantity: 1),
                                  FoodItem.init(name: "Crispy 6 pcs", unitPrice: 1500, quantity: 1),
                                  FoodItem.init(name: "Fahita", unitPrice: 4000, quantity: 1),
                                  FoodItem.init(name: "Fransisco", unitPrice: 12500, quantity: 1),
                                  FoodItem.init(name: "Falefel", unitPrice: 11000, quantity: 1),
                                  FoodItem.init(name: "Cheese Burger", unitPrice: 5500, quantity: 1),
                                  FoodItem.init(name: "Tabboleh", unitPrice: 13000, quantity: 1),
                                  FoodItem.init(name: "Tuna Salad", unitPrice: 16000, quantity: 1),
                                  FoodItem.init(name: "Ceasar Salad", unitPrice: 26000, quantity: 1),
                                  FoodItem.init(name: "Farrouj", unitPrice: 43000, quantity: 1),
                                  FoodItem.init(name: "Argile", unitPrice: 7500, quantity: 1),
                                  FoodItem.init(name: "Orange Juice", unitPrice: 1500, quantity: 1),
                                  FoodItem.init(name: "Crispy 6 pcs", unitPrice: 1500, quantity: 1),
                                  FoodItem.init(name: "Fahita", unitPrice: 4000, quantity: 1),
                                  FoodItem.init(name: "Fransisco", unitPrice: 12500, quantity: 1),
                                  FoodItem.init(name: "Falefel", unitPrice: 11000, quantity: 1)
    ]
    var selectedItems: [FoodItem] = []

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCollectionView()
        setupButtons()
        setupSearchBar()
        lowerStackView.spacing = 5
        lowerStackView.height = 60
        totalsView.cornerRadius = 5
        totalsView.borderColor = UIColor.lightGray.cgColor
        totalsView.borderWidth = 0.4
        updateTotalsLabel()
        title = "Order #1254"
    }

    //MARK: - Setups

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView.init()
        tableView.borderWidth = 0.5
        tableView.borderColor = UIColor.darkGray.cgColor
        tableView.cornerRadius = 5
        tableView.separatorColor = UIColor.lightGray
        tableView.allowsMultipleSelection = false
    }

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = true
        collectionView.backgroundColor = UIColor.white
    }

    func setupButtons() {
        let btnsArray: [UIButton] = [holdOrderBtn, recallOrderBtn, printBtn, cmdBtn, cashBtn, closeBtn]
        for btn in btnsArray {
            btn.cornerRadius = ButtonProperty.cornerRadius
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.backgroundColor = ButtonProperty.backgroundColor
            btn.titleLabel?.font = UIFont.openSansFont(type: .semiBold, size: 16)
        }
    }

    func setupSearchBar() {
        if searchBar == nil {
            let xPoint = collectionView.frame.minX
            let yPoint = collectionView.frame.origin.y - 40
            let width = collectionView.bounds.width/2
            let frame = CGRect.init(x: xPoint, y: yPoint, width: width, height: 30)
            searchBar = UISearchBar.init(frame: frame)
            searchBar?.barStyle = .default
            searchBar?.searchBarStyle = .minimal
            searchBar?.tintColor = UIColor.oliveColor
            searchBar?.barTintColor = UIColor.oliveColor
            searchBar?.delegate = self
            searchBar?.placeholder = "Search here.."
            

        }
        if !(searchBar?.isDescendant(of: view))! {
            view.addSubview(searchBar!)
            let constraint = NSLayoutConstraint.init(item: collectionView, attribute: .leading, relatedBy: .equal, toItem: searchBar, attribute: .leading, multiplier: 1, constant: 0)
            view.addConstraint(constraint)
        }
    }

    //MARK: - IBActions
    @IBAction func clearItemsAction(_ sender: UIBarButtonItem) {
        selectedItems.removeAll()
        tableView.reloadData()
        updateTotalsLabel()
    }

    //MARK: - Private Methods

    func calculateTotal() -> String {
        var sum: CGFloat = 0.0
        for item in selectedItems {
            sum = sum + (CGFloat(item.quantity!) * item.unitPrice)
        }
        return sum.cleanValue
    }

    func updateTotalsLabel() {
        totalSum.first?.text = calculateTotal()
    }

}

//MARK: - Extensions
//MARK: UITableViewDelegate & UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedItems.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableCellsID.header)
            cell?.selectionStyle = .none
            return cell!
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCellsID.item) as! SelectedItemsTableViewCell
        cell.delegate = self
        cell.cellId = indexPath.row - 1
        let foodItem = selectedItems[indexPath.row - 1]
        cell.setCell(itemName: foodItem.name, quantity: foodItem.quantity, unitPrice: foodItem.unitPrice)
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            selectedItems.remove(at: indexPath.row - 1)
            tableView.reloadData()
            updateTotalsLabel()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 0 {
            return false
        }
        return true
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row != 0 {
            return 60
        }
        return 40
    }
}

//MARK: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearchBarActive {
            return searchResults.count
        }
        return itemsArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellId, for: indexPath) as! ItemsCollectionViewCell
        cell.backgroundColor = UIColor.lightBlueColor.withAlphaComponent(0.9)
        cell.layer.cornerRadius = 5
        cell.itemLabel.font = UIFont.openSansFont(type: .semiBold, size: 18)
        if isSearchBarActive {
            cell.itemLabel.text = searchResults[indexPath.row].name!
        } else {
            cell.itemLabel.text = itemsArray[indexPath.row].name!
        }
        cell.borderWidth = 0.2
        cell.borderColor = UIColor.darkGray.cgColor

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionViewSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var selectedItem: FoodItem
        if isSearchBarActive {
            selectedItem = searchResults[indexPath.row]
        } else {
            selectedItem = itemsArray[indexPath.row]
        }
        selectedItem.quantity = 1 
        selectedItems.append(selectedItem)
        tableView.reloadData()
        tableView.scrollToLastRow()
        tableView.markLastCell(section: 0)
        updateTotalsLabel()
    }
}

extension MainViewController: SelectedItemsCellDelegate {
    func didChangeQuantity(cellId: Int, newValue: UInt) {
        selectedItems[cellId].quantity = newValue
        tableView.reloadData()
        updateTotalsLabel()
    }
}

//MARK: UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {

    func filterContentForSearchText(searchText:String){
        searchResults = self.itemsArray.filter({ (item: FoodItem) -> Bool in
            return item.name!.localizedCaseInsensitiveContains(searchText)
        })
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.length > 0 {
            isSearchBarActive = true
            filterContentForSearchText(searchText: searchText)
            collectionView.reloadData()
        } else {
            isSearchBarActive = false
            collectionView.reloadData()
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearchBarActive = false
        searchBar.resignFirstResponder()
        searchBar.clear()
        collectionView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearchBarActive = true
        view.endEditing(true)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearchBarActive = false
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: false)
    }
}
