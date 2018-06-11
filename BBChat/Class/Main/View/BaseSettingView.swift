//
//  BaseSettingView.swift
//  BBChat
//
//  Created by bb on 2017/12/28.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

private let KSettingTableViewCellID = "KSettingTableViewCellID"

class BaseSettingView: UIView {
    
    lazy var tableView: UITableView = { [unowned self] in
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.colorHex(hex: "#d9d9d9")
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: KSettingTableViewCellID)
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BaseSettingView {
    
    private func setupUI() {
        self.backgroundColor = UIColor.white
        self.addSubview(tableView)
        NOTIFY_ADD(target: self, name: KContactInfoDidUpdateNotification, selector: #selector(updateUI))
    }
    
    @objc func updateUI() {
        tableView.reloadData()
    }

    private func layoutSubview() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
}

extension BaseSettingView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension BaseSettingView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KBaseSettingTableViewCellID, for: indexPath)
        return cell
    }
    
}
