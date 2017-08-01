//
//  BaseViewController.swift
//  OmegaDemo
//
//  Created by Administrator on 7/20/17.
//  Copyright © 2017 Hussein Jaber. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController.init(title: title, message: message, defaultActionButtonTitle: "OK", tintColor: nil)
        present(alertController, animated: true, completion: nil)
    }
}
