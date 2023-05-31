//
//  LoginView.swift
//  GroceryTime
//
//  Created by Akash Desai on 2023-05-25.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject private var viewModel: LoginViewModel
    @State private var isPasswordVisible = false
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            MainLogoView()
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color("blue"))
                    .shadow(color: .gray, radius: 4, x: 0, y: 2)
                
                VStack {
                    Spacer()
                    loginLabel
                    emailTextField
                    HStack {
                        passwordTextField
                        viewPasswordButton
                    }
                    ErrorMessageView(errorMessage: viewModel.errorMessage)
                        .frame(height: 40)
                    
                    loginButton
                    Spacer()
                }
                .padding()
                
            }
            Text("OR")
                .padding(.vertical, 8)
            signUpButton
            Spacer()
        }
        .padding(.bottom, 80)
        .padding()
    }
}

private extension LoginView {
    var loginLabel: some View {
        Text("Log In")
            .font(.title2)
            .fontWeight(.semibold)
            .padding()
            .foregroundColor(.white)
    }
    
    var emailTextField: some View {
        TextField("Email", text: $viewModel.email)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
    }
    
    var passwordTextField: some View {
        Group {
            if isPasswordVisible {
                TextField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
        .padding()
    }
    
    var viewPasswordButton: some View {
        Button(action: { isPasswordVisible.toggle() }) {
            Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                .foregroundColor(.primary)
        }
    }
    
    var loginButton: some View {
        Button(action: viewModel.login) {
            Text("Log In")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(.accentColor)
                .padding()
                .background(Color.primary)
                .cornerRadius(10)
        }
        .padding()
    }
    
    var signUpButton: some View {
        Button(action: viewModel.signUpButtonTapped) {
            Text("Sign Up")
                .font(.callout)
                .fontWeight(.semibold)
        }
        .padding(.bottom, 16)
        
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(loginStatus: { status in
            
        }, showSignUpView: {}))
    }
}
