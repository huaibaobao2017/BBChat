////
////  GroupListViewController.swift
////  BBChat
////
////  Created by bb on 2018/1/3.
////  Copyright © 2018年 bb. All rights reserved.
////
//
//import UIKit
//
//class GroupListViewController: UIViewController {
//
//    private lazy var groupListView: GroupListView = {
//        let view = GroupListView()
//        return view
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//    }
//
//}
//
//extension GroupListViewController {
//
//    private func setupUI() {
//        self.title = "群聊"
//        self.definesPresentationContext = true
//        self.groupListView.frame = self.view.bounds
//        self.groupListView.controller = self
//        self.view = groupListView
//    }
//
//    private func updateUI() {
//
//    }
//}
//
