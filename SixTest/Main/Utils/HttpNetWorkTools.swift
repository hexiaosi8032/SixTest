//
//  HttpNetWorkTools.swift
//  SixTest
//
//  Created by IMAC on 2017/5/29.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import MBProgressHUD
import AFNetworking
import SVProgressHUD

class HttpNetWorkTools: NSObject {

    var manager:AFHTTPSessionManager = AFHTTPSessionManager()
    
    static let instance:HttpNetWorkTools = HttpNetWorkTools()
    class func shareNetWorkTools() -> HttpNetWorkTools {
        return instance
    }
    
    override init() {
        super.init()
        var headerDic = [String:String]()
        headerDic["Charset"] = "UTF-8"
        headerDic["User-Agent"] = "iPhone"
        headerDic["Accept-Encoding"] = "gzip"
        
        // 设置发送和返回内容为二进制
//        manager.responseSerializer = AFHTTPResponseSerializer()
//        manager.requestSerializer = AFHTTPRequestSerializer()
        manager.requestSerializer.timeoutInterval = 30
//        manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as? Set<String>
       
        for key:String in headerDic.keys {
            manager.requestSerializer.setValue(headerDic[key], forHTTPHeaderField: key)
        }
    }
    
    func postAFNHttp(urlStr:String,parameters:[String:Any],success:@escaping (HttpModel)->(),failure:@escaping (Error)->()) -> () {

        let url = kDefaultDomain + urlStr
        
        print("发送请求为---\(url) \n  参数为---\(parameters)")
        SVProgressHUD.show()

        manager.post(url, parameters: parameters, progress: nil, success: { (task:URLSessionDataTask, responseObject:Any) in
            
//            try? JSONSerialization.jsonObject(with: responseObject as! Data, options: JSONSerialization.ReadingOptions.mutableContainers)
//            guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []),
//                filePath = accountFile.cz_appendDocumentDir()
//                else {
//                    return
//            }
            guard let JSON:[String : Any] = responseObject as? [String : Any]
                else {
                    print("返回数据为空")
                    return
            }
       
            let data : NSData! = try? JSONSerialization.data(withJSONObject: JSON, options: []) as NSData!
            let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
            print("返回数据为\n\(String(describing: JSONString ?? ""))")
            
            let model = HttpModel()
            model.setValuesForKeys(JSON)
            if model.statusCode == "SUCCESS"{
                success(model)
            }
            SVProgressHUD.dismiss()
        }) { (task:URLSessionDataTask?, error:Error) in
            failure(error)
            SVProgressHUD.dismiss()
        }
    }
    
}
