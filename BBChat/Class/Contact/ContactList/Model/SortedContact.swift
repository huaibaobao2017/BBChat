//
//  SortedContact.swift
//  BBChat
//
//  Created by bb on 2017/12/28.
//  Copyright © 2017年 bb. All rights reserved.
//

import UIKit

class SortedContact: NSObject {

    @objc var firstLetter: String = ""
    
    @objc var contacts = [Contact]() {
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
