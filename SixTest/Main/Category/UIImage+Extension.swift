//
//  UIImage+Extension.swift
//  SixTest
//
//  Created by IMAC on 2017/6/14.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

extension UIImage{
    
    func clipImage() -> (UIImage) {
        // 开始图形上下文
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0)
        // 获得图形上下文
        let ctx = UIGraphicsGetCurrentContext()
        // 设置一个范围
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.width)
        // 根据一个rect创建一个椭圆
        ctx?.addEllipse(in: rect)
        // 裁剪
        ctx?.clip()
        // 将原照片画到图形上下文
        draw(in: rect)
        // 从上下文上获取剪裁后的照片
        let newImgae = UIGraphicsGetImageFromCurrentImageContext()
        // 关闭上下文
        UIGraphicsEndImageContext()
        return newImgae!
    }
}
