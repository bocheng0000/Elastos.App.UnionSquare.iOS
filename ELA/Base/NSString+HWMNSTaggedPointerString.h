//
//  NSString+HWMNSTaggedPointerString.h
//  elastos wallet
//
//  Created by 韩铭文 on 2019/11/5.
//

//#import <AppKit/AppKit.h>


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HWMNSTaggedPointerString)
-(void)count;
- (NSUInteger)charactorNumberWithEncoding:(NSStringEncoding)encoding;
- (NSUInteger)charactorNumber;
@end

NS_ASSUME_NONNULL_END
