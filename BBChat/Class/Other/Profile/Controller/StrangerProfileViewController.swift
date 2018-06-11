//
//  StrangerProfileViewController.swift
//  BBChat
//
//  Created by bb on 2018/6/8.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

class StrangerProfileViewController: UIViewController {
    
    var request = Request() {
        didSet {
            updateUI()
        }
    }
    
    private lazy var profileView: StrangerProfileView = {
        let view = StrangerProfileView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

extension StrangerProfileViewController {
    
    private func setupUI() {
        self.title = "详细信息"
        self.profileView.frame = self.view.bounds
        self.profileView.controller = self
        self.view = profileView
    }
    
    private func updateUI() {
        self.profileView.contact = self.request
    }
}


