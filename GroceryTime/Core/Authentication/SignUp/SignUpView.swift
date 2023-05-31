//
//  SignUpView.swift
//  GroceryTime
//
//  Created by Akash Desai on 2023-05-25.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject private var viewModel: SignUpViewModel
    @State private var isPasswordVisible = false
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        VStack {
            MainLogoView()
                .padding(.bottom, -64)
            
                ZStack {
                    background
                    VStack {
                        signUpLabel
                        nameTextField
                        emailTextField
                        HStack {
                            passwordTextField
                            viewPasswordButton
                        }
                        
                        ErrorMessageView(errorMessage: viewModel.errorMessage)
                        
                        signUpButton
                    }
                    .padding()
                }
            
            Text("Already have an Account?")
                .padding(.vertical, 8)
            loginButton
            
            Spacer()
        }
        .padding(.bottom, 80)
            .padding()
    }
}

private extension SignUpView {
    var signUpLabel: some View {
        Text("Sign Up")
            .font(.title2)
            .fontWeight(.semibold)
            .padding()
            .foregroundColor(.white)
    }
    
    var background: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(Color("blue"))
            .shadow(color: .gray, radius: 4, x: 0, y: 2)
    }
    
    var nameTextField: some View {
        TextField("Name", text: $viewModel.name)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
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
    
    var signUpButton: some View {
        Button(action: viewModel.signUp) {
            Text("Sign Up")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(.accentColor)
                .padding()
                .background(Color.primary)
                .cornerRadius(10)
        }
        .padding()
    }
    
    var loginButton: some View {
        Button(action: viewModel.loginButtonTapped) {
            Text("Log In")
                .font(.callout)
                .fontWeight(.semibold)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: SignUpViewModel(showLoginView: {}, signUpStatus: {_ in }))
    }
}
