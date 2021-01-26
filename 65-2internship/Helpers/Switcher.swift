//
//  Switcher.swift
//  65-2internship
//
//  Created by Kisa Shket on 01.11.2020.
//  Copyright © 2020 Kisa Shket. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn

class Switcher {
    
    static func updateRootVC(){
        let viewModel = ContactTableViewModelFromEntry.init()
        let service = GoogleService().shared
        var rootVC : UIViewController?
        
        guard let hasPrevSignIn = service?.hasPreviousSignIn() else { return }
        if hasPrevSignIn {
            service?.restorePreviousSignIn()
            if let contactVc = UIStoryboard(name: Constants.kStoryboardName, bundle: nil).instantiateViewController(withIdentifier: Constants.kContactsId) as? ContactTableViewController{
                rootVC = contactVc
                contactVc.viewModel = viewModel
            }
        }
        else {
            rootVC = UIStoryboard(name: Constants.kStoryboardName, bundle: nil).instantiateViewController(withIdentifier: Constants.kLoginId)
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
    }
}
