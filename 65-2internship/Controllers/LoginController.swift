//
//  ViewController.swift
//  65-2internship
//
//  Created by Kisa Shket on 28.10.2020.
//  Copyright © 2020 Kisa Shket. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    let googleService = GoogleService()
    override func viewDidLoad() {
        super.viewDidLoad()
        googleService.setPresentingViewController(self)
        googleService.setDelegate()
    }

    @IBAction func clickedLoginButton(_ sender: Any) {
        googleService.setScopes()
        googleService.signIn()
    }
    
}


