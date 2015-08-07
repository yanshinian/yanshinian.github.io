---
layout: post
title:  "字符串处理分类"
category: Code
date:   2015-08-03
---



```
//
//  NSString+Extension.m
//  hyq2048
//
//  Created by iOS on 15/6/30.
//  Copyright (c) 2015年 HYQ. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)


- (BOOL)empty
{
    return [self length] > 0 ? NO : YES;
}

/**
 *  验证邮箱是否合法
 *
 *  @param candidate 待验证的字符串
 *
 *  @return 布尔
 */
+ (BOOL)isEmailAddress:(NSString*)candidate
{
    NSString* emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}
/**
 *  验证是否是数字
 *
 *  @return <#return value description#>
 */
-(NSNumber *)asNumber;{
    NSString *regEx = @"^-?\\d+.?\\d?";
    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    BOOL isMatch            = [pred evaluateWithObject:self];
    if (isMatch) {
        return [NSNumber numberWithDouble:[self doubleValue]];
    }
    return nil;
}
/**
 *  用户名范围是数字跟字母
 *
 *  @return 布尔
 */
- (BOOL)isUserName
{
    NSString *      regex = @"(^[A-Za-z0-9]{3,20}$)";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}
/**
 *  用户名范围是中文
 *
 *  @return 布尔
 */
- (BOOL)isChineseUserName
{
    NSString *		regex = @"(^[A-Za-z0-9\u4e00-\u9fa5_-]{3,20}$)";
    NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

/**
 *  用户名范围是用户真名
 *
 *  @return 布尔
 */
- (BOOL)isUserRealName
{
    NSString *		regex = @"[\u4E00-\u9FA5_-]{2,5}(?:·[\u4E00-\u9FA5]{2,5})*";
    NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}


/**
 *  密码是否是数字字母 + 特殊字符
 *
 *  @return bool
 */
- (BOOL)isPassword
{
//    NSString *      regex = @"(^[A-Za-z0-9]{6,20}$)";密码是否是数字字母
////    NSString *regex = @"(^[\@A-Za-z0-9\~\`\!\@\#\$\%\^\&\*\.\=\"\'\:\;\+\|\\\-\(\)\{\}\[\]\<\>\?\/\\,\_]{6,20}$)";
//    NSString *regex = @"(^[A-Za-z0-9._%+-~`#$%^&*()/\\!?><|:@'\"]{6,20}$)";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    
//    return [pred evaluateWithObject:self];
    // 特殊字符包含`、-、=、\、[、]、;、'、,、.、/、~、!、@、#、$、%、^、&、*、(、)、_、+、|、?、>、<、"、:、{、}
    // 必须包含数字和字母，可以包含上述特殊字符。
    // 依次为（如果包含特殊字符）
    // 数字 字母 特殊
    // 字母 数字 特殊
    // 数字 特殊 字母
    // 字母 特殊 数字
    // 特殊 数字 字母
    // 特殊 字母 数字
//    NSString *passWordRegex = @"(\\d+[a-zA-Z]+[-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]*)|([a-zA-Z]+\\d+[-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]*)|(\\d+[-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]*[a-zA-Z]+)|([a-zA-Z]+[-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]*\\d+)|([-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]*\\d+[a-zA-Z]+)|([-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]*[a-zA-Z]+\\d+)";
    NSString *passWordRegex = @"(^[A-Za-z0-9-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]{6,20}$)";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}
/**
 *  邮箱是否合法
 *
 *  @return 布尔
 */
- (BOOL)isEmail
{
    NSString *      regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}
/**
 *  链接是否合法
 *
 *  @return 返回布尔
 */
- (BOOL)isUrl
{
    NSString *      regex = @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}
/**
 *  电话是否合法
 *
 *  @return 布尔
 */
- (BOOL)isTelephone
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    return  [regextestmobile evaluateWithObject:self]   ||
    [regextestphs evaluateWithObject:self]      ||
    [regextestct evaluateWithObject:self]       ||
    [regextestcu evaluateWithObject:self]       ||
    [regextestcm evaluateWithObject:self];
}
/**
 *  是否是合法手机号
 *
 *  @return 布尔
 */
- (BOOL)isMobilephone
{
    NSString * MOBILE = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    NSPredicate *regextestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return  [regextestMobile evaluateWithObject:self];
}

/**
 *  是否是合法身份证号
 *
 *  @return 布尔
 */
- (BOOL)isRealNum
{
    NSString * MOBILE = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *regextestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return  [regextestMobile evaluateWithObject:self];
}

/**
 *  是否是 IP 地址
 *
 *  @return 布尔
 */
- (BOOL)isIPAddress
{
    NSArray *			components = [self componentsSeparatedByString:@"."];
    NSCharacterSet *	invalidCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
    
    if ( [components count] == 4 )
    {
        NSString *part1 = [components objectAtIndex:0];
        NSString *part2 = [components objectAtIndex:1];
        NSString *part3 = [components objectAtIndex:2];
        NSString *part4 = [components objectAtIndex:3];
        
        if ( [part1 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound &&
            [part2 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound &&
            [part3 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound &&
            [part4 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound )
        {
            if ( [part1 intValue] < 255 &&
                [part2 intValue] < 255 &&
                [part3 intValue] < 255 &&
                [part4 intValue] < 255 )
            {
                return YES;
            }
        }
    }
    
    return NO;
}
- (BOOL)isNormal
{
    NSString *		regex = @"([^%&',;=!~?$]+)";
    NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}
/**
 *  去除空白字符串
 *
 *  @return 去除后的字符串
 */
- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
// 验证码必须为数字，否则提示格式不正确 author 言，上述均抄自 NSString+BeeExtension
- (BOOL)isNumber
{
    NSString *regex = @"^[0-9]+$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:self];
    
}

/**
 *  是否是合法银行卡号
 *
 *  @return 布尔
 */
- (BOOL)isRealBankCard
{
    NSString * MOBILE = @"^([0-9]{16}|[0-9]{19})$";
    NSPredicate *regextestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return  [regextestMobile evaluateWithObject:self];
}
/**
 *  数字 字符串 千位符 化  1,000 | 2,000,000
 *
 *  @return 千位符 化 后的 字符串
 */
- (NSString *)thousandCharacter {
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior: NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
    NSString *numberString = [numberFormatter stringFromNumber: [NSNumber numberWithDouble:[self doubleValue]]];
    return numberString;
}
@end

```

参考资料：

*  BeeFrameworkBeeFramework中的#import "NSString+BeeExtension.h"
