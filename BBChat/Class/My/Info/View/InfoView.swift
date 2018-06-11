//
//  InfoView.swift
//  BBChat
//
//  Created by bb on 2018/1/17.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

class InfoView: BaseTableViewView {

    var settings = [Setting]() {
        didSet {
            updateUI()
        }
    }
    
    private lazy var vm = InfoViewModel()
    
    weak var controller = UIViewController() {
        didSet {
            self.vm.controller = self.controller
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        loadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension InfoView {
    
    private func setupUI() {
        self.backgroundColor = UIColor.white
        self.addSubview(tableView)
        NOTIFY_ADD(target: self, name: KContactInfoDidUpdateNotification, selector: #selector(updateUI))
    }
    
    @objc private func updateUI() {
        self.tableView.reloadData()
    }
    
    private func layoutSubview() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
}

extension InfoView {
    
    private func loadData() {
        self.vm.loadData { (settings) in
            self.settings = settings
        }
    }
}

extension InfoView {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return 85
            default:
                return 44
            }
        default:
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.vm.openViewController(indexPath: indexPath)
    }
    
}

extension InfoView {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.settings.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settings[section].rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: BaseSettingTableViewCell
        if indexPath.section == 0 && indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: KAvatarTableViewCellID, for: indexPath) as! AvatarTableViewCell
            cell.setting = self.settings[indexPath.section].rows[indexPath.row]
        } else {
            cell = BaseSettingTableViewCell(style: .value1, reuseIdentifier: KBaseSettingTableViewCellID)
            cell.setting = self.settings[indexPath.section].rows[indexPath.row]
        }
        return cell
    }
    
}
