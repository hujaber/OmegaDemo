//
//  BaseViewController.swift
//  OmegaDemo
//
//  Created by Administrator on 7/20/17.
//  Copyright © 2017 Hussein Jaber. All rights reserved.
//

import UIKit
import SVProgressHUD

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController.init(title: title, message: message, defaultActionButtonTitle: "OK", tintColor: nil)
        present(alertController, animated: true, completion: nil)
    }

    func showLoader() {
        UIApplication.shared.beginIgnoringInteractionEvents()
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setBackgroundColor(UIColor.white)
        SVProgressHUD.setForegroundColor(UIColor.oliveColor)
        SVProgressHUD.show()
    }

    func  hideLoader() {
        if SVProgressHUD.isVisible() {
            UIApplication.shared.endIgnoringInteractionEvents()
            SVProgressHUD.dismiss()
        }
    }
}
