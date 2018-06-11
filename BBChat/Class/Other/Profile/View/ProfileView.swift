//
//  ProfileView.swift
//  BBChat
//
//  Created by bb on 2017/12/20.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import Hyphenate

private let KProfileTableViewCellID = "KProfileTableViewCellID"

class ProfileView: UIView {
    
    var contact = Contact() {
        didSet {
            loadData()
        }
    }
    
    var isFriend = false {
        didSet {
            print("isFriend：\(isFriend)")
            updateUI()
        }
    }
    
    weak var controller = UIViewController() {
        didSet {
            self.vm.controller = self.controller
            self.footerView.controller = self.controller
        }
    }
    
    private lazy var vm = ProfileViewModel()
    
    var headerView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.frame = CGRect(x: 0, y: 0, width: MGScreenW, height: 80)
        return view
    }()
    
    var footerView: ProfileFooterView = {
        let view = ProfileFooterView()
        view.frame = CGRect(x: 0, y: 0, width: MGScreenW, height: 148)
        return view
    }()
    
    private lazy var tableView: UITableView = { [unowned self] in
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.colorHex(hex: "#d9d9d9")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: KProfileTableViewCellID)
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

extension ProfileView {
    
    private func setupUI() {
        self.backgroundColor = UIColor.white
        self.addSubview(tableView)
    }
    
    private func updateUI() {
        self.headerView.contact = self.contact
        self.footerView.contact = self.contact
        self.footerView.isFriend = self.isFriend
        self.tableView.reloadData()
    }
    
    private func layoutSubview() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
}

extension ProfileView {
    
    private func loadData() {
        self.isFriend = self.vm.isFriend(contact: self.contact)
    }
}

extension ProfileView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //self.vm.pushViewController(indexPath: indexPath)
    }
    
}

extension ProfileView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return self.vm.sectionRowCount(isFriend: self.isFriend, contact: self.contact)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KProfileTableViewCellID, for: indexPath)
        return cell
    }
}
