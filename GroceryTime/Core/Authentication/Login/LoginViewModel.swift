//
//  LoginViewModel.swift
//  GroceryTime
//
//  Created by Akash Desai on 2023-05-25.
//

import Foundation
import Firebase

class LoginViewModel: ObservableObject {

    private var loginStatus: (AuthStatus) -> Void
    private let showSignUpView: () -> Void

    init(
        loginStatus: @escaping (AuthStatus) -> Void,
        showSignUpView: @escaping () -> Void
    ) {
        self.loginStatus = loginStatus
        self.showSignUpView = showSignUpView
    }

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                // Handle login error
                self.errorMessage = error.localizedDescription
                self.loginStatus(.failed(error.localizedDescription))
            } else {
                // Login successful
                self.errorMessage = ""
                self.loginStatus(.success)
            }
        }
    }
    
    func signUpButtonTapped() {
        showSignUpView()
    }
}
