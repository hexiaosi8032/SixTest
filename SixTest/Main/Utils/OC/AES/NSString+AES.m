//
//  NSString+AES.m
//  HMCS
//
//  Created by ??? on 16/11/30.
//  Copyright © 2016年 heming. All rights reserved.
//

#import "NSString+AES.h"
#import "NSString+AES.h"
#import "NSData+AES.h"
#import "Base64.h"

@implementation NSString (AES)

- (NSString *)encryptedWithAESUsingKey:(NSString *)key andIV:(NSData *)iv {
    
    NSData *encryptedData = [[self dataUsingEncoding:NSUTF8StringEncoding] encryptedWithAESUsingKey:key andIV:iv];
    NSString *encryptedStr = [Base64 stringByEncodingData:encryptedData];
    return encryptedStr;
}

- (NSString *)encryptedWithAESUsingKeyData:(NSData *)keyData andIV:(NSData *)iv{
    NSData *encryptedData = [[self dataUsingEncoding:NSUTF8StringEncoding] encryptedWithAESUsingKeyData:keyData andIV:iv];
    NSString *encryptedStr = [Base64 stringByEncodingData:encryptedData];
    return encryptedStr;
}

- (NSString *)decryptedWithAESUsingKey:(NSString *)key andIV:(NSData *)iv {

    NSData *decryptedData = [[Base64 decodeString:self] decryptedWithAESUsingKey:key andIV:iv];
    NSString *decyptedStr = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
    return decyptedStr;
}

- (NSString *)decryptedWithAESUsingKeyData:(NSData *)keyData andIV:(NSData *)iv{
    NSData *decryptedData = [[Base64 decodeString:self] decryptedWithAESUsingKeyData:keyData andIV:iv];
    NSString *decyptedStr = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
    return decyptedStr;
}

@end
