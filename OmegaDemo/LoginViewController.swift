//
//  LoginViewController.swift
//  OmegaDemo
//
//  Created by Administrator on 8/4/17.
//  Copyright © 2017 Hussein Jaber. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    enum SegueIdentifiers {
       static let toMainView = "segueToMainView"
    }

    enum TextFieldProperties {
        static let borderStyle: UITextBorderStyle = .none
        static let font: UIFont = UIFont.openSansFont(type: .semiBold, size: 17)
    }

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginButton()
        setupTextFields()
        title = "Welcome to OLive"
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        usernameTxtField.addBottomBorder(width: 1, color: UIColor.oliveColor)
        passwordTxtField.addBottomBorder(width: 1, color: UIColor.oliveColor)
    }

    //MARK: - Setups

    func setupLoginButton() {
        loginButton.backgroundColor = UIColor.oliveColor
        loginButton.cornerRadius = 7;
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.titleLabel?.font = TextFieldProperties.font
    }

    func setupTextFields() {
        passwordTxtField.isSecureTextEntry = true

        usernameTxtField.borderStyle = TextFieldProperties.borderStyle
        passwordTxtField.borderStyle = TextFieldProperties.borderStyle

        passwordTxtField.placeholder = "Password"
        passwordTxtField.font = TextFieldProperties.font
        passwordTxtField.tintColor = UIColor.oliveColor

        usernameTxtField.placeholder = "Username"
        usernameTxtField.font = TextFieldProperties.font
        usernameTxtField.tintColor = UIColor.oliveColor


    }

    //MARK: - IBActions
    @IBAction func loginAction(_ sender: UIButton) {
        performSegue(withIdentifier: SegueIdentifiers.toMainView, sender: self)
    }


}
