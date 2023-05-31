//
//  SignUpViewModel.swift
//  GroceryTime
//
//  Created by Akash Desai on 2023-05-25.
//

import Foundation
import Firebase

class SignUpViewModel: ObservableObject {
    
    private let showLoginView: () -> Void
    private var signUpStatus: (AuthStatus) -> Void
    
    init(
        showLoginView: @escaping () -> Void,
        signUpStatus: @escaping (AuthStatus) -> Void
    ) {
        self.showLoginView = showLoginView
        self.signUpStatus = signUpStatus
    }
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    
    func signUp() {
        guard !name.isEmpty else {
            errorMessage = "Please enter your name."
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                // Handle sign-up error
                self.errorMessage = error.localizedDescription
                self.signUpStatus(.failed(error.localizedDescription))
                print("Sign-up error: \(self.errorMessage)")
            } else {
                // Sign-up successful
                self.errorMessage = ""
                print("Sign-up successful")
                self.signUpStatus(.success)
                self.showLoginView()
                // Additional logic after successful sign-up (e.g., update user profile, navigate to next screen)
                
                // Example: Update user profile display name
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = self.name
                changeRequest?.commitChanges { error in
                    if let error = error {
                        // Handle profile update error
                        self.errorMessage = error.localizedDescription
                        print("Profile update error: \(self.errorMessage)")
                    } else {
                        // Profile update successful
                        self.errorMessage = ""
                        print("Profile update successful")
                    }
                }
                
                if let userId = Auth.auth().currentUser?.uid {
                    let userData = ["name": self.name, "email": self.email]
                    let usersRef = Database.database().reference().ref.child("GroceryTime").child("users")
                    usersRef.child(userId).setValue(userData) { [weak self] error, _ in
                        guard let self = self else { return }
                        
                        if let error = error {
                            self.errorMessage = error.localizedDescription
                            print("Data storage error: \(self.errorMessage)")
                        } else {
                            self.errorMessage = ""
                            print("Data storage successful")
                        }
                    }
                }
            }
        }
    }
    
    func loginButtonTapped() {
        showLoginView()
    }
}
