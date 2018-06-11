//
//  AvatarView.swift
//  BBChat
//
//  Created by bb on 2017/12/25.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SDWebImage
import Hyphenate

class AvatarView: UIView {
    
    private lazy var avatarImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "demo6")
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
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

extension AvatarView {
    
    private func setupUI() {
        self.backgroundColor = UIColor.white
        self.addSubview(avatarImageView)
        updateUI()
        // 监听通知，若本地未缓存头像，则从服务器获取。
        NOTIFY_ADD(target: self, name: KContactInfoDidUpdateNotification, selector: #selector(updateUI))
    }
    
    @objc private func updateUI() {
        // 当前用户的环信ID
        guard let currentUsername = EMClient.shared().currentUsername else { return }
        let avatarUrl = MessageHelper.shared.avatarUrl(chatId: currentUsername)
        self.avatarImageView.sd_setImageWithPreviousCachedImage(with: avatarUrl, placeholderImage: UIImage(named: "demo6"), progress: nil)
    }
    
    private func layoutSubview() {
        avatarImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-MGNavHeight/2)
            make.width.equalTo(self)
            make.height.equalTo(avatarImageView.snp.width)
        }
    }
}
