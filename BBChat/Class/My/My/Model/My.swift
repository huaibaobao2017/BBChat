//
//  My.swift
//  BBChat
//
//  Created by bb on 2018/1/16.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

class My: BaseSetting {

    @objc var section: String = ""
    
    @objc private var rows = [[String: String]]() {
        didSet {
            for row in rows {
                items.append(BaseSetting(dict: row))
            }
        }
    }
    
    @objc var items = [BaseSetting]()
    
}
