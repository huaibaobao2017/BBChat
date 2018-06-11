//
//  InfoViewController.swift
//  BBChat
//
//  Created by bb on 2017/12/25.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var infoView: InfoView = {
        let view = InfoView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

extension InfoViewController {
    
    private func setupUI() {
        self.title = "个人信息"
        self.infoView.frame = self.view.bounds
        self.infoView.controller = self
        self.view = infoView
    }
    
    private func updateUI() {
        
    }
    
}
