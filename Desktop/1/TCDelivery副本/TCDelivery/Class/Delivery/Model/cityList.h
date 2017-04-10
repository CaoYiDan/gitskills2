//
//  cityList.h
//  LetsGo
//
//  Created by XJS_oxpc on 16/6/29.
//  Copyright © 2016年 XJS_oxpc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  areaList;
@interface cityList : NSObject

@property (nonatomic, copy  ) NSString     *ID;

@property (nonatomic, copy  ) NSString     *cityName;

@property (nonatomic, strong) NSArray      *arealist;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)detailCityWithDict:(NSDictionary *)dict;
@end
