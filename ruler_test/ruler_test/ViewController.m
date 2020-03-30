//
//  ViewController.m
//  ruler_test
//
//  Created by hxxc on 2020/3/24.
//  Copyright © 2020 xjc. All rights reserved.
//

#import "ViewController.h"
#import "HXBuyScrollView.h"
#import "UIColor+Extensions.h"

#define defaultY SCREEN_HEIGHT/2.0
@interface ViewController ()<UIScrollViewDelegate,UITextFieldDelegate>

@property(nonatomic,strong)UITextField * inputTextField;//数字输入
@property(nonatomic,strong)HXBuyScrollView * scrollView;
@property(nonatomic,strong)UIScrollView * hxScrollView;
@property(nonatomic,assign)float minX;
@property(nonatomic,assign)NSString * defaultOffset;
@property(nonatomic,strong)UIImageView *lineLable1;
@property(nonatomic,strong)UIImageView *lineLable2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //动态创建刻录尺
    [self.scrollView createScorll:@"0" andMax:@"50000" defaultOffset:_defaultOffset];
    
    //中点标识线
    _lineLable1 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2.0, defaultY, 1, 50)];
    _lineLable1.backgroundColor = [UIColor colorWithHex:0xff8f10];
    [self.view addSubview:_lineLable1];
    
    //底部线条
    _lineLable2 = [[UIImageView alloc] initWithFrame:CGRectMake(15, defaultY + 49.5, SCREEN_WIDTH-30, 0.5)];
    _lineLable2.backgroundColor = [UIColor colorWithHex:0xcccccc];
    [self.view addSubview:_lineLable2];
    
    //文本输入框
    _inputTextField = [[UITextField alloc]init];
    _inputTextField.frame = CGRectMake(15, defaultY - 64, SCREEN_WIDTH - 30, 44);
    _inputTextField.text = _defaultOffset;
    _inputTextField.textAlignment = NSTextAlignmentCenter;
    _inputTextField.textColor = [UIColor colorWithHex:0xff8f10];
    _inputTextField.font = [UIFont systemFontOfSize:21];
    _inputTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_inputTextField];
    self.inputTextField.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    UIImageView * lineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 190, 1)];
    lineView.center = CGPointMake(_inputTextField.center.x, _inputTextField.center.y + 22);
    lineView.image = [UIImage imageNamed:@"point"];
    [self.view addSubview:lineView];
}

-(HXBuyScrollView *)scrollView{
    
    if (!_scrollView) {
        
        _scrollView = [[HXBuyScrollView alloc] initWithFrame:CGRectMake(15, defaultY, SCREEN_WIDTH-30, 50)];
        _hxScrollView =_scrollView.hxCollectionView;
        _hxScrollView.delegate = self;
        _minX = 0;
        _defaultOffset = @"10000";
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

#pragma mark --- scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSDecimalNumber * moneyStr = nil;
    
    float number = scrollView.contentOffset.x;
    number = number/10.0f;
    CGFloat money = number * 100 + _minX;
    moneyStr = [[NSDecimalNumber alloc]initWithFloat:money];
    
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    //滑动最终结果
    _inputTextField.text = [NSString stringWithFormat:@"%@",[moneyStr decimalNumberByRoundingAccordingToBehavior:roundingBehavior]];

}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    NSInteger number = scrollView.contentOffset.x;
    NSInteger count = number/10;
    NSInteger surplus = number%100 ;
    surplus = surplus%10;
    if (surplus <= 5) {
        
        [UIView animateWithDuration:0.3 animations:^{
            scrollView.contentOffset = CGPointMake((count) * 10, 0);
        }];
        
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            scrollView.contentOffset = CGPointMake((count +1) * 10, 0);
        }];
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger number = scrollView.contentOffset.x;
    NSInteger count = number/10;
    NSInteger surplus = number%100 ;
    surplus = surplus%10;
    if (surplus <= 5) {
        
        [UIView animateWithDuration:0.3 animations:^{
            scrollView.contentOffset = CGPointMake((count) * 10, 0);
        }];
        
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            scrollView.contentOffset = CGPointMake((count +1) * 10, 0);
        }];
    }
}

//滑动条跟随文本输入变化
- (void)textFieldChange:(NSNotification *)noti{
    UITextField * tF = noti.object;
    NSString *textString = tF.text;
    if (_inputTextField.isEditing) {
        _hxScrollView.contentOffset = CGPointMake(([tF.text floatValue] - _minX) / 100 * 10, 0);
        _inputTextField.text = textString;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

@end
