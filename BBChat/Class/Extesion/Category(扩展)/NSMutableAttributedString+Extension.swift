//
//  NSMutableAttributedString+Extension.swift
//  Center
//
//  Created by bb on 2017/11/17.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    
    convenience init(str: String, lineSpacing: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing //调整行间距
        let range = NSRange(location: 0, length: str.length)
        self.init(string: str, attributes: [NSAttributedStringKey.paragraphStyle: paragraphStyle, NSAttributedStringKey.kern: 0.3])
        self.addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
    }
    
}
