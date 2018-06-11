//
//  RegisterViewController.swift
//  Center
//
//  Created by bb on 2017/11/20.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class RegisterViewController: UITableViewController {
    
    lazy var vm = MenberFormViewModel()
    
    private lazy var registerView: RegisterView = {
        let view = RegisterView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
}

extension RegisterViewController {
    
    private func setupUI() {
        if #available(iOS 11.0, *) {
            registerView.collectionView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        registerView.frame = self.view.bounds
        registerView.controller = self
        self.view = registerView
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        superNavigationBar(left: .stop, right: nil, isClear: true)
    }

}

extension RegisterViewController {
    
    private func loadData() {
        self.vm.loadData(type: .register) {
            self.registerView.menberForm = self.vm.menberForm
        }
    }
}
