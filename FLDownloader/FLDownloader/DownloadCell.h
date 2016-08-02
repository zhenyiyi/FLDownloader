//
//  DownloadCell.h
//  FLDownloader
//
//  Created by fenglin on 16/7/29.
//  Copyright © 2016年 cys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;

@end
