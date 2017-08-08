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

        var parameters = parameters
        //加密
        if (parameters["operationType"] != nil) {
            parameters = encrypted(parameters: parameters)
        }
        
        let url = kDefaultDomain + urlStr
        
        print("发送请求为---\(url) \n  参数为---\(parameters)")
        SVProgressHUD.show()

        manager.post(url, parameters: parameters, progress: nil, success: {
            [weak self]
            (task:URLSessionDataTask, responseObject:Any) in
            
            guard let JSON:[String : Any] = responseObject as? [String : Any]
                else {
                    AlertViewUtil.alertShow(message: "数据解析失败", controller: nil, confirmTitle: "确定")
                    print("返回数据为空")
                    return
            }
       
            let data : NSData! = try? JSONSerialization.data(withJSONObject: JSON, options: []) as NSData!
            let JSONString = String(data: data as Data, encoding: .utf8)
            print("返回数据为\n\(String(describing: JSONString ?? ""))")
            
            let model = HttpModel()
            model.setValuesForKeys(JSON)
            //解密
            if (parameters["operationType"] != nil) {
                model.data = self?.decrypted(jsonString: JSON["data"] as! String) as AnyObject
            }
            
            if model.statusCode == "SUCCESS"{
                success(model)
            }
            
            else if model.statusCode == "DATA_CHECK_FAIL"{
                AlertViewUtil.alertShow(message: model.message ?? "数据请求失败", controller: nil, confirmTitle: "确定")
            }
            //SESSION 过期 清理所有COOKIES 与用户对象的缓存 还有AES秘钥
            //需要重新登录
            else if model.statusCode == "USER_KEY_EXPIRE"{
                User.sharedInstance().clean()
                AlertViewUtil.alertShow(warnString: "提示", message: "session失效,请重新登录!", controller: nil, confirmTitle: "确定", cancleTitie: "取消", confirmBlock: {
                    let loginVC = LoginViewController()
                    loginVC.block = {
                        success(model)
                    }
                    UIApplication.shared.keyWindow?.rootViewController?.present(loginVC, animated: true, completion: nil)
                }, cancleBlock:nil)
            }
            
            SVProgressHUD.dismiss()
            
        }) { (task:URLSessionDataTask?, error:Error) in
            AlertViewUtil.alertShow(message: "请求数据失败", controller: nil, confirmTitle: "确定")
            failure(error)
            SVProgressHUD.dismiss()
        }
    }
    
    //加密
    func encrypted(parameters:[String:Any]) -> ([String:Any]) {
        var dic = [String:Any]()
        var parameters = parameters

        for (key,value) in parameters {
            if key != "operationType" {
                dic[key] = value
                parameters.removeValue(forKey: key)
            }
        }
        guard let data =  try? JSONSerialization.data(withJSONObject: dic, options: []) else {
            print("加密json失败")
            return [:]
        }
        
        let jsonStr = String(data: data, encoding: .utf8) ?? ""
        let secretStr = NSString(string: jsonStr).encryptedWithAES(usingKey: User.sharedInstance().AESKey, andIV: AES_IV)
        parameters["requestData"] = secretStr
        
        return parameters
    }
    
    //解密
    func decrypted(jsonString:String) -> (Any) {
      
        let decryptedString = NSString(string: jsonString).decryptedWithAES(usingKey: User.sharedInstance().AESKey, andIV: AES_IV)
        
        guard let jsonData = try? JSONSerialization.jsonObject(with: (decryptedString?.data(using: .utf8))!, options: .allowFragments) else {
            return ""
        }
        
        return jsonData
    }
    
    
}
