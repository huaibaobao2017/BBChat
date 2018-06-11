//
//  PhoneCodeTableViewCell.swift
//  Center
//
//  Created by bb on 2017/12/8.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit
import SnapKit

class PhoneCodeTableViewCell: UITableViewCell {
    
    var country = Country() {
        didSet {
            updateUI()
        }
    }
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private var detailTitelLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.textAlignment = .right
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhoneCodeTableViewCell {
    
    private func setupUI() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        self.addSubview(titleLabel)
        self.addSubview(detailTitelLabel)
    }
    
    private func updateUI() {
        self.titleLabel.text = country.countryName
        if country.phoneCode != "" {
            self.detailTitelLabel.text = "+\(country.phoneCode)"
        }
    }
    
    private func layoutSubview() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.width.greaterThanOrEqualTo(30)
        }
        detailTitelLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-20)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.width.greaterThanOrEqualTo(30)
        }
    }
}
