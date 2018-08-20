//
//  NSString+Hash.m
//
//  Created by Tom Corwine on 5/30/12.
//

#import "NSString+hash.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (Hash)

- (NSString *)md5String {
    
	const char *string = self.UTF8String;
	int length = (int)strlen(string);
	unsigned char bytes[CC_MD5_DIGEST_LENGTH];
	CC_MD5(string, length, bytes);
	return [self stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)sha1String {
    
	const char *string = self.UTF8String;
	int length = (int)strlen(string);
	unsigned char bytes[CC_SHA1_DIGEST_LENGTH];
	CC_SHA1(string, length, bytes);
	return [self stringFromBytes:bytes length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)sha256String {
    
	const char *string = self.UTF8String;
	int length = (int)strlen(string);
	unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
	CC_SHA256(string, length, bytes);
	return [self stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)sha512String {
    
	const char *string = self.UTF8String;
	int length = (int)strlen(string);
	unsigned char bytes[CC_SHA512_DIGEST_LENGTH];
	CC_SHA512(string, length, bytes);
	return [self stringFromBytes:bytes length:CC_SHA512_DIGEST_LENGTH];
}

- (NSString *)hmacSHA1StringWithKey:(NSString *)key {
    
	NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
	NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
	NSMutableData *mutableData = [NSMutableData dataWithLength:CC_SHA1_DIGEST_LENGTH];
	CCHmac(kCCHmacAlgSHA1, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
	return [self stringFromBytes:(unsigned char *)mutableData.bytes length:mutableData.length];
}

- (NSString *)hmacSHA256StringWithKey:(NSString *)key {
    
	NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
	NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
	NSMutableData *mutableData = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
	CCHmac(kCCHmacAlgSHA256, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
	return [self stringFromBytes:(unsigned char *)mutableData.bytes length:mutableData.length];
}

- (NSString *)hmacSHA512StringWithKey:(NSString *)key {
    
	NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
	NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
	NSMutableData *mutableData = [NSMutableData dataWithLength:CC_SHA512_DIGEST_LENGTH];
	CCHmac(kCCHmacAlgSHA512, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
	return [self stringFromBytes:(unsigned char *)mutableData.bytes length:mutableData.length];
}

#pragma mark - Helpers

- (NSString *)stringFromBytes:(unsigned char *)bytes length:(NSInteger)length {
    
	NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < length; i++) {
        [mutableString appendFormat:@"%02x", bytes[i]];
    }
	return [NSString stringWithString:mutableString];
}

#pragma mark - Others

/**
 *  MD5($pass.$salt)
 *
 *  @param original 明文
 *
 *  @return         密文
 */
+ (NSString *)MD5Salt:(NSString *)original {
    
    NSString *salt = [original stringByAppendingString:@"gwl"];
    return [salt md5String];
}

/**
 *  MD5(MD5($pass))
 *
 *  @param original 明文
 *
 *  @return         密文
 */
+ (NSString *)doubleMD5:(NSString *)original {
    
    return [[original md5String] md5String];
}

/**
 *  先加密后乱序
 *
 *  @param original 明文
 *
 *  @return         密文
 */
+ (NSString *)MD5Reorder:(NSString *)original {
    
    NSString *transition = [original md5String];
    NSString *prefix = [transition substringFromIndex:2];
    NSString *subfix = [transition substringToIndex:2];
    NSString *result = [prefix stringByAppendingString:subfix];
    NSLog(@"original: %@", original);
    NSLog(@"transition: %@", transition);
    NSLog(@"result: %@", result);
    return result;
}

@end
