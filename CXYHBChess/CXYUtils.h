//
//  CXYUtils.h
//  CXYHBChess
//
//  Created by iMac on 14-9-18.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark ---- alert message-----
#define kGAMING_MESSAGE    @"游戏中...不能设置哦！\n重新开始可设置."
#define kGAMEREADY_MESSAGE @"已经是最初状态了哦！"

#pragma mark ---- text -----
#define kMAIN_TITLE @"黑白棋"
#define kGAME_TITLE @"对战电脑"
#define kSETTING    @"设置"
#define kBlackWin   @"黑方获胜"
#define kWhiteWin   @"白方获胜"
#define kDoubleWin  @"和棋"

@interface CXYUtils : NSObject
+ (void)showAlert:(NSString*)message;
+ (void)playChessSound;
@end
