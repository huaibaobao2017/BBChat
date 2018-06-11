//
//  MyView.swift
//  BBChat
//
//  Created by bb on 2017/12/25.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit



class MyView: BaseTableViewView {
    
    var mys = [My]() {
        didSet {
            updateUI()
        }
    }
    
    private lazy var vm = MyViewModel()
    
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

extension MyView {
    
    private func setupUI() {
        self.backgroundColor = UIColor.white
        self.addSubview(tableView)
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

extension MyView {
    
    private func loadData() {
        self.vm.loadData { (mys) in
            self.mys = mys
        }
    }
}

extension MyView {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 90
        default:
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.vm.pushViewController(indexPath: indexPath)
    }

}

extension MyView {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.mys.count + 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return self.mys[section - 1].items.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = MyUserTableViewCell(style: .subtitle, reuseIdentifier: KMyUserTableViewCellID)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: KMyTableViewCellID, for: indexPath) as! MyTableViewCell
            cell.my = self.mys[indexPath.section - 1].items[indexPath.row]
            return cell
        }
    }
}

