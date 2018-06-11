//
//  AvatarTableViewCell.swift
//  BBChat
//
//  Created by bb on 2018/1/17.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
import Hyphenate

class AvatarTableViewCell: BaseSettingTableViewCell {
    
    // 当前用户的环信ID
    let currentUsername = EMClient.shared().currentUsername

    override var setting: String {
        didSet {
            updateUI()
            // 当前用户头像
            let avatarUrl = MessageHelper.shared.avatarUrl(chatId: currentUsername)
            self.avatarImageView.sd_setImage(with: avatarUrl, placeholderImage: UIImage(named: "demo6"))
            self.avatarImageView.sd_setImageWithPreviousCachedImage(with: avatarUrl, placeholderImage: UIImage(named: "demo6"), progress: nil)
        }
    }
    // 当前用户头像
    lazy var avatarImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "demo6")
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
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

extension AvatarTableViewCell {
    
    private func setupUI() {
        self.addSubview(avatarImageView)
    }
    
    private func layoutSubview() {
        avatarImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-10)
            make.width.equalTo(avatarImageView.snp.height)
            make.right.equalTo(-35)
        }
    }
    
}
