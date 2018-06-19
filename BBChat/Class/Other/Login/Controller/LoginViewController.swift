//
//  LoginViewController.swift
//  Center
//
//  Created by bb on 2017/11/20.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class LoginViewController: UITableViewController {
    
    lazy var vm = MenberFormViewModel()
    
    private lazy var loginView: LoginView = {
        let view = LoginView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }

}

extension LoginViewController {
    
    private func setupUI() {
        if #available(iOS 11.0, *) {
            loginView.collectionView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        loginView.frame = self.view.bounds
        loginView.controller = self
        self.view = loginView
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        UIApplication.shared.statusBarStyle = .default
        superNavigationBar(left: nil, right: "注册", isClear: true, color: mainColor)
    }
}

extension LoginViewController {
    
    private func loadData() {
        self.vm.loadData(type: .login) {
            self.loginView.menberForm = self.vm.menberForm
        }
    }
}

extension LoginViewController {
    
    override func rightItemAction() {
        let nav = UINavigationController(rootViewController: RegisterViewController())
        MGKeyWindow?.rootViewController?.present(nav, animated: true, completion: nil)
    }
}
