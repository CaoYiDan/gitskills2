//
//  LGRegistViewController.m
//  LetsGo
//
//  Created by XJS_oxpc on 16/5/16.
//  Copyright © 2016年 XJS_oxpc. All rights reserved.
//

#import "LGRegistViewController.h"
#import "ServerViewController.h"
@interface LGRegistViewController ()<UIGestureRecognizerDelegate>
{
    UIButton* getpassbutton;
    NSTimer * getpasstimer;
    BOOL isValidated;
    UILabel*_delegateBtn;
}

@property (nonatomic,strong)NSString *valicode;//系统下发的短信验证码
@property (nonatomic,strong)NSTimer *timer;//重发计时器
@property (nonatomic,assign)NSInteger timeInterval;//默认60秒
@end

@implementation LGRegistViewController
- (IBAction)back:(id)sender {
//     [self  dismissViewControllerAnimated:YES completion:^{
//         
//     }];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setBack:(UIButton *)back{
    _back=back;
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scroview.backgroundColor=LGLighgtBGroundColour235;
      self.phoneNumField.keyboardType = UIKeyboardTypeNumberPad;
      self.codeField.keyboardType = UIKeyboardTypeNumberPad;
    [self.phoneNumField becomeFirstResponder];
    self.view.backgroundColor=[UIColor whiteColor];
    //Lets购协议
    [self createDelegate];
}

-(void)createDelegate{
    _delegateBtn=[[UILabel alloc]initWithFrame:CGRectMake(10, 250, kWindowW, 30)];
    
    _delegateBtn.textColor=[UIColor blackColor];
    _delegateBtn.text=@"注册即视为同意协议";
    _delegateBtn.font=Font(12);
//    NSRange range=[_delegateBtn.text rangeOfString:@"Lets购协议"];
//    [_delegateBtn  setAttributeTextWithString:_delegateBtn.text range:range WithColour:LGDarkRedColur];
//    
    UIButton*btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 30)];
    
    btn.backgroundColor=[UIColor clearColor];
    [btn addTarget:self action:@selector(delegateClick) forControlEvents:UIControlEventTouchDown];
    [_delegateBtn addSubview:btn];
    self.scroview.userInteractionEnabled=YES;
    _delegateBtn.userInteractionEnabled=YES;
    [self.scroview addSubview:_delegateBtn ];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

-(void)delegateClick{
    
}
#pragma mark 获取验证码
- (IBAction)Getcode:(id)sender
{
    WeakSelf;
    [self.phoneNumField resignFirstResponder];
    getpassbutton=(UIButton*)sender;
        NSString *mobile = self.phoneNumField.text;
     if (mobile.length == 0 || ![Common checkTel:self.phoneNumField.text])
     {
         ToastError(@"请输入正确格式的手机号码");
         
        }else{
        NSMutableDictionary*dic=[[NSMutableDictionary alloc]init];
                    //获取验证码的手机号码
        [dic setObject:weakSelf.phoneNumField.text forKey: @"toMobile"];
            
        [[HttpRequest sharedClient]httpRequestPOST:kUrlSmsGetCode parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
            NSLog(@"%@",responseObject);
            
        NSString*ifSuccess=responseObject[@"success"];

            if ([ifSuccess integerValue]==0){//验证失败
                
            }else{

           [MBProgressHUD showMessage:@"已将验证码发送到您的手机" toView:self.view afterDelty:1.5];
                
             weakSelf.timeInterval = 60;
                        
              if (weakSelf.timer) {
                [weakSelf.timer invalidate];
                 weakSelf.timer = nil;
                        }
                        
            weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:weakSelf selector:@selector(onTimerValicodeReqeust) userInfo:nil repeats:YES];
            }
                    } failure:^(NSURLSessionDataTask *task, NSError *error) {
                        ToastError(@"获取验证码失败");
                    }];
    }
}

#pragma mark 重新获取验证码倒计时60秒

- (void)onTimerValicodeReqeust{
    self.timeInterval--;
    
    if (self.timeInterval == 119) {
        
        [self.codeBtn setEnabled:NO];
    }
    
    if (self.timeInterval <= 0) {
        [self.codeBtn setEnabled:YES];
       
        [self.codeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
        [self.codeBtn setBackgroundImage:[UIImage imageNamed:@"common_btn_normal"] forState:UIControlStateNormal];
      
        [self.codeBtn setBackgroundImage:[UIImage imageNamed:@"common_btn_normal"] forState:UIControlStateHighlighted];
        [self.timer invalidate];
        self.timer = nil;
        
    }else{
        
        NSString *timeTitle = [NSString stringWithFormat:@"发送中(%lis)",(long)self.timeInterval];
       
        [self.codeBtn setEnabled:YES];
        [self.codeBtn setTitle:timeTitle forState:UIControlStateNormal];
        [self.codeBtn setEnabled:NO];
    }

}

-(void)setCodeBtn:(UIButton *)codeBtn{

    _codeBtn=codeBtn;
    codeBtn.frameWidth=200;
}

#pragma mark 执行下一步
- (IBAction)next:(id)sender {

    NSString *mobile = self.phoneNumField.text;

         if (mobile.length == 0|| ![Common checkTel:self.phoneNumField.text]) {
          
             [MBProgressHUD showError:@"请输入正确手机号码"];
            return;
        }
    
        NSString *code = self.codeField.text;
        if (code.length == 0 ) {
            
            [MBProgressHUD showError:@"请输入验证码"];
            return;
        }
    
    NSMutableDictionary*dic=[[NSMutableDictionary alloc]init];
    //获取验证码的手机号码
    [dic setObject:self.phoneNumField.text forKey: @"toMobile"];
    //验证码
    [dic setObject:code forKey: @"code"];
    
    /** 验证码验证*/
    [[HttpRequest sharedClient]httpRequestPOST:kUrlSmsCheckCode parameters:dic progress:nil sucess:^(NSURLSessionDataTask *task, id responseObject, ResponseObject *obj) {
        NSLog(@"%@",responseObject);
        NSString*ifSuccess=responseObject[@"success"];
        if ([ifSuccess integerValue]==0){//验证失败
            ToastError(responseObject[@"info"]);
        }
        else{
            //验证码输入正确进入密码设置界面
            ServerViewController*vc=[[ServerViewController alloc]init];
            vc.view.backgroundColor=[UIColor blackColor];
            //将手机号码传给vc
            vc.phoneNumber=self.phoneNumField.text;
            [self.navigationController pushViewController:vc animated:YES];
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ToastError(@"验证码错误");
    }];

}

@end
