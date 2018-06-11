//
//  ContactSearchViewController.swift
//  BBChat
//
//  Created by bb on 2018/1/4.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
// 联系人搜索 控制器
class ContactSearchViewController: BaseSearchViewController {
    
    private lazy var contactSearchView: ContactSearchView = {
        let view = ContactSearchView()
        return view
    }()
    
    override func setupUI() {
        self.contactSearchView.frame = self.containerView.bounds
        self.containerView.insertSubview(contactSearchView, at: 0)
    }
    
}

extension ContactSearchViewController {
    
}
