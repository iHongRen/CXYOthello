//
//  CXYEnum.h
//  CXYHBChess
//
//  Created by iMac on 14-9-8.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//

#ifndef CXYHBChess_CXYEnum_h
#define CXYHBChess_CXYEnum_h

typedef NS_ENUM (NSInteger, NODESTATE)
{
    KBLACK = 0,
    KWHITE,
    KHINT,
    KCLEAR
};

typedef NS_ENUM (NSInteger,WHODOWNNODE)
{
    PLAYER = 0,
    OTHERPLAYER,
    AICOMPUTER,
    NOBODY
};

typedef NS_ENUM (NSInteger,GAMESTATE)
{
    GAMEREADY = 0,
    GAMEING,
    GAMEOVER
};

typedef NS_ENUM (NSInteger,GAMELEVEL)
{
    KPRIMARY = 0,
    KMIDDLE,
    KADVANCED
};
#endif
