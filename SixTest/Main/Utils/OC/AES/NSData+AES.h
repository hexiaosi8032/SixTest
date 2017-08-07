//
//  NSData+AES.h
//  HMCS
//
//  Created by ??? on 16/11/30.
//  Copyright © 2016年 heming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES)

/**
 AES 128 bytes 加密
 */
- (NSData *)encryptedWithAESUsingKey:(NSString *)key andIV:(NSData *)iv;

- (NSData *)encryptedWithAESUsingKeyData:(NSData *)keyData andIV:(NSData *)iv;

/**
 AES 128 bytes 解密
 */
- (NSData *)decryptedWithAESUsingKey:(NSString *)key andIV:(NSData *)iv;

- (NSData *)decryptedWithAESUsingKeyData:(NSData *)keyData andIV:(NSData *)iv;

@end
