//
//  NewContactAddTableViewCell.swift
//  BBChat
//
//  Created by bb on 2018/1/4.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

class NewContactAddTableViewCell: UITableViewCell {
    
    lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "NewFriend_Contacts_icon")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "添加手机联系人"
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 14)
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

extension NewContactAddTableViewCell {
    
    private func setupUI() {
        for subview in self.contentView.subviews {
            subview.removeFromSuperview()
        }
        self.backgroundColor = UIColor.white
        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(titleLabel)
    }
    
    private func updateUI() {

    }
    
    private func layoutSubview() {
        iconImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.centerX.equalTo(self)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(iconImageView.snp.bottom).offset(5)
        }
    }
}

