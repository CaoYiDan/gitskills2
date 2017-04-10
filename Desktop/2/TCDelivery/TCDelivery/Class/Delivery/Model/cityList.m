//
//  cityList.m
//  LetsGo
//
//  Created by XJS_oxpc on 16/6/29.
//  Copyright © 2016年 XJS_oxpc. All rights reserved.
//

#import "cityList.h"
#import "areaList.h"
@implementation cityList
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
//        _ID = dict[@"id"];
        _cityName = dict[@"cityName"];
        
        NSArray *areaArray = [NSMutableArray arrayWithArray:dict[@"arealist"]];
        NSMutableArray *newArray = [NSMutableArray array];
        for (NSDictionary *dict in areaArray) {
            areaList *city = [areaList detailAreaWithDict:dict];
            [newArray addObject:city];
        }
        _arealist = newArray;
        
    }
    return self;
}

+ (instancetype)detailCityWithDict:(NSDictionary *)dict {
    return [[cityList alloc] initWithDict:dict];
}


@end
