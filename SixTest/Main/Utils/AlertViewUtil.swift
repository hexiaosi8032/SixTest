//
//  AlertViewUtil.swift
//  SixTest
//
//  Created by IMAC on 2017/6/3.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

class AlertViewUtil: NSObject {

    class func alertShow(message:String,controller:UIViewController?,confirmTitle:String) -> () {
        var controller = controller
        if controller == nil {
            controller = UIApplication.shared.keyWindow?.rootViewController
        }
        
        let alertVC = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: confirmTitle, style: .cancel, handler: nil))
        controller?.present(alertVC, animated: true, completion: nil)

    }
    
    class func alertShow(warnString:String,message:String,controller:UIViewController?,confirmTitle:String,cancleTitie:String,confirmBlock:(()->())?,cancleBlock:(()->())?) -> () {
        var controller = controller
        if controller == nil {
            controller = UIApplication.shared.keyWindow?.rootViewController
        }
        
        let alertVC = UIAlertController(title: warnString, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: confirmTitle, style: .destructive, handler: { (_) in
            confirmBlock?()
        }))
        alertVC.addAction(UIAlertAction(title: cancleTitie, style: .cancel, handler: { (_) in
            cancleBlock?()
        }))
        controller?.present(alertVC, animated: true, completion: nil)
    }
    
    class func alertSheetShow(messages:[String],controller:UIViewController?,confirmBlock:@escaping (Int)->(),cancleBlock:(()->())?) -> () {
        
        var controller = controller
        if controller == nil {
            controller = UIApplication.shared.keyWindow?.rootViewController
        }
        
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for i in 0..<messages.count {
            sheet.addAction(UIAlertAction(title: messages[i], style: .default, handler: { (_) in
                confirmBlock(i)
            }))
        }
        
        sheet.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (_) in
            cancleBlock?()
        }))
        controller?.present(sheet, animated: true, completion: nil)
        
    }
    
}
