//
//  GoogleService.swift
//  65-2internship
//
//  Created by Kisa Shket on 29.10.2020.
//  Copyright © 2020 Kisa Shket. All rights reserved.
//

import Foundation
import GoogleSignIn

class GoogleService: NSObject {
    
    let shared = GIDSignIn.sharedInstance()
    
    func getAccessToken() -> String? {
        let tokenGid = shared?.currentUser.authentication.accessToken
        guard let token = tokenGid else {
            return nil
        }
        
        return token
    }
    
    func signIn(){
        shared?.signIn()
    }
    
    func signOut(){
        shared?.signOut()
    }
    
    func disconnect(){
        shared?.disconnect()
    }
    
    func setDelegate() {
        shared?.delegate = self
    }
    
    func setScopes() {
        shared?.scopes = [Constants.kScope]
    }
    
    func setClientID(withID id: String) {
        shared?.clientID = id
    }
    
    func setPresentingViewController(_ vc: UIViewController) {
        shared?.presentingViewController = vc
    }
    
    func handle(url: URL) -> Bool {
        return (shared?.handle(url))!
    }
    
    
}

extension GoogleService: GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard error == nil else { return }
        let viewModel = ContactTableViewModelFromEntry.init()
        let appDeleagate = UIApplication.shared.delegate as! AppDelegate
        let stroryboard = UIStoryboard.init(name: Constants.kStoryboardName,
                                            bundle: nil)
        if let initialViewController = stroryboard
            .instantiateViewController(withIdentifier: Constants.kContactsId) as? ContactTableViewController {
            initialViewController.viewModel = viewModel
            appDeleagate.window?.rootViewController = initialViewController
        }
        appDeleagate.window?.makeKeyAndVisible()
        UIView.transition(with: appDeleagate.window!,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}

