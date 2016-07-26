//
//  FLDownloadTask.h
//  FLDownloader
//
//  Created by fenglin on 16/7/26.
//  Copyright © 2016年 cys. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FLDownloadTaskState) {
    FLDownloadTaskStateFailure = -1,
    FLDownloadTaskStateReady = 0,
    FLDownloadTaskStateDownloding,
    FLDownloadTaskStateSuccess,
    FLDownloadTaskStateCancel
};

@interface FLDownloadTask : NSObject

@property (nonatomic, assign, readonly)FLDownloadTaskState taskState; //<当前状态。

@property (nonatomic, copy, readonly)NSString *taskUniqueIdentifier; //< 任务的唯一标识符。

@property (nonatomic, copy, readonly)NSString *downloadURL; //<下载地址。



@property (nonatomic, strong, readonly)NSDictionary *userInfo; //< 自定义消息。

@property (nonatomic, strong, readonly)NSHashTable *taskObservers; //< 任务观察组

@property (nonatomic, strong, readonly)NSHashTable *cachePaths; //< 缓存目录。

+(FLDownloadTask *)taskWithDownloadUrl:(NSString *)downloadURL
                             cachePath:(NSString*)cachePath
                              observer:(NSObject*)observer
                         taskIdentifer:(NSString **)taskIdentifier
                          withUserInfo:(NSDictionary *)userInfo;


- (void)addTaskObserver:(id)observer;

- (void)addTaskCachePath:(NSString *)path;

- (void)removeTaskObserver:(id)observer;

- (BOOL)isEqualToTask:(FLDownloadTask *)task;


@end
