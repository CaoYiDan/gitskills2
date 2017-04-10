//
//  TCProvicePickView.m
//  TCDelivery
//
//  Created by 融合互联-------lisen on 17/3/5.
//
//
#import "areaList.h"
#import "cityList.h"
#import "deataillocation.h"
#import "TCProvicePickView.h"
@interface TCProvicePickView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)UIView*basePickView;
//数组，本地的省市文件
@property (nonatomic, strong) NSArray *locData;
//省市选择pickView
@property (nonatomic, strong) UIPickerView *cityPicker;
// 选择器选中的省份
@property (nonatomic, assign) NSInteger provinceIndex;
// 选择器选中的城市
@property (nonatomic, assign) NSInteger cityIndex;

@end
@implementation TCProvicePickView
{
    deataillocation*province;
}
//构造方法
-(instancetype)initWithFrame:(CGRect)frame complent:(void (^)(NSString *, NSString *, NSString *))complent{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=[UIColor blackColor];
        _complient=complent;
//        加载本地的城市文件
        [self locData];
        
        [self basePickView];
    }
    return self;
}

#pragma  mark 加载本地的城市文件。
- (NSArray *)locData {
    if (!_locData) {
        NSArray *dataArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"detaillocation" ofType:@"plist"]];
        NSMutableArray *newArray = [NSMutableArray array];
        for (NSDictionary *dict in dataArray) {
            deataillocation*loc = [deataillocation detailLocationWithDict:dict];
            
            [newArray addObject:loc];
        }
        _locData = newArray;
    }
    
    return _locData;
}

#pragma  mark 省市区的三级联动View
-(UIView*)basePickView{
    if (_basePickView==nil) {
        _basePickView=[[UIView alloc]initWithFrame:CGRectMake(0,kWindowH-200-49, kWindowW, 180)];
        
        [self addSubview:_basePickView];
        //关闭按钮
        UIButton*close=[[UIButton alloc]initWithFrame:CGRectMake(5, 150, kWindowW-10, 40)];
        close.titleLabel.textAlignment=NSTextAlignmentCenter;
        [close setTitle:@"确认" forState:0];
        close.backgroundColor=[UIColor orangeColor];
        [close addTarget:self action:@selector(closePickView) forControlEvents:UIControlEventTouchUpInside];
        [_basePickView addSubview:close];
        
        _cityPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(5, 0, kWindowW-10, 150)];
        _cityPicker.delegate = self;
        _cityPicker.dataSource = self;
        _cityPicker.backgroundColor = LGLighgtBGroundColour235;
        
        [_basePickView addSubview:_cityPicker];
    }
    return _basePickView;
}
-(void)closePickView{
    
    if (isEmptyString(province.provinceName)) {
        !self.complient?:self.complient(@"北京",@"市辖区",@"东城区");
    }
    [self removeFromSuperview];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

#pragma mark pickcview返回的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger count=0;
    
    deataillocation *deLoc = self.locData[[self.cityPicker selectedRowInComponent:0]];
    if (component == 0) {
        count = self.locData.count;
    } else if (component == 1) {
        count = deLoc.citylist.count;
    } else if (component == 2) {
        deataillocation *deLoc = self.locData[self.provinceIndex];
        cityList *deCity = deLoc.citylist[self.cityIndex];
        count = deCity.arealist.count;
    }
    return count;
}

#pragma mark 返回的内容 和 UIView
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *myView = nil;
    myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 30)] ;
    
    myView.textAlignment = NSTextAlignmentCenter;
    NSString *title;
    if (component == 0) {
        title = [self.locData[row] provinceName];
        
    } else if (component == 1) {
        NSArray *cityList = [self.locData[self.provinceIndex] citylist];
        title = [cityList[row] cityName];
    } else if (component == 2) {
        NSArray *cityList = [self.locData[self.provinceIndex] citylist];
        NSArray *areaList = [cityList[self.cityIndex] arealist];
        title = [areaList[row] areaName];
    }
    myView.text=title;
    myView.font = [UIFont systemFontOfSize:13];         //用label来设置字体大小
    
    myView.backgroundColor = [UIColor clearColor];
    return myView;
}

#pragma mark pickView选择之后，将选择传给模型
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    
    if (component == 0) {
        self.provinceIndex = row;
        self.cityIndex = 0; // 恢复为0
        [self.cityPicker reloadComponent:1];
        [self.cityPicker reloadComponent:2];
        [self.cityPicker selectRow:0 inComponent:1 animated:YES];
        [self.cityPicker selectRow:0 inComponent:2 animated:YES];
    } else if (component == 1) {
        self.cityIndex = row;
        [self.cityPicker reloadComponent:2];
        [self.cityPicker selectRow:0 inComponent:2 animated:YES];
    }
    
    province = self.locData[self.provinceIndex];
    cityList*city = province.citylist[self.cityIndex];
    NSInteger areaIndex = [self.cityPicker selectedRowInComponent:2];
    areaList *area = city.arealist[areaIndex];
    
    !self.complient?:self.complient(province.provinceName,city.cityName,area.areaName);
}


@end
