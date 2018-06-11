//
//  Contact.swift
//  BBWB
//
//  Created by bb on 2018/4/23.
//  Copyright © 2018年 bb. All rights reserved.
//

import UIKit
import LeanCloud

class Contact: LCObject  {
    
    @objc dynamic var chatId: LCString = ""
    
    @objc dynamic var nickName: LCString = ""
    
    @objc dynamic var avatarUrl: LCString = ""
    
    @objc dynamic var expiredDate: LCNumber = 0
    
    @objc dynamic var phone: LCString = ""
    
    @objc dynamic var sex: LCString = ""
    
    @objc dynamic var chatNumber: LCString = ""
    
    @objc dynamic var signature: LCString = ""
    
    @objc dynamic var region: LCString = ""
    
    @objc dynamic var firstLetter: LCString = ""
    
    
    override static func objectClassName() -> String {
        return "Contact"
    }
}
