//
//  deataillocation.m
//  LetsGo
//
//  Created by XJS_oxpc on 16/6/29.
//  Copyright © 2016年 XJS_oxpc. All rights reserved.
//

#import "deataillocation.h"
#import "cityList.h"
@implementation deataillocation
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
//        _ID = dict[@"id"];
        _provinceName = dict[@"provinceName"];
        
        NSArray *citiesArray = [NSMutableArray arrayWithArray:dict[@"citylist"]];
        NSMutableArray *newArray = [NSMutableArray array];
        for (NSDictionary *dict in citiesArray) {
            cityList *city = [cityList detailCityWithDict:dict];
            [newArray addObject:city];
        }
        _citylist = newArray;
        
    }
    return self;
    
}

+ (instancetype)detailLocationWithDict:(NSDictionary *)dict {
    return [[deataillocation alloc] initWithDict:dict];
}


@end
