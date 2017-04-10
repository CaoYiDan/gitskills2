//
//  TCProvicePickView.h
//  TCDelivery
//
//  Created by 融合互联-------lisen on 17/3/5.
//
//

#import <UIKit/UIKit.h>
typedef void(^complentBlock) (NSString*provice,NSString*city,NSString*country);
@interface TCProvicePickView : UIView
/**<#Name#>*/
@property(nonatomic,copy)complentBlock complient;
-(instancetype)initWithFrame:(CGRect)frame complent:(void(^)(NSString*provice,NSString*city,NSString*country))complent;
@end
