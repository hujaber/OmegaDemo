//
//  ViewController.swift
//  OmegaDemo
//
//  Created by Administrator on 7/19/17.
//  Copyright © 2017 Hussein Jaber. All rights reserved.
//

import UIKit
import SQLite

class ViewController: BaseViewController {

    var db: Connection!
    var tableArray = [DraggabaleImageView]()
    var numberOfTables: Int = 0
    let kTableImageWH: CGFloat = 70.0

    var draggableView: UIView!

    @IBOutlet weak var clearBarBtn: UIBarButtonItem!
    @IBOutlet weak var loadBarBtn: UIBarButtonItem!
    @IBOutlet weak var saveBarBtn: UIBarButtonItem!
    @IBOutlet weak var setupBarBtn: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        connectToDB()
    }

    func connectToDB() {
        if DBHelper.makeConnection().success {
            db = DBHelper.makeConnection().db
        } else {
            showAlert(title: "", message: "Connection to Database failed")
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if numberOfTables == 0 {
            return
        }
        let touch = touches.first
        let point = touch?.location(in: view)
        if !didTouchExistingTable(point: point!) {
            addImageToPoint(point: point!, ignoreNbOfTables: false)
        }
    }

    func didTouchExistingTable(point: CGPoint) -> Bool {
        for imageView in tableArray {
            if imageView.frame.contains(point) {
                return true
            }
        }
        return false
    }

    func draggedView(_ sender:UIPanGestureRecognizer){
        self.view.bringSubview(toFront: draggableView)
        let translation = sender.translation(in: self.view)
        draggableView.center = CGPoint(x: draggableView.center.x + translation.x, y: draggableView.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
    }

    func addImageToPoint(point: CGPoint, ignoreNbOfTables: Bool) {
        let imageView = DraggabaleImageView.init(image: #imageLiteral(resourceName: "dining_table.png"))

        imageView.frame = CGRect.init(x: point.x, y: point.y, width: kTableImageWH , height: kTableImageWH)
        imageView.addSubview(getLabelWithText(text: "\(tableArray.count + 1)"))

        if ignoreNbOfTables {
            tableArray.append(imageView)
            view.addSubview(imageView)
        } else if tableArray.count < numberOfTables {
            tableArray.append(imageView)
            view.addSubview(imageView)
        }
    }

    func getLabelWithText(text: String!) -> UILabel! {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 25, height: 25))
        label.text = text
        label.textAlignment = .left
        return label
    }

    //MARK: - IBActions
    @IBAction func clearAction(_ sender: UIBarButtonItem) {
        for imageView in tableArray {
            imageView.removeFromSuperview();
        }
        tableArray = Array<DraggabaleImageView>();
        for imgVw in view.subviews {
            imgVw.removeFromSuperview()
        }
    }


    @IBAction func setupAction(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController.init(title: "", message: "Please enter number of tables", preferredStyle: .alert)
        alertController.addTextField { (txtField) in
            txtField.keyboardType = .numberPad
        }
        let okayAction = UIAlertAction.init(title: "OK", style: .default) { (alertAction) in
            let text = alertController.textFields?.first?.text
            let nbTables = Int(text!)
            self.numberOfTables = nbTables!
        }
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(okayAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        let coord = Table("coord")
        if DBHelper.deleteAllEntriesForTable(table: coord, forDB: db) {
            for imgViews in tableArray {
                let xF = imgViews.frame.origin.x
                let yF = imgViews.frame.origin.y
                if !DBHelper.insertInto(table: coord, db: db, x: Double(xF), y: Double(yF)).success {
                    guard let error = DBHelper.insertInto(table: coord, db: db, x: Double(xF), y: Double(yF)).error else {
                        return
                    }
                    let alertController =  UIAlertController.init(title: "Error", error: error, defaultActionButtonTitle: "OK", tintColor: nil)
                    alertController.show(animated: true, vibrate: true, completion: nil)
                }
            }
        } else {
            showAlert(title: "", message: "Operation failed. DB failed to delete entries for table: coord")
        }
    }

    @IBAction func loadDataAction(_ sender: UIBarButtonItem) {
        let coords = Table("coord")
        tableArray = Array<DraggabaleImageView>()
        clearAction(sender)
        do {
            for coordPt in try db.prepare(coords) {
                let x = Expression<Double>("x")
                let y = Expression<Double>("y")
                let xp = coordPt[x]
                let yp = coordPt[y]
                let point = CGPoint.init(x: CGFloat(xp), y: CGFloat(yp))
                addImageToPoint(point: point, ignoreNbOfTables: true)
            }
        } catch let error as NSError {
            print(error.localizedFailureReason ?? "printing out");
        }
    }
}
