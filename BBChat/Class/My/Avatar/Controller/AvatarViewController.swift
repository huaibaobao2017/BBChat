//
//  AvatarViewController.swift
//  BBChat
//
//  Created by bb on 2017/12/25.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import Photos

class AvatarViewController: UITableViewController {
    
    private lazy var vm = AvatarViewModel()
    
    private lazy var avatarView: AvatarView = {
        let view = AvatarView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

extension AvatarViewController {
    
    private func setupUI() {
        self.title = "个人头像"
        self.avatarView.frame = self.view.bounds
        self.vm.controller = self
        self.view = avatarView
        setupNavigationBar()
    }
    
    private func updateUI() {
        
    }
    
    // 设置导航栏右item
    func setupNavigationBar() {
        let normal = "ic_element_mt_add_normal"
        let highlighted = "ic_element_mt_add_normal"
        superNavigationBar(normal: normal, highlighted: highlighted)
    }
    
    override func rightItemAction() {
        self.vm.actionsheet()
    }
}
