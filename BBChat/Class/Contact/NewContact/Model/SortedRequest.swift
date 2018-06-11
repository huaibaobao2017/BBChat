//
//  SortedRequest.swift
//  BBChat
//
//  Created by bb on 2018/6/1.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit

class SortedRequest: NSObject {
    
    @objc var sectionTitle: String = ""
    
    @objc var requests = [Request]() {
        didSet {
            
        }
    }
    
    override init() {
        super.init()
    }
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}

