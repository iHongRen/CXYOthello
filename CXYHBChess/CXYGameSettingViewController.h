//
//  CXYGameSettingViewController.h
//  CXYHBChess
//
//  Created by iMac on 14-9-4.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//


typedef void (^ColorBlock)(NODESTATE);
typedef void (^LevelBlock)(GAMELEVEL);
typedef void (^SaveBlock)(void);

#import <UIKit/UIKit.h>

@interface CXYGameSettingViewController : UIViewController
@property (nonatomic, copy) ColorBlock colorBlock;
@property (nonatomic, copy) LevelBlock levelBlock;
@property (nonatomic, copy) SaveBlock  saveBlock;

@property (nonatomic, assign) NSInteger colorIndex;
@property (nonatomic, assign) NSInteger levelIndex;

@end
