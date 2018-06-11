//
//  NickNameEditingViewController.swift
//  BBChat
//
//  Created by bb on 2017/12/28.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

private let KSettingTableViewCellID = "KSettingTableViewCellID"

class NickNameEditingViewController: BaseSettingViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KSettingTableViewCellID, for: indexPath) as! NickNameSettingTableViewCell
        cell.controller = self
        return cell
    }
    
}

extension NickNameEditingViewController {
    
    private func setupUI() {
        self.title = "设置名字"
        tableView.register(NickNameSettingTableViewCell.self, forCellReuseIdentifier: KSettingTableViewCellID)
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        superNavigationBar(left: nil, right: "保存", isClear: false)
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
}

extension NickNameEditingViewController {
    
    override func leftItemAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func rightItemAction() {
        print("保存")
    }
    
}

