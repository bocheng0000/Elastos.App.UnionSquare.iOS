//
//  HMWToDeleteTheWalletPopView.h
//  ELA
//
//  Created by  on 2019/1/3.
//  Copyright © 2019 HMW. All rights reserved.
//



#import <UIKit/UIKit.h>




NS_ASSUME_NONNULL_BEGIN

@protocol HMWToDeleteTheWalletPopViewDelegate <NSObject>

-(void)sureToDeleteViewWithPWD:(NSString*)pwd;
-(void)toCancelOrCloseDelegate;
    

@end

typedef NS_ENUM(NSInteger, HMWToDeleteType) {
   deleteTheWallet,         // slow at beginning and end
   deleteFriends,            // slow at beginning
   deleteSelectVote,
   moreThan36SelectList,
   UtxoChangeWhole,
    deleteCRVote,
    openIDChainType,
    NeedsSavedType,
    voteInvalidType
    
   
};


@interface HMWToDeleteTheWalletPopView : UIView
    /*
     *<# #>
     */
@property(strong,nonatomic)id<HMWToDeleteTheWalletPopViewDelegate> delegate;

/*
 *<# #>
 */
@property(assign,nonatomic)HMWToDeleteType deleteType;

/*
 *<# #>
 */
@property(copy,nonatomic)NSString  * UtxosString;
@end

NS_ASSUME_NONNULL_END
