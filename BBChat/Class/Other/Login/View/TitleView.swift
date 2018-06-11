//
//  TitleView.swift
//  Center
//
//  Created by bb on 2017/11/20.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class TitleView: UIView {
    
    var menberForm = MenberForm() {
        didSet {
            updateUI()
        }
    }
    
    // 登录／注册 大标题
    lazy var titlelabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.colorHex(hex: "#333333")
        label.font = UIFont.systemFont(ofSize: 24)
        return label
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

extension TitleView {
    
    private func setupUI() {
        self.addSubview(titlelabel)
    }
    
    private func updateUI() {
        self.titlelabel.text = self.menberForm.title
    }
    
    private func layoutSubview() {
        titlelabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}
