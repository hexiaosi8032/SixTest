//
//  User.swift
//  SixTest
//
//  Created by IMAC on 2017/6/15.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class User: NSObject {

    var isLogin:Bool = false
    var userName:String?
    var userID:String?
    var publishDateNo:String?
    var AESKey:String?
    var userRole:String?
    
    static let instance:User = User()
    func clean() -> () {
        isLogin = false
        userName = nil
        userID = nil
        publishDateNo = nil
        AESKey = nil
    }
    
    class func sharedInstance() -> User {
        return instance
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
