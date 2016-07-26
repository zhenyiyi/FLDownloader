//
//  ViewController.m
//  FLDownloader
//
//  Created by fenglin on 16/7/26.
//  Copyright © 2016年 cys. All rights reserved.
//

#import "ViewController.h"
#import "GJCFFileDownloadManager.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDate *now = [NSDate date];//根据当前系统的时区产生当前的时间，绝对时间，所以同为中午12点，不同的时区，这个时间是不同的。
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeZone = [NSTimeZone systemTimeZone];//系统所在时区
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss SS";
    NSString *systemTimeZoneStr =  [df stringFromDate:now];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
