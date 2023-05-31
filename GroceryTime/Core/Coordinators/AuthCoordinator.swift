//
//  AuthCoordinator.swift
//  GroceryTime
//
//  Created by Akash Desai on 2023-05-25.
//

import Foundation
import UIKit
import SwiftUI

enum AuthStatus {
    case success
    case failed(String)
}

class AuthCoordinator: UIViewController {
    
    private var loginStatus: (AuthStatus) -> Void
    private var signUpStatus: (AuthStatus) -> Void
    
    init(
        loginStatus: @escaping (AuthStatus) -> Void,
        signUpStatus: @escaping (AuthStatus) -> Void
    ) {
        self.loginStatus = loginStatus
        self.signUpStatus = signUpStatus
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoginView()
    }
    
    func showSignUpView() {
        children.forEach {
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }
        
        let viewModel = SignUpViewModel(showLoginView: { [unowned self] in
            self.showLoginView()
        }, signUpStatus: { [unowned self] status in
            self.signUpStatus(status)
        })
        let signUpView = SignUpView(viewModel: viewModel)
        let signUpViewController = UIHostingController(rootView: signUpView)
        
        addChild(signUpViewController)
        signUpViewController.didMove(toParent: self)
        signUpViewController.view.embed(in: view)
    }
    
    func showLoginView() {
        children.forEach {
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }
        
        let viewModel = LoginViewModel(loginStatus: { [unowned self] status in
            self.loginStatus(status)
        }, showSignUpView: { [unowned self] in
            self.showSignUpView()
        })
        let loginView = LoginView(viewModel: viewModel)
        let loginViewController = UIHostingController(rootView: loginView)
        
        addChild(loginViewController)
        loginViewController.didMove(toParent: self)
        loginViewController.view.embed(in: view)
    }
}
