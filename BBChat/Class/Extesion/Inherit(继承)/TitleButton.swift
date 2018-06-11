//
//  TitleButton.swift
//  Center
//
//  Created by bb on 2017/11/3.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class TitleButton: UIButton {
    // 如果在控件中重写init(frame: CGRect)函数,必须重写init(coder : NSCoder)
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitle("任务进度", for: .normal)
        setTitleColor(UIColor.orange, for: .normal)
        setTitleColor(UIColor.white, for: .highlighted)
        setImage(UIImage(named: "navigationbar_arrow_up"), for: .normal)
        setImage(UIImage(named: "navigationbar_arrow_down"), for: .selected)
        
        sizeToFit()
    }
    
    // 如果在控件中重写init(frame: CGRect)函数,必须重写init(coder : NSCoder)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Swift中可以直接修改对象中的结构内部的属性
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = (titleLabel?.frame.size.width)! + 5
    }

}
