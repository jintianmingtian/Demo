//
//  ViewController.m
//  获取年月日时分秒星期
//
//  Created by cyf on 2017/3/29.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "ViewController.h"
#import "TimePickerView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)addPickerView:(UIButton *)sender {
    [TimePickerView createMenuWithTarget:self itemsClickBlock:^(NSString *str) {
        NSLog(@"%@", str);
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
