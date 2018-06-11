//
//  BaseNavigationBar.swift
//  BBChat
//
//  Created by bb on 2018/1/29.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

class BaseNavigationBar: UINavigationBar {
    
    /// 深黑色半透明
    var blurBackView: UIView = {
        let blurBackView = UIView()
        blurBackView.frame = CGRect(x: 0, y: -20, width: MGScreenW, height: 64)
        let gradintLayer = CAGradientLayer()
        gradintLayer.frame = blurBackView.bounds
        gradintLayer.colors = [
            UIColor.hexInt(0x040012).withAlphaComponent(0.76).cgColor,
            UIColor.hexInt(0x040012).withAlphaComponent(0.28).cgColor
        ]
        gradintLayer.startPoint = CGPoint(x: 0, y: 0)
        gradintLayer.endPoint = CGPoint(x: 0, y: 1.0)
        blurBackView.layer.addSublayer(gradintLayer)
        blurBackView.isUserInteractionEnabled = false
        blurBackView.alpha = 0.5
        return blurBackView
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

extension BaseNavigationBar {
    
    private func setupUI() {
        let barBackground = self.subviews.first
        if (self.blurBackView.superview == nil) {
            barBackground?.addSubview(self.blurBackView)
        }
        self.barStyle = .black
        self.tintColor = UIColor.white
    }
    
    private func layoutSubview() {
        self.blurBackView.frame = self.bounds
        guard let superview = self.blurBackView.superview else { return }
        superview.bringSubview(toFront: self.blurBackView)
    }
    
}
