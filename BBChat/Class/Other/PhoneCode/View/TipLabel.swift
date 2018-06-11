//
//  TipLabel.swift
//  Center
//
//  Created by bb on 2017/12/8.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class TipLabel: UILabel {
    
    var title = "" {
        didSet {
            updateUI()
        }
    }
    
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

extension TipLabel {
    
    private func setupUI() {
        self.font = UIFont.boldSystemFont(ofSize: 30)
        self.textColor = UIColor.darkGray
        self.textAlignment = .center
        self.backgroundColor = UIColor.init(r: 0, g: 0, b: 0, a: 0.3)
        self.layer.masksToBounds = true
    }
    
    private func updateUI() {
        self.text = self.title
    }
    
    private func layoutSubview() {
        self.layer.cornerRadius = self.bounds.width / 2
    }
    
}
