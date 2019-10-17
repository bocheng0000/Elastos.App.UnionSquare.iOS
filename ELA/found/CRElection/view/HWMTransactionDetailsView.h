//
//  HWMTransactionDetailsView.h
//  elastos wallet
//
//  Created by 韩铭文 on 2019/10/8.
//

#import <UIKit/UIKit.h>

@protocol HWMTransactionDetailsViewDelegate <NSObject>
-(void)pwdAndInfoWithPWD:(NSString*)pwd;
-(void)closeTransactionDetailsView;


@end
@interface HWMTransactionDetailsView : UIView
/*
 *<# #>
 */
@property(strong,nonatomic)id<HWMTransactionDetailsViewDelegate> delegate;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *popViewTitle;
-(void)TransactionDetailsWithFee:(NSString*)fee withTransactionDetailsAumont:(NSString*)aumont;
@end


