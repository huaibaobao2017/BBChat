//
//  BaseTableViewCell.swift
//  BBChat
//
//  Created by bb on 2017/12/22.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override func setSelected(_ selected: Bool, animated: Bool) {
        let subViews = self.subviews
        var colors = [UIColor]()
        for subview in subviews {
            colors.append(subview.backgroundColor ?? UIColor.clear)
        }
        super.setSelected(selected, animated: animated)
        for (index, subView) in subViews.enumerated() {
            subView.backgroundColor = colors[index]
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let subViews = self.subviews
        var colors = [UIColor]()
        for subview in subviews {
            colors.append(subview.backgroundColor ?? UIColor.clear)
        }
        super.setHighlighted(highlighted, animated: animated)
        for (index, subView) in subViews.enumerated() {
            subView.backgroundColor = colors[index]
        }
    }

}
