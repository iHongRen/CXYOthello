//
//  CXYGameAreaView.m
//  CXYHBChess
//
//  Created by iMac on 14-9-2.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//



#import "CXYGameAreaView.h"
#import "CXYNode.h"

#define kNodeWidth 30

@implementation CXYGameAreaView
{
    NSInteger blackNum;
    NSInteger whiteNum;
      
    UILabel *blackLabel;
    UILabel *whiteLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    blackLabel = (UILabel*)[self viewWithTag:-1000];
    whiteLabel = (UILabel*)[self viewWithTag:-1001];
    [self onCreateNodes];
}


- (void)onNodeClick:(CXYNode*)node {
    if (self.chessDownBlock) {
        self.chessDownBlock(node);
    }
}

// 创建棋子到棋盘上
- (void)onCreateNodes {
    NSInteger k = 0;
    for (NSInteger i=0; i<kSize; i++) {
        for (NSInteger j=0; j<kSize; j++) {
            CXYNode *node = [[CXYNode alloc]initWithFrame:CGRectMake(10+kNodeWidth*j, 10+kNodeWidth*i, kNodeWidth, kNodeWidth)];
            node.tag = ++k;
            [node addTarget:self action:@selector(onNodeClick:) forControlEvents:UIControlEventTouchUpInside];
            node.layer.masksToBounds = YES;
            node.layer.cornerRadius = node.frame.size.width/2;
            [self addSubview:node];
        }
    }
}

// 初始化棋盘上棋子状态
- (void)onInitNodesWithPlayer:(CXYParent*)player {
    NSInteger k = 0;
    for (NSInteger i=0; i<kSize; i++) {
        for (NSInteger j=0; j<kSize; j++) {
            CXYNode *node = (CXYNode*)[self viewWithTag:++k];
            node.nodeState = KCLEAR;
        }
    }
    
    ((CXYNode*)[self viewWithTag:28]).nodeState = KBLACK;
    ((CXYNode*)[self viewWithTag:29]).nodeState = KWHITE;
    ((CXYNode*)[self viewWithTag:36]).nodeState = KWHITE;
    ((CXYNode*)[self viewWithTag:37]).nodeState = KBLACK;

    [player setHintState:self];
}

// 计算棋盘上白黑棋子个数
- (void)onCalculateNodeNum {
    blackNum = 0;
    whiteNum = 0;
    for (NSInteger i=1; i<=kSize*kSize; i++) {
        CXYNode *node = (CXYNode*)[self viewWithTag:i];
        if (node.nodeState == KBLACK) {
            blackNum++;
        }
        if (node.nodeState == KWHITE) {
            whiteNum++;
        }
    }
    blackLabel.text = [NSString stringWithFormat:@"%zd",blackNum];
    whiteLabel.text = [NSString stringWithFormat:@"%zd",whiteNum];
}

// 判断获胜
- (void)onJudgeWinForPlayer:(CXYParent*)player OtherPlayer:(CXYParent*)OtherPlayer {
    [self onCalculateNodeNum];
    if (0 == blackNum) {
        _gameState = GAMEOVER;
         [CXYUtils showAlert:kWhiteWin];
         return;
    }
    if (0 == whiteNum) {
         _gameState = GAMEOVER;
          [CXYUtils showAlert:kBlackWin];
         return;
    }
    if ([[player getCurrentAllowDownNodesInView:self] count]== 0 && [[OtherPlayer getCurrentAllowDownNodesInView:self] count]== 0) {
        [self onCalculateNodeNum];
        if (blackNum > whiteNum) {
            _gameState = GAMEOVER;
            [CXYUtils showAlert:kBlackWin];
            return;
        }
        if (whiteNum > blackNum) {
            _gameState = GAMEOVER;
            [CXYUtils showAlert:kWhiteWin];
            return;
        }
        if (whiteNum == blackNum) {
             _gameState = GAMEOVER;
             [CXYUtils showAlert: kDoubleWin];
             return;
        }
    }
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
    //画棋盘
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    for (NSInteger i=0; i<=kSize; i++) {     //画横线
        CGContextSetLineWidth(ctx, (i == 0 || i==kSize)?5:2);
        CGContextSetStrokeColorWithColor(ctx, [[UIColor purpleColor] CGColor]);
        CGContextMoveToPoint(ctx, 10,10+kNodeWidth*i);
        CGContextAddLineToPoint(ctx, 10+kNodeWidth*kSize, 10+kNodeWidth*i);
        CGContextStrokePath(ctx);
    }
    
    for (NSInteger i=0; i<=kSize; i++) {      //画竖线
        CGContextSetLineWidth(ctx, (i == 0 || i==kSize)?5:2);
        CGContextSetStrokeColorWithColor(ctx, [[UIColor purpleColor] CGColor]);
        CGContextMoveToPoint(ctx, 10+kNodeWidth*i,10);
        CGContextAddLineToPoint(ctx, 10+kNodeWidth*i, 10+kNodeWidth*kSize);
        CGContextStrokePath(ctx);
    }
   
}

@end
