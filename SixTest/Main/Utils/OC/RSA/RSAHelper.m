//
//  RSAHelper.m
//  RSADemo
//
//  Created by IMAC on 2017/3/23.
//  Copyright © 2017年 IMAC. All rights reserved.
//

#import "RSAHelper.h"
#import "rsa.h"
#import "pem.h"
#import "RSAUtil.h"

@interface RSAHelper ()

{
    RSA *keyPairs;
    NSString *publishKeyStr;
    NSString *privateKeyStr;
}

@end

@implementation RSAHelper

+ (instancetype)shareInstance{
    static RSAHelper *instance = nil;
    if (nil == instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [[RSAHelper alloc] init];
            [instance setup];
        });
    }
    return instance;
}

- (void)setup{
    RSA *rsa = RSA_new();
    
    BIGNUM * bne =BN_new();
    
    unsigned int e = RSA_3;
    
    BN_set_word(bne, e);
    
    RSA_generate_key_ex(rsa, 1024, bne, NULL);
    
    EVP_PKEY *pkey = EVP_PKEY_new();
    
    EVP_PKEY_assign_RSA(pkey, rsa);
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)objectAtIndex:0];
    NSString *pubPath = [documentsPath stringByAppendingPathComponent:@"PubFile.txt"];
    FILE *pubWrite = NULL;
    pubWrite = fopen([pubPath UTF8String], "wb");
    if (pubWrite == NULL) {
        NSLog(@"read pub key fail");
    }else{
        PEM_write_PUBKEY(pubWrite, pkey);
        fclose(pubWrite);
    }

    publishKeyStr = [NSString stringWithContentsOfFile:pubPath encoding:NSUTF8StringEncoding error:nil]; //读取文件
    
    //切割标饰
    NSRange spos = [publishKeyStr rangeOfString:@"-----BEGIN PUBLIC KEY-----"];
    NSRange epos = [publishKeyStr rangeOfString:@"-----END PUBLIC KEY-----"];
    if(spos.location != NSNotFound && epos.location != NSNotFound){
        NSUInteger s = spos.location + spos.length;
        NSUInteger e = epos.location;
        NSRange range = NSMakeRange(s, e-s);
        publishKeyStr = [publishKeyStr substringWithRange:range];
    }
    //替换无用字符
    publishKeyStr = [publishKeyStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    publishKeyStr = [publishKeyStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    publishKeyStr = [publishKeyStr stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    publishKeyStr = [publishKeyStr stringByReplacingOccurrencesOfString:@" "  withString:@""];
    
    NSLog(@"publish key: %@",publishKeyStr);
    
    [[NSFileManager defaultManager] removeItemAtPath:pubPath error:nil];
    
    
    NSString *priPath = [documentsPath stringByAppendingPathComponent:@"PriFile.txt"];
    FILE *priWrite = NULL;
    priWrite = fopen([priPath UTF8String], "wb");
    if (priWrite == NULL) {
        NSLog(@"read pri key fail");
    }else{
        PEM_write_PKCS8PrivateKey(priWrite, pkey, NULL, NULL, 0, 0, NULL);
        fclose(priWrite);
    }
    privateKeyStr = [NSString stringWithContentsOfFile:priPath encoding:NSUTF8StringEncoding error:nil];
    
    //切割标饰
    spos = [privateKeyStr rangeOfString:@"-----BEGIN PRIVATE KEY-----"];
    epos = [privateKeyStr rangeOfString:@"-----END PRIVATE KEY-----"];
    if(spos.location != NSNotFound && epos.location != NSNotFound){
        NSUInteger s = spos.location + spos.length;
        NSUInteger e = epos.location;
        NSRange range = NSMakeRange(s, e-s);
        privateKeyStr = [privateKeyStr substringWithRange:range];
    }
    //替换无用字符
    privateKeyStr = [privateKeyStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    privateKeyStr = [privateKeyStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    privateKeyStr = [privateKeyStr stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    privateKeyStr = [privateKeyStr stringByReplacingOccurrencesOfString:@" "  withString:@""];
    
    NSLog(@"private key: %@",privateKeyStr);
    [[NSFileManager defaultManager] removeItemAtPath:priPath error:nil];
}

- (NSString *)getPublishKey{
    return publishKeyStr;
}

- (NSString *)getPrivateKey{
    return privateKeyStr;
}

- (NSString *)encrypted:(NSString *)plainText{
    return [RSAUtil encryptString:plainText publicKey:publishKeyStr];
}

- (NSString *)decrypted:(NSString *)encryptedText{
    return [RSAUtil decryptString:encryptedText privateKey:privateKeyStr];
}

@end
