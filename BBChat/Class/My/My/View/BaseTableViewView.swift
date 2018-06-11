//
//  BaseMyView.swift
//  BBChat
//
//  Created by bb on 2018/1/17.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

private let KBaseTableViewCellID = "KBaseTableViewCellID"
// 个人信息
let KBaseSettingTableViewCellID = "KBaseSettingTableViewCellID"
let KAvatarTableViewCellID = "KAvatarTableViewCellID"
//  my
let KMyTableViewCellID = "KMyTableViewCellID"
let KMyUserTableViewCellID = "KMyUserTableViewCellID"

class BaseTableViewView: UIView {

    lazy var tableView: UITableView = { [unowned self] in
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.colorHex(hex: "#d9d9d9")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: KBaseTableViewCellID)
        tableView.register(BaseSettingTableViewCell.self, forCellReuseIdentifier: KBaseSettingTableViewCellID)
        tableView.register(AvatarTableViewCell.self, forCellReuseIdentifier: KAvatarTableViewCellID)
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: KMyTableViewCellID)
        tableView.register(MyUserTableViewCell.self, forCellReuseIdentifier: KMyUserTableViewCellID)
        return tableView
    }()

}

extension BaseTableViewView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
}

extension BaseTableViewView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KBaseTableViewCellID, for: indexPath)
        return cell
    }
    
}
