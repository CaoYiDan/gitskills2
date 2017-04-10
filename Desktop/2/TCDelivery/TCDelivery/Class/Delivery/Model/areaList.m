//
//  areaList.m
//  LetsGo
//
//  Created by XJS_oxpc on 16/6/29.
//  Copyright © 2016年 XJS_oxpc. All rights reserved.
//

#import "areaList.h"

@implementation areaList
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
//        _ID       = dict[@"id"];
        _areaName = dict[@"areaName"];
    }
    return self;
}

+ (instancetype)detailAreaWithDict:(NSDictionary *)dict {
    return [[areaList alloc] initWithDict:dict];
}
@end
