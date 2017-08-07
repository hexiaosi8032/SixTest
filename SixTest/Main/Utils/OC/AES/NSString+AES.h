//
//  NSString+AES.h
//  HMCS
//
//  Created by ??? on 16/11/30.
//  Copyright © 2016年 heming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AES)

/**
 AES 128 bytes 加密
 */
- (NSString *)encryptedWithAESUsingKey:(NSString *)key andIV:(NSData *)iv;

- (NSString *)encryptedWithAESUsingKeyData:(NSData *)keyData andIV:(NSData *)iv;

/**
 AES 128 bytes 解密
 */
- (NSString *)decryptedWithAESUsingKey:(NSString *)key andIV:(NSData *)iv;

- (NSString *)decryptedWithAESUsingKeyData:(NSData *)keyData andIV:(NSData *)iv;

@end
