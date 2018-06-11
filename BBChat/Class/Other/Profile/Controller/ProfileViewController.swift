//
//  ProfileViewController.swift
//  BBChat
//
//  Created by bb on 2017/12/20.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var contact = Contact() {
        didSet {
            updateUI()
        }
    }
    
    private lazy var profileView: ProfileView = {
        let view = ProfileView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

extension ProfileViewController {
    
    private func setupUI() {
        self.title = "详细信息"
        self.profileView.frame = self.view.bounds
        self.profileView.controller = self
        self.view = profileView
    }
    
    private func updateUI() {
        self.profileView.contact = self.contact
    }
}

