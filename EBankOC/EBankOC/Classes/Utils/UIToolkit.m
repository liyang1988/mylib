//
//  UIToolkit.m
//  EBankOC
//
//  Created by 羊羊 on 17/1/6.
//  Copyright © 2017年 Bruce. All rights reserved.
//

#import "UIToolkit.h"
#import "EBUserDefaults.h"
#import <sys/xattr.h>
#import "AppDelegate.h"

////用于UIImage的imageNamed函数载入resource.bundle下的图片
//NSString* Bundle(NSString* fileName) {
//    EBUserDefaults* defaults = [EBUserDefaults instance];
//    
//    if (nil != defaults.skinBundle &&
//        ExistAtPath(ResourcePath([NSString stringWithFormat:@"%@/%@", defaults.skinBundle, fileName]))) {
//        return [NSString stringWithFormat:@"%@/%@", defaults.skinBundle, fileName];
//    }
//    return [NSString stringWithFormat:@"resource.bundle/%@", fileName];
//}
////根据图片路径加载图片
//extern UIImage* Image(NSString* imageName) {
//    return [UIImage imageNamed:Bundle(imageName)];
//}

//弹出消息框来显示消息
void ShowMessage(NSString* message) {
    if (![message isKindOfClass:[NSString class]]||message.length<=0) {
        return;
    }
    
    AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.window.rootViewController.view makeToast:message duration:2.0 position:@"bottom"];
}

//弹出消息框来显示消息
void CenterMessage(NSString* message) {
    if (![message isKindOfClass:[NSString class]]||message.length<=0) {
        return;
    }
    
    AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.window.rootViewController.view makeToast:message duration:2.0 position:@"center"];
}

//获取资源全路径
NSString* ResourcePath(NSString* fileName) {
    return [[[NSBundle mainBundle] resourcePath] stringByAppendingFormat:@"/%@", fileName];
}

//给文件夹加属性，不需要上传到iClode
BOOL AddSkipBackupAttributeToItemAtURLFile(NSURL* URL) {
    const char* filePath = [[URL path] fileSystemRepresentation];
    const char* attrName = "com.apple.MobileBackup";
    u_int8_t attrValue = 1;
    int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
    return result == 0;
}



NSString* AlbumsPath(NSString* fileName, long planId) {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:
                      [NSString stringWithFormat:@"albums/plan%ld", planId]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]){
        if (![fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil]) {
            NSLog(@"create filepath fail:%@", path);
            return nil;
        }
    }
    if (AddSkipBackupAttributeToItemAtURLFile([NSURL fileURLWithPath:path])) {
        if (nil != [fileName lastPathComponent]) {
            return [path stringByAppendingFormat:@"/%@", [fileName lastPathComponent]];
        } else {
            return path;
        }
    } else {
        return nil;
    }
}

NSString* RecordsPath(NSString* fileName, long planId) {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:
                      [NSString stringWithFormat:@"records/plan%ld", planId]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]){
        if (![fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil]) {
            NSLog(@"create filepath fail:%@", path);
            return nil;
        }
    }
    if (AddSkipBackupAttributeToItemAtURLFile([NSURL fileURLWithPath:path])) {
        if (nil != [fileName lastPathComponent]) {
            return [path stringByAppendingFormat:@"/%@", [fileName lastPathComponent]];
        } else {
            return path;
        }
    } else {
        return nil;
    }
}


NSString* CachePath(NSString* fileName) {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* path = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]){
        if (![fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil]) {
            NSLog(@"create filepath fail:%@", path);
            return nil;
        }
    }
    if (nil != [fileName lastPathComponent]) {
        return [path stringByAppendingFormat:@"/%@", [fileName lastPathComponent]];
    } else {
        return path;
    }
}

//下载文件temp目录：用来下载时临时存储文件，实现断点续传
NSString* DownloadTemporaryPath(NSString* fileName) {
    NSString* path = NSTemporaryDirectory();
    if (nil != [fileName lastPathComponent]) {
        return [path stringByAppendingFormat:@"%@", [fileName lastPathComponent]];
    } else {
        return path;
    }
}

//检查文件是否存在：此是ExistAtConfigPath和ExistAtTemporaryPath的综合
BOOL ExistAtPath(NSString* fileFullPath) {
    return [[fileFullPath pathExtension] length] > 0 &&
    [[NSFileManager defaultManager] fileExistsAtPath:fileFullPath];
}

//删除所有catch文件
void RemoveCacheFiels(void) {
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSError* error = nil;
    [manager removeItemAtPath:CachePath(nil) error:&error];
}

//删除文件
BOOL RemoveFile(NSString* fileName) {
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSError* error = nil;
    return [manager removeItemAtPath:fileName error:&error];
}

//存储文件
void SaveFile(NSString* fileName, NSData* data) {
    NSFileManager *manager = [NSFileManager defaultManager];
    
    [manager createFileAtPath:fileName contents:data attributes:nil];
}

float CalcTextHight(UIFont *font, NSString* text, CGFloat width) {
    CGSize sz = [text sizeWithFont:[UIFont systemFontOfSize:font.pointSize+2]
                 constrainedToSize:CGSizeMake(width, 10000.0)];
    
    return sz.height;
}

float CalcTextWidth(UIFont *font, NSString* text, CGFloat width) {
    CGSize sz = [text sizeWithFont:font constrainedToSize:CGSizeMake(width, font.lineHeight)];
    
    return sz.width;
}

NSString*  DateStringWithTimeInterval(NSNumber* secs) {
    if ([secs intValue] <= 0) {
        return @"";
    } else {
        return StringFromDate([NSDate dateWithTimeIntervalSince1970:[secs doubleValue]], @"yyyy-MM-dd H:mm");
    }
}

NSString* DateStringWithTimeIntervalOnlyDay(NSNumber* secs) {
    if ([secs intValue] <= 0) {
        return @"";
    } else {
        return StringFromDate([NSDate dateWithTimeIntervalSince1970:[secs doubleValue]], @"yyyy-MM-dd");
    }
}

NSString* StringFromDate(NSDate* aDate, NSString *aFormat) {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [formatter setDateFormat:aFormat];
    NSString *dateString = [formatter stringFromDate:aDate];
    
    return dateString;
}

NSDate*   DateFromString(NSString* string, NSString* aFormat) {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [formatter setDateFormat:aFormat];
    NSDate *date = [formatter dateFromString:string];
    
    return date;
}
/**
UIActionSheet* ActionSheet(NSString* title, NSArray* buttonsArray, id delegate) {
    if ([buttonsArray count] >= 1) {
        UIActionSheet * sheet = [[UIActionSheet alloc]
                                 initWithTitle:title
                                 delegate:delegate
                                 cancelButtonTitle:@"取消"
                                 destructiveButtonTitle:nil
                                 otherButtonTitles:nil];
        for (int i=0; i<[buttonsArray count]; i++) {
            NSString * label = [buttonsArray objectAtIndex:i];
            [sheet addButtonWithTitle:label];
        }
        return sheet;
    }
    return nil;
}
*/


    


void NotificationPost(NSString* name, id object, NSDictionary* uInfo) {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:object userInfo:uInfo];
}
void NotificationAddObserver(id target, NSString* name, SEL selector) {
    [[NSNotificationCenter defaultCenter] addObserver:target selector:selector name:name object:nil];
}
void NotificationRemoveObserver(id target, NSString* name) {
    [[NSNotificationCenter defaultCenter] removeObserver:target name:name object:nil];
}

UITextField* CreateTextField(NSString *placeholder) {
    UITextField* field = [[UITextField alloc] initWithFrame:CGRectZero];
    field.font = [UIFont systemFontOfSize:FontNormalSize];
    field.leftViewMode = UITextFieldViewModeAlways;
    field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    field.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    field.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    field.rightViewMode = UITextFieldViewModeWhileEditing;
  
    field.placeholder = placeholder;
    field.returnKeyType = UIReturnKeyDone;
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    return field;
}

UIImage *scaleAndRotateImage(UIImage *image)  {
    int kMaxResolution = 1000; // Or whatever
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}

