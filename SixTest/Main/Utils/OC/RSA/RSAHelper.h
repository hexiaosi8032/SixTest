//
//  RSAHelper.h
//  RSADemo
//
//  Created by IMAC on 2017/3/23.
//  Copyright © 2017年 IMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSAHelper : NSObject

+ (instancetype)shareInstance;

- (NSString *)decrypted:(NSString *)encryptedText;

- (NSString *)encrypted:(NSString *)plainText;

- (NSString *)getPublishKey;
- (NSString *)getPrivateKey;

@end
