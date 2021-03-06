//
//  HMWnodeInformationViewController.m
//  ELA
//
//  Created by  on 2019/1/6.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "FLManageSelectPointNodeInformationVC.h"
#import "HMWtheCandidateListViewController.h"
#import "ELWalletManager.h"
#import "HMWToDeleteTheWalletPopView.h"
#import "FLJoinVoteInfoModel.h"
#import "HMWsignUpForViewController.h"
#import "FLCoinPointInfoModel.h"
#import "nodeInformationDetailsView.h"
#import "HWMCRListModel.h"
#import "HWMCRRegisteredViewController.h"
#import "HWMTransactionDetailsView.h"
#import "HMWSendSuccessPopuView.h"
@interface FLManageSelectPointNodeInformationVC()<HMWToDeleteTheWalletPopViewDelegate,HWMTransactionDetailsViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *votesLabel;
@property (weak, nonatomic) IBOutlet UILabel *votesNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *voteOfBTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *voteOfBNumberLabel;


@property (weak, nonatomic) IBOutlet UILabel *leftLab1;

@property (weak, nonatomic) IBOutlet UILabel *leftLab2;
@property (weak, nonatomic) IBOutlet UILabel *leftLab3;

@property (weak, nonatomic) IBOutlet UIView *infoBGView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIButton *updataTheCandidateListButton;
@property (weak, nonatomic) IBOutlet UIButton *lookAtTheCandidateListButton;

@property (weak, nonatomic) IBOutlet UIButton *URLcopyCRButtton;


@property (weak, nonatomic) IBOutlet UILabel *OwnerPublickKeyLab;
@property (weak, nonatomic) IBOutlet UILabel *NodePublickKeyLab;
@property (weak, nonatomic) IBOutlet UILabel *NickNameLab;
@property (weak, nonatomic) IBOutlet UILabel *URLLab;
@property (weak, nonatomic) IBOutlet UILabel *LocationLab;
@property (weak, nonatomic) IBOutlet UILabel *AddressLab;

//@property(nonatomic,strong)FLJoinVoteInfoModel *model;
@property (weak, nonatomic) IBOutlet UIView *CRBGView;
@property(nonatomic,strong)HWMTransactionDetailsView *transactionDetailsView;


@property(strong,nonatomic)HMWToDeleteTheWalletPopView *toDeleteTheWalletPopV;
/*
 *
 */
@property (weak, nonatomic) IBOutlet UILabel *URLTextLabel;
@property(strong,nonatomic)nodeInformationDetailsView *nodeInformationDetailsV;
@property(strong,nonatomic)HMWSendSuccessPopuView *sendSuccessPopuV;

@end

@implementation FLManageSelectPointNodeInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title= NSLocalizedString(@"选举管理", nil) ;
    self.leftLab1.text =NSLocalizedString(@"节点名称", nil) ;
     self.leftLab2.text =NSLocalizedString(@"节点公钥", nil) ;
     self.leftLab3.text =NSLocalizedString(@"国家/地区", nil) ;
    self.votesLabel.text=NSLocalizedString(@"当前票数", nil);
    self.voteOfBTextLabel.text=NSLocalizedString(@"投票占比", nil);
    [[HMWCommView share]makeBordersWithView:self.updataTheCandidateListButton];
    [[HMWCommView share]makeBordersWithView:self.lookAtTheCandidateListButton];
    
    [[HMWCommView share]makeBordersWithView:self.infoBGView];
    self.iconImageView.layer.cornerRadius=30.f;
    self.iconImageView.layer.borderWidth=1.f;
    self.iconImageView.layer.borderColor=RGBA(255, 255, 255, 0.8).CGColor;
    
    ELWalletManager *manager   =  [ELWalletManager share];
    
    IMainchainSubWallet *mainchainSubWallet = [manager getWalletELASubWallet:manager.currentWallet.masterWalletID];
    
   
    if (self.CRTypeString.length>0){
        self.CRBGView.alpha=1.f;
        self.URLLab.alpha=0.f;
       
        self.votesLabel.alpha=0.f;
        self.votesNumberLabel.alpha=0.f;
        self.voteOfBTextLabel.alpha=0.f;
        self.voteOfBNumberLabel.alpha=0.f;
        self.LocationLab.alpha=0.f;
        self.leftLab1.alpha=0.f;
        self.leftLab2.alpha=0.f;
      self.leftLab3.alpha=0.f;
    self.URLTextLabel.alpha=0.f;
        self.URLcopyCRButtton.alpha=0.f;
        self.NodePublickKeyLab.alpha=0.f;
        [self.CRBGView addSubview:self.nodeInformationDetailsV];
        [self.nodeInformationDetailsV mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(self.CRBGView.mas_top).offset(0);
    make.left.equalTo(self.CRBGView.mas_left).offset(10);
    make.right.equalTo(self.CRBGView.mas_right).offset(-10);
            make.bottom.equalTo(self.CRBGView.mas_bottom).offset(-15);
        }];
//        nlohmann::json info = mainchainSubWallet->GetRegisteredCRInfo();
//                      NSString *dataStr = [NSString stringWithUTF8String:info.dump().c_str()];
//                      NSDictionary *param = [NSJSONSerialization JSONObjectWithData:[dataStr  dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
//                      NSString *Status = param[@"Status"];
//        self.CRModel.did=param[@"Info"][@"CROwnerDID"];
//        self.CRModel.nickname=param[@"Info"][@"NickName"];
//        self.CRModel.url=param[@"Info"][@"Url"];
//        self.CRModel.location=param[@"Info"][@"Location"];
//   
//    self.CRModel.ownerpublickey=param[@"Info"][@"CROwnerPublicKey"];
        
//        self.CRModel=self.lastArray.firstObject;
        self.OwnerPublickKeyLab.text=self.CRModel.nickname;
        self.nodeInformationDetailsV.CRmodel=self.CRModel;
        [self.lookAtTheCandidateListButton setTitle:NSLocalizedString(@"退出参选", nil) forState:UIControlStateNormal];
           [self.updataTheCandidateListButton setTitle:NSLocalizedString(@"更新信息", nil) forState:UIControlStateNormal];
    }else{
        [self.lookAtTheCandidateListButton setTitle:NSLocalizedString(@"注销", nil) forState:UIControlStateNormal];
           [self.updataTheCandidateListButton setTitle:NSLocalizedString(@"编辑", nil) forState:UIControlStateNormal];
//        nlohmann::json info = mainchainSubWallet->GetRegisteredProducerInfo();
//           NSString *dataStr = [NSString stringWithUTF8String:info.dump().c_str()];
//
//           NSDictionary *param = [NSJSONSerialization JSONObjectWithData:[dataStr  dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
//           NSDictionary *infoDic = param[@"Info"];
//
//           NSString *OwnerPublickKey = infoDic[@"OwnerPublicKey"];
//           NSString *NodePublickKey  =infoDic[@"NodePublicKey"];
//
//           NSString *URL=infoDic[@"URL"];
//
//           NSString *Location   =infoDic[@"Location"];
//           NSString *NickName   = infoDic[@"NickName"];
//
//           self.model = [[FLJoinVoteInfoModel alloc]init];
//           self.model.nickName = NickName;
//           self.model.url = URL;
//           self.model.contryCode = Location;
//           self.model.ipAddress = infoDic[@"IpAddress"];
//           self.model.ownerPublickKey=OwnerPublickKey;
           
        [self getNetCoinPointArrayWithPubKey:self.model.ownerpublickey];
           
           
           self.OwnerPublickKeyLab.text = self.model.nickname;
           self.NodePublickKeyLab.text  =self.model.nodepublickey;
           self.URLLab.text =self.model.url;
        self.LocationLab.text = [[FLTools share]contryNameTransLateByCode:self.model.location.integerValue];
          
        
        
        NSDictionary *infoDicI=[[FLTools share] getImageViewURLWithURL:self.model.url withCRString:@"CR"];
                    self.model.iconImageUrl= infoDicI[@"url"];
                    self.model.infoEN=infoDicI[@"infoEN"];
                    self.model.infoZH=infoDicI[@"infoZH"];
                         NSString *httpIP=[[FLTools share]http_IpFast];
                         if (self.model.iconImageUrl.length>0) {
                             [HttpUrl NetPOSTHost:httpIP url:@"/api/dposnoderpc/check/getimage" header:@{} body:@{@"imageurl":self.model.iconImageUrl} showHUD:NO WithSuccessBlock:^(id data) {
                                                                 NSString *param = data[@"data"];
                    self.model.iconImageUrl=[NSString stringWithFormat:@"%@%@",httpIP,param];
                                 [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.model.iconImageUrl] placeholderImage:[UIImage imageNamed:@"found_vote_initial"]];
                                                             } WithFailBlock:^(id data) {
                                                                 
                                                             }];
                         }
    }
}
-(void)getNetCoinPointArrayWithPubKey:(NSString *)OwnerPublickKey{
NSString *httpIP=[[FLTools share]http_IpFast];
    
    [HttpUrl NetPOSTHost:httpIP url:@"/api/dposnoderpc/check/listproducer" header:@{} body:@{@"moreInfo":@"1",@"state":@"all"} showHUD:NO WithSuccessBlock:^(id data) {
        NSDictionary *param = data[@"data"];
        NSArray *dataSource= [NSArray modelArrayWithClass:FLCoinPointInfoModel.class json:param[@"result"][@"producers"]];
        for (FLCoinPointInfoModel *model in dataSource) {
            if ([model.ownerpublickey isEqualToString:OwnerPublickKey]) {
                self.votesNumberLabel.text=[NSString stringWithFormat:@"%@ %@", model.votes,NSLocalizedString(@"票", nil)];
                self.voteOfBNumberLabel.text=[NSString stringWithFormat:@"%@ %@" ,[[FLTools share]DownTheValue:model.voterate withLength:2],@"%"];
                break;
            }
            
        }

//        self.votingListV.lab1.text = [NSString stringWithFormat:@"%.3f %@" ,[param[@"result"][@"totalvoterate"] floatValue]*100,@"%"];
        // self.votingListV.lab2.text = [param[@"result"][@"totalvotes"]stringValue ];
//        self.votingListV.lab3.text = param[@"result"][@"totalvotes"];
       
    } WithFailBlock:^(id data) {
        
    }];
}
- (IBAction)copyURLEvent:(id)sender {
    
    [UIPasteboard generalPasteboard].string = self.URLLab.text;
    [[FLTools share]showErrorInfo:NSLocalizedString(@"已复制到粘贴板", nil)];
}

- (IBAction)lookAtTheCandidateListEvent:(id)sender {
    
    UIView *maView=[self mainWindow];
    [maView addSubview:self.toDeleteTheWalletPopV];
    [self.toDeleteTheWalletPopV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(maView);
    }];
    
}
-(HMWToDeleteTheWalletPopView *)toDeleteTheWalletPopV{
    if (!_toDeleteTheWalletPopV) {
        _toDeleteTheWalletPopV =[[HMWToDeleteTheWalletPopView alloc]init];
        _toDeleteTheWalletPopV.delegate=self;
        if (self.CRTypeString.length>0) {
             _toDeleteTheWalletPopV.deleteType=deleteCRVote;
        }else{
             _toDeleteTheWalletPopV.deleteType=deleteSelectVote;
        }
       
    }
    
    return _toDeleteTheWalletPopV;
}
- (IBAction)updateTheCandidateListEvent:(id)sender {
    if (self.CRTypeString.length>0) {
        HWMCRRegisteredViewController *vc=[[ HWMCRRegisteredViewController alloc]init];
        vc.CRmodel=self.CRModel;
        vc.isUpdate=YES;
        vc.currentWallet=self.currentWallet;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
    HMWsignUpForViewController  *vc = [[HMWsignUpForViewController alloc]init];
        FLJoinVoteInfoModel *modelF=[[FLJoinVoteInfoModel alloc]init];
        modelF.contryCode=self.model.location;
        modelF.nodePubKey=self.model.nodepublickey;
        modelF.nickName=self.model.nickname;
        modelF.url=self.model.url;
        modelF.ownerPublickKey=self.model.ownerpublickey;
        modelF.iconImageUrl=self.model.iconImageUrl;
        modelF.infoEN=self.model.infoEN;
        modelF.infoZH=self.model.infoZH;
        vc.model =modelF;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

-(void)sureToDeleteViewWithPWD:(NSString*)pwd{
    
    ELWalletManager *manager = [ELWalletManager share];
           NSString *walletId =  manager.currentWallet.masterWalletID;
    BOOL ret;
    if (self.CRTypeString.length>0) {
   
       
        invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[walletId,@"ELA",@"",@"",@"0",@"0",@"",@"1"] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"accessFees"];
          PluginResult * result =[[ELWalletManager share]accessFees:mommand];
          NSString *status=[NSString stringWithFormat:@"%@",result.status];
          if ([status isEqualToString:@"1"]) {
                [self toCancelOrCloseDelegate];
              UIView *mainView =[self mainWindow];
                 [mainView addSubview:self.transactionDetailsView];
                 [self.transactionDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
                     make.left.right.top.bottom.equalTo(mainView);
                 }];
              NSString *fee=[[FLTools share]elaScaleConversionWith:[NSString stringWithFormat:@"%@",result.message[@"success"]]];
              [self.transactionDetailsView TransactionDetailsWithFee:fee withTransactionDetailsAumont:@""];
          }
   
        
    }else{
        invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[walletId,@"ELA",@"",@"",@"0",@"0",@"",@"1"] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"accessFees"];
                 PluginResult * result =[[ELWalletManager share]accessFees:mommand];
                 NSString *status=[NSString stringWithFormat:@"%@",result.status];
                 if ([status isEqualToString:@"1"]) {
                       [self toCancelOrCloseDelegate];
                     UIView *mainView =[self mainWindow];
                        [mainView addSubview:self.transactionDetailsView];
                        [self.transactionDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.right.top.bottom.equalTo(mainView);
                        }];
                     NSString *fee=[[FLTools share]elaScaleConversionWith:[NSString stringWithFormat:@"%@",result.message[@"success"]]];
                     [self.transactionDetailsView TransactionDetailsWithFee:fee withTransactionDetailsAumont:@""];
                 }
       
    }
  
}
-(void)toCancelOrCloseDelegate{
    
    [self.toDeleteTheWalletPopV removeFromSuperview];
    self.toDeleteTheWalletPopV=nil;
}
-(void)setCurrentWallet:(FLWallet *)currentWallet{
    _currentWallet=currentWallet;
    
}
-(nodeInformationDetailsView *)nodeInformationDetailsV{
    if (!_nodeInformationDetailsV) {
        _nodeInformationDetailsV =[[nodeInformationDetailsView alloc]init];
//        _nodeInformationDetailsV.model=self.model;
        _nodeInformationDetailsV.type=CRCoinPointInfType;
        [_nodeInformationDetailsV.copURLButton addTarget:self action:@selector(copyURLEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nodeInformationDetailsV;
}

-(void)setCRModel:(HWMCRListModel *)CRModel{
    _CRModel=CRModel;
}
-(HWMTransactionDetailsView *)transactionDetailsView{

    

    if (!_transactionDetailsView) {

        _transactionDetailsView =[[HWMTransactionDetailsView alloc]init];

        _transactionDetailsView.popViewTitle=NSLocalizedString(@"交易详情", nil);

        _transactionDetailsView.delegate=self;

    }

    return _transactionDetailsView;

}

#pragma mark ---------HWMTransactionDetailsView----------

-(void)closeTransactionDetailsView{

    [self.transactionDetailsView removeFromSuperview];

    self.transactionDetailsView=nil;

}

-(void)pwdAndInfoWithPWD:(NSString*)pwd{
    bool  ret;
     ELWalletManager *manager = [ELWalletManager share];
    NSString *walletId =  manager.currentWallet.masterWalletID;
      if (self.CRTypeString.length>0) {
      ret = [manager CancelCRProducer:walletId Pwd:pwd];
          
      }else{
          
             ret = [manager CancelProducer:walletId Pwd:pwd];
          
      }
      if (ret) {
       
          [self closeTransactionDetailsView];
          [self showSendSuccessPopuV];
          
    
      }
}

-(void)showSendSuccessPopuV{
    UIView *manView=[self mainWindow];
    [manView addSubview:self.sendSuccessPopuV];
    [self.sendSuccessPopuV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(manView);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hiddenSendSuccessPopuV];
        [self.navigationController popViewControllerAnimated: YES];
    });
}
-(void)hiddenSendSuccessPopuV{
    [self.sendSuccessPopuV removeFromSuperview];
    self.sendSuccessPopuV=nil;
}
-(HMWSendSuccessPopuView *)sendSuccessPopuV{
    if (!_sendSuccessPopuV) {
        _sendSuccessPopuV =[[HMWSendSuccessPopuView alloc]init];
    }
    
    return _sendSuccessPopuV;
}
-(void)setModel:(FLCoinPointInfoModel *)model{
    _model=model;
}
@end
