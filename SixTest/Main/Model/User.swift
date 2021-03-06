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
    var sessionID:String?
    var nickName:String?
    
    static let instance:User = User()
    func clean() -> () {
        isLogin = false
        userName = nil
        userID = nil
        publishDateNo = nil
        AESKey = nil
        userRole = nil
        sessionID = nil
        nickName = nil
    }
    
    class func sharedInstance() -> User {
        return instance
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "id"{
            userID = String(describing: value!)
        }

    }
    
}
