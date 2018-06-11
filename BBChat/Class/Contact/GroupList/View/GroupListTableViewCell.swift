//
//  GroupListTableViewCell.swift
//  BBChat
//
//  Created by bb on 2018/1/3.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
import Hyphenate

class GroupListTableViewCell: BaseTableViewCell {
    
    var group: EMGroup? = nil {
        didSet {
            updateUI()
        }
    }
    
    // 联系人头像
    lazy var groupImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "demo6")
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    // 联系人昵称
    lazy var groupNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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

extension GroupListTableViewCell {
    
    private func setupUI() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        self.addSubview(groupImageView)
        self.addSubview(groupNameLabel)
    }
    
    private func updateUI() {
        guard let group = self.group else { return }
        // 通讯录联系人的头像
        self.groupImageView.sd_setImageWithPreviousCachedImage(with: URL(string: ""), placeholderImage: UIImage(named: "demo6"), progress: nil)
        // 通讯录联系人的昵称
        self.groupNameLabel.text = "\(String(describing: group))"
    }
    
    private func layoutSubview() {
        groupImageView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-10)
            make.width.equalTo(groupImageView.snp.height)
        }
        groupNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(groupImageView.snp.right).offset(10)
            make.top.equalTo(groupImageView)
            make.right.equalTo(self).offset(-15)
            make.bottom.equalTo(groupImageView)
        }
    }
}

