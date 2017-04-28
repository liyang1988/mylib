//
//  UIToolkit.h
//  EBankOC
//
//  Created by 羊羊 on 17/1/6.
//  Copyright © 2017年 Bruce. All rights reserved.
//

#import <Foundation/Foundation.h>


////用于UIImage的imageNamed函数载入resource.bundle下的图片
//extern NSString* Bundle(NSString* fileName);
////根据图片路径加载图片
//extern UIImage* Image(NSString* imageName);

//删除所有cache文件
extern void RemoveCacheFiels(void);
//config目录：用来存放时间戳有效期内的景区下载文件:返回全路径
extern NSString* ConfigPath(NSString* fileName);
//获取资源全路径
extern NSString* ResourcePath(NSString* fileName);

//弹出消息框来显示消息
extern void ShowMessage(NSString* message);
extern void CenterMessage(NSString* message);

//@{目录结构
//下载的文件存放路径:返回全路径
extern NSString* CachePath(NSString* fileName);
////本地活动相册目录
//extern NSString* AlbumsPath(NSString* fileName, long planId);
////本地活动录音目录
//extern NSString* RecordsPath(NSString* fileName, long planId);
//下载文件temp目录：用来下载时临时存储文件，实现断点续传
extern NSString* DownloadTemporaryPath(NSString* fileName);

//@{目录结构
//下载的文件存放路径:返回全路径
extern NSString* CachePath(NSString* fileName);
//本地活动相册目录
extern NSString* AlbumsPath(NSString* fileName, long planId);
//本地活动录音目录
extern NSString* RecordsPath(NSString* fileName, long planId);
//下载文件temp目录：用来下载时临时存储文件，实现断点续传
extern NSString* DownloadTemporaryPath(NSString* fileName);
//@}

//删除文件
extern BOOL RemoveFile(NSString* fileName);
//存储文件
extern void SaveFile(NSString* fileName, NSData* data);
//检查文件是否存在
extern BOOL ExistAtPath(NSString* fileFullPath);

//计算文字实际高度
extern float CalcTextHight(UIFont *font, NSString* text, CGFloat width);
extern float CalcTextWidth(UIFont *font, NSString* text, CGFloat width);

extern void NotificationPost(NSString* name, id object, NSDictionary* uInfo);
extern void NotificationAddObserver(id target, NSString* name, SEL selector);
extern void NotificationRemoveObserver(id target, NSString* name);

//时间日期转换
extern NSString* DateStringWithTimeInterval(NSNumber* secs);
extern NSString* DateStringWithTimeIntervalOnlyDay(NSNumber* secs);
extern NSString* StringFromDate(NSDate* aDate, NSString *aFormat);
extern NSDate*   DateFromString(NSString* string, NSString* aFormat);


extern UITextField* CreateTextField(NSString *placeholder);
/*
 @{@"validKey":@"realName",
 @"validType":@"Text",
 @"validDictionary":@{ @"primaryField:":[NSNumber numberWithBool:YES],
 @"maxLength",[NSNumber numberWithInt:100]}
 };
 */
extern BOOL ValidTextValue(NSString * val, NSDictionary *validDictionary);

/*
 @{@"validKey":@"realName",
 @"validType":@"Number",
 @"validDictionary":@{ @"primaryField:":[NSNumber numberWithBool:YES],
 @"minValue",[NSNumber numberWithInt:0],
 @"maxValue",[NSNumber numberWithInt:100]}
 };
 */
extern BOOL ValidNumberValue(NSNumber * val, NSDictionary *validDictionary);


/*
 @{@"validKey":@"email",
 @"validType":@"Email",
 @"validDictionary":@{ @"primaryField:":[NSNumber numberWithBool:YES]}
 };
 */
extern BOOL ValidEmailValue(NSString * val, NSDictionary *validDictionary);


/*
 @{@"validKey":@"email",
 @"validType":@"MobilePhone"
 @"validDictionary":@{ @"primaryField:":[NSNumber numberWithBool:YES] }
 };
 */
extern BOOL ValidMobilePhoneValue(NSString * val, NSDictionary *validDictionary);

//验证邮政编码
extern BOOL ValidZipValue(NSString * val, NSDictionary *validDictionary);

//验证日期
extern BOOL ValidDateValue(NSDate * val, NSDictionary *validDictionary);
/*
 @{@"validKey":@"customer",
 @"validType":@"Customer",
 @"validDictionary":@{ @"primaryField:":[NSNumber numberWithBool:YES],
 @"key1",@"regit1",
 @"key2",@"regit2"}
 };
 */
extern BOOL ValidCustomerValue(NSString * val, NSObject *targetValue, NSDictionary *validDictionary);

// 验证对象的正确性
extern BOOL ValidateModel(NSObject *obj, NSArray *validateArray);
//获取date的年份
extern NSUInteger DateOfYear(NSDate *mydate);

//获取date的年份差
extern NSUInteger DateOfDiffYear(NSDate *mydate,NSDate *today);

extern UIImage *scaleAndRotateImage(UIImage *image);
