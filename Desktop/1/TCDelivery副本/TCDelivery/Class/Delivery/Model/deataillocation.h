//
//  deataillocation.h
//  LetsGo
//
//  Created by XJS_oxpc on 16/6/29.
//  Copyright © 2016年 XJS_oxpc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class cityList;
@interface deataillocation : NSObject
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *provinceName;

@property (nonatomic, strong) NSArray *citylist;
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)detailLocationWithDict:(NSDictionary *)dict;

@end
