//
//  areaList.h
//  LetsGo
//
//  Created by XJS_oxpc on 16/6/29.
//  Copyright © 2016年 XJS_oxpc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface areaList : NSObject
@property (nonatomic, copy) NSString     *ID;
@property (nonatomic, copy) NSString     *areaName;
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)detailAreaWithDict:(NSDictionary *)dict;
@end
