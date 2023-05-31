//
//  AppCoordinator.swift
//  GroceryTime
//
//  Created by Akash Desai on 2023-05-25.
//

import Foundation
import UIKit
import Firebase
import SwiftUI

class AppCoordinator: UIViewController {
    
    private var authCoordinator: AuthCoordinator?
    private var homeCoordinator: HomeCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showApp()
    }
    
    func showApp() {
        if Auth.auth().currentUser != nil {
            showHomeCoordinator()
        } else {
            showAuthCoordinator()
        }
    }
    
    func showHomeCoordinator() {
        children.forEach {
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }
        
        let homeCoordinator = HomeCoordinator(logoutTapped: { [unowned self] in
            self.logoutUser()
        })
        addChild(homeCoordinator)
        homeCoordinator.didMove(toParent: self)
        homeCoordinator.view.embed(in: view)
        self.homeCoordinator = homeCoordinator
        
    }
    
    func showAuthCoordinator() {
        children.forEach {
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }
        
        let authCoordinator = AuthCoordinator(loginStatus: { [unowned self] status in
            self.loginStatus(status)
        }, signUpStatus: { [unowned self] status in
            self.signUpStatus(status)
        })
        addChild(authCoordinator)
        authCoordinator.didMove(toParent: self)
        authCoordinator.view.embed(in: view)
        self.authCoordinator = authCoordinator
    }
    
    func loginStatus(_ status: AuthStatus) {
        switch status {
            
        case .success:
            showApp()
        case .failed(let error):
            print(error)
        }
    }
    
    func signUpStatus(_ status: AuthStatus) {
        switch status {
            
        case .success:
            showApp()
        case .failed(let error):
            print(error)
        }
    }
    
    func logoutUser() {
        do {
            try Auth.auth().signOut()
            showApp()
        } catch {
            print(error.localizedDescription)
        }
    }
}
