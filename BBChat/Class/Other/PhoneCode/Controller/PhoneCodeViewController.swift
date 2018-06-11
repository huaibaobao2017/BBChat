//
//  CountryPhoneCodeViewController.swift
//  Center
//
//  Created by bb on 2017/11/24.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class PhoneCodeViewController: UITableViewController {
    
    lazy var phoneCodeView: PhoneCodeView = {
        let view = PhoneCodeView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setupUI()
    }

}

extension PhoneCodeViewController {
    
    private func setupUI() {
        self.title = "选择国家或地区"
        self.phoneCodeView.frame = self.view.bounds
        self.phoneCodeView.controller = self
        self.view = self.phoneCodeView
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        superNavigationBar(left: .stop, right: nil, isClear: false)
    }

}

