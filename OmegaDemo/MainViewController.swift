//
//  MainViewController.swift
//  OmegaDemo
//
//  Created by Administrator on 7/24/17.
//  Copyright © 2017 Hussein Jaber. All rights reserved.
//

import UIKit
import Spruce

class MainViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var holdOrderBtn: UIButton!
    @IBOutlet weak var recallOrderBtn: UIButton!
    @IBOutlet weak var printBtn: UIButton!
    @IBOutlet weak var cmdBtn: UIButton!
    @IBOutlet weak var cashBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var upperStackView: UIStackView!
    @IBOutlet weak var lowerStackView: UIStackView!
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var totalsView: UIView!

    //Animations
    var animations: [StockAnimation] = []
    var sortFunction: SortFunction?
    var animationView: UIView?
    var timer: Timer?

    var searchBar: UISearchBar?

    enum TableCellsID {
        static let header = "HeaderCell"
        static let item = "TableCell"
    }

    enum ButtonProperty {
        static let backgroundColor = UIColor.oliveColor
        static let cornerRadius: CGFloat = 10
    }

    let collectionCellId = "CollectionCell"


    let itemsArray: [String] = ["Burger", "Pizza", "Steak", "Fish", "Shrimps", "Fattush", "Pepsi", "Seven Up", "Fries", "Pasta", "Chicken Breast"]

    var selectedItems: [String] = []



    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCollectionView()
        setupButtons()
        setupLabel()
        setupSearchBar()

        upperStackView.spacing = 5
        lowerStackView.spacing = 5
        totalsView.cornerRadius = 5
        totalsView.borderColor = UIColor.lightGray.cgColor
        totalsView.borderWidth = 0.4
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
    }

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = true
        collectionView.backgroundColor = UIColor.white
    }

    func setupLabel() {
        orderNumberLabel.text = "Order #1254"
        orderNumberLabel.textColor = UIColor.oliveColor
        orderNumberLabel.textAlignment = .center
        orderNumberLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }

    func setupButtons() {
        let btnsArray: [UIButton] = [holdOrderBtn, recallOrderBtn, printBtn, cmdBtn, cashBtn, closeBtn]
        for btn in btnsArray {
            btn.cornerRadius = ButtonProperty.cornerRadius
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.backgroundColor = ButtonProperty.backgroundColor
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

    //MARK: - Animations

    func prepareForAnimation() {
        sortFunction = LinearSortFunction(direction: .leftToRight, interObjectDelay: 0.1)
        animationView = collectionView
        animations = [.fadeIn, .expand(.slightly)]
        prepareAnimation()
    }

    func prepareAnimation() {
        animationView?.spruce.prepare(with: animations)
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(callAnimation), userInfo: nil, repeats: false)
    }

    func callAnimation() {
        guard let sortFunction = sortFunction else {
            return
        }
        let animation = SpringAnimation(duration: 0.7)
        DispatchQueue.main.async {
            self.animationView?.spruce.animate(self.animations, animationType: animation, sortFunction: sortFunction)
        }
    }

    //MARK: - IBActions
    @IBAction func clearItemsAction(_ sender: UIBarButtonItem) {
        selectedItems.removeAll()
        tableView.reloadData()
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
            return cell!
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCellsID.item) as! SelectedItemsTableViewCell
        cell.setCell(itemName: selectedItems[indexPath.row - 1], quantity: "\(1)", unitPrice: "7000")
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            selectedItems.remove(at: indexPath.row - 1)
            tableView.reloadData()
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
        return itemsArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellId, for: indexPath) as! ItemsCollectionViewCell
        cell.backgroundColor = UIColor.lightBlueColor.withAlphaComponent(0.9)
        cell.layer.cornerRadius = 5
        cell.itemLabel.text = itemsArray[indexPath.row]

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0, height: 80.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = itemsArray[indexPath.row]
        selectedItems.append(selectedItem)
        tableView.reloadData()
    }
}

//MARK: UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    
}
