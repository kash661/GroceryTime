//
//  HomeCoordinator.swift
//  GroceryTime
//
//  Created by Akash Desai on 2023-05-26.
//

import Foundation
import UIKit
import SwiftUI
import Firebase

class HomeCoordinator: UIViewController {
    
    var logoutTapped: () -> Void
    
    init(logoutTapped: @escaping () -> Void) {
        self.logoutTapped = logoutTapped
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        showCreateGroceryView()
        showAllGroceryListView()
    }
    
    func showGroceryTimeView() {
        children.forEach {
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }
        
        let viewModel = GroceryTimeViewModel()
        let groceryListView = GroceryTimeView(viewModel: viewModel)
        let groceryListViewController = UIHostingController(rootView: groceryListView)
        addChild(groceryListViewController)
        groceryListViewController.didMove(toParent: self)
        groceryListViewController.view.embed(in: view)
    }
    
    
    func showCreateGroceryView() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let viewModel = CreateGroceryViewModel(uid: uid) {
            self.dismiss(animated: true)
         }
        let createGroceryView = CreateGroceryView(viewModel: viewModel)
        let createGroceryViewController = UIHostingController(rootView: createGroceryView)
        createGroceryViewController.modalPresentationStyle = .fullScreen
        self.present(createGroceryViewController, animated: true)
    }
    
    func showAllGroceryListView() {
        children.forEach {
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let viewModel = AllGroceryListsViewModel(uid: uid, logoutTapped: { [unowned self] in
            self.logoutTapped()
        }, createButtonTapped: { [unowned self] in
            self.showCreateGroceryView()
        })
        let allGroceryListView = AllGroceryListsView(viewModel: viewModel)
        let allGroceryListViewController = UIHostingController(rootView: allGroceryListView)
        addChild(allGroceryListViewController)
        allGroceryListViewController.didMove(toParent: self)
        allGroceryListViewController.view.embed(in: view)
    }
    
}
