//
//  otherViewController.m
//  LGDeckViewController
//
//  Created by huangzhenyu on 15/6/1.
//  Copyright (c) 2015年 Jamie-Ling. All rights reserved.
//

#import "OtherViewController.h"

@interface OtherViewController ()

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =LGLighgtBGroundColour235;
    self.navigationItem.title=@"关于我们";
    [self createUI];
}

#pragma mark - createUI
- (void)createUI{

//    if ([self.titleStr isEqualToString:@"关于我们"]) {
        UITextView * textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 64, kWindowW-0, kWindowH-64) textContainer:nil];
        textView.text =@"        唐山公路港致力于整合\"物流服务、物流载体和物流需求\"三大资源，为众多物流企业提供\"信息交易、商务配套和物业\"等系统服务，是\"物流平台整合运营商和综合服务提供商\"。\n        唐山公路港项目选址于北方现代物流城，G102（112）国道和丰津公路交叉口，规划占地747亩，规划建筑面积25万平方米。\n        其地理位置优越，交通便利，是连接东北、华北的重要通道。地处京、津、唐、秦腹地，西距北京120公里，西南距天津130公里，东距秦皇岛120公里，南距唐山中心区22.5公里，公路四通八达，G102、G112两条国道、丰津一级公路和京沈高速公路、津唐高速公路、唐山东外环高速公路、西外环高速公路在境内连接；铁路纵横交错，京秦、京山、唐遵三条铁路横跨城区，境内设有二级铁路货运编组站和三级铁路客运站；水路运输便利，距京唐港130公里，空运还可以对接境内的唐山机场，\"唐山公路港\"依托丰润的区位优势，建设成服务唐山、辐射京津冀区域物流的重大节点以及城市配送的综合枢纽。";
        textView.textColor = [UIColor blackColor];
        textView.userInteractionEnabled=NO;
        textView.font = [UIFont systemFontOfSize:15];
        textView.textAlignment = NSTextAlignmentNatural;
        [self.view addSubview:textView];
//    }else if ([self.titleStr isEqualToString:@"联系我们"]){
//    
//        UITextView * textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, kWindowW-20, kWindowH-60) textContainer:nil];
//        textView.text =@"名称：唐山公路港物流有限公司\n邮编：064000\n联系电话：0315-5013061\n地址：河北省唐山市丰润区102国道与丰津公路交叉口西南角";
//        textView.textColor = [UIColor blackColor];
//        textView.font = [UIFont systemFontOfSize:15];
//        textView.textAlignment = NSTextAlignmentNatural;
//        [self.view addSubview:textView];
//    }
}
#pragma mark - backClick
- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
