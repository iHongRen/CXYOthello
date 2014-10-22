//
//  CXYNode.h
//  CXYHBChess
//
//  Created by iMac on 14-9-2.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//

//typedef NS_ENUM(NSInteger, NODESTATE) {KBLACK,KWHITE,KHINT,KCLEAR};



#import <UIKit/UIKit.h>

@interface CXYNode : UIButton
@property (nonatomic,assign)NODESTATE nodeState;

- (NSArray*)getRecentNodesTagOftheNode;

@end
