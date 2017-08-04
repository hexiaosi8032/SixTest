//
//  NSString-Extension.swift
//  SixTest
//
//  Created by IMAC on 2017/6/24.
//  Copyright © 2017年 小四. All rights reserved.
//

import Foundation

extension NSString{
    func sizeWithFont(font:UIFont,maxW:CGFloat) -> CGSize {
        let maxSize = CGSize(width: maxW, height: CGFloat(MAXFLOAT))
        return self.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : font], context: nil).size
    }
    
}

extension String{
    func sizeWithFont(font:UIFont,maxW:CGFloat) -> CGSize {
        let maxSize = CGSize(width: maxW, height: CGFloat(MAXFLOAT))
        return self.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : font], context: nil).size
    }
}
