//
//  MyViewController.swift
//  BBChat
//
//  Created by bb on 2017/12/25.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {
    
    private lazy var myView: MyView = {
        let view = MyView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

extension MyViewController {
    
    private func setupUI() {
        self.myView.frame = self.view.bounds
        self.myView.controller = self
        self.view = myView
    }
    
    private func updateUI() {
        
    }
}
