//
//  NSData+AES.m
//  HMCS
//
//  Created by ??? on 16/11/30.
//  Copyright © 2016年 heming. All rights reserved.
//

#import "NSData+AES.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation NSData (AES)


- (NSData *)encryptedWithAESUsingKey:(NSString *)key andIV:(NSData *)iv {
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    size_t dataMoved;
    NSMutableData *encryptedData = [NSMutableData dataWithLength:self.length+kCCKeySizeAES128];

    CCCryptorStatus status = CCCrypt(kCCEncrypt,
                                     kCCAlgorithmAES128,
                                     kCCOptionPKCS7Padding, // Padding option for CBC Mode
                                     keyData.bytes,
                                     keyData.length,
                                     iv.bytes,
                                     self.bytes,
                                     self.length,
                                     encryptedData.mutableBytes,
                                     encryptedData.length,
                                     &dataMoved);
    
    if (status == kCCSuccess) {
        encryptedData.length = dataMoved;
        return encryptedData;
    }
    return nil;
}

- (NSData *)encryptedWithAESUsingKeyData:(NSData *)keyData andIV:(NSData *)iv{

    size_t dataMoved;
    NSMutableData *encryptedData = [NSMutableData dataWithLength:self.length+kCCKeySizeAES128];
    
    CCCryptorStatus status = CCCrypt(kCCEncrypt,
                                     kCCAlgorithmAES128,
                                     kCCOptionPKCS7Padding, // Padding option for CBC Mode
                                     keyData.bytes,
                                     keyData.length,
                                     iv.bytes,
                                     self.bytes,
                                     self.length,
                                     encryptedData.mutableBytes,
                                     encryptedData.length,
                                     &dataMoved);
    
    if (status == kCCSuccess) {
        encryptedData.length = dataMoved;
        return encryptedData;
    }
    return nil;
}

- (NSData *)decryptedWithAESUsingKey:(NSString *)key andIV:(NSData *)iv {
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    size_t dataMoved;
    NSMutableData *decryptedData = [NSMutableData dataWithLength:self.length+kCCKeySizeAES128];
    
    CCCryptorStatus status = CCCrypt(kCCDecrypt,
                                     kCCAlgorithmAES128,
                                     kCCOptionPKCS7Padding, // Padding option for CBC Mode
                                     keyData.bytes,
                                     keyData.length,
                                     iv.bytes,
                                     self.bytes,
                                     self.length,
                                     decryptedData.mutableBytes,
                                     decryptedData.length,
                                     &dataMoved);
    
    if (status == kCCSuccess) {
        decryptedData.length = dataMoved;
        return decryptedData;
    }
    return nil;
}

- (NSData *)decryptedWithAESUsingKeyData:(NSData *)keyData andIV:(NSData *)iv{
    {
        size_t dataMoved;
        NSMutableData *decryptedData = [NSMutableData dataWithLength:self.length+kCCKeySizeAES128];
        
        CCCryptorStatus status = CCCrypt(kCCDecrypt,
                                         kCCAlgorithmAES128,
                                         kCCOptionPKCS7Padding, // Padding option for CBC Mode
                                         keyData.bytes,
                                         keyData.length,
                                         iv.bytes,
                                         self.bytes,
                                         self.length,
                                         decryptedData.mutableBytes,
                                         decryptedData.length,
                                         &dataMoved);
        
        if (status == kCCSuccess) {
            decryptedData.length = dataMoved;
            return decryptedData;
        }
        return nil;
    }
}

@end
