//
//  NSData+Crypt.h
//  Encryption
//
//  Created by Maxime Lecomte on 29/03/11.
//  Copyright 2011 NA. All rights reserved.
//


#import <CommonCrypto/CommonCryptor.h>

@interface NSData (Crypt)
- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;
+ (NSData *)dataWithBase64EncodedString:(NSString *) string;

- (NSString *)md5;
- (NSString *)base64;

- (NSData*)initWithString:(NSString*)string;
+ (NSData*)dataWithString:(NSString*)string;
@end

