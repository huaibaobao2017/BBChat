//
//  SelectContactTableViewCell.swift
//  BBChat
//
//  Created by bb on 2018/1/2.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

class SelectContactTableViewCell: BaseContactListTableViewCell {
    
    open override var isSelected: Bool {
        didSet{
            if isSelected {
                selectedButton.isSelected = true
            }else{
                selectedButton.isSelected = false
            }
        }
    }
    
    // 是否选中
    private lazy var selectedButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "zz_image_cell_selected"), for: .selected)
        view.setImage(UIImage(named: "zz_image_cell"), for: .normal)
        view.layer.cornerRadius = 15
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

extension SelectContactTableViewCell {
    
    private func setupUI() {
        self.addSubview(selectedButton)
    }

    private func layoutSubview() {
        selectedButton.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.centerY.equalTo(self)
            make.height.equalTo(30)
            make.width.equalTo(selectedButton.snp.height)
        }
        contactImageView.snp.updateConstraints { (make) in
            make.left.equalTo(50)
            make.top.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-10)
            make.width.equalTo(contactImageView.snp.height)
        }
        contactNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contactImageView.snp.right).offset(10)
            make.top.equalTo(contactImageView)
            make.right.equalTo(self).offset(-15)
            make.bottom.equalTo(contactImageView)
        }
    }
    
}
