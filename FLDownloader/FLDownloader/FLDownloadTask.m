//
//  FLDownloadTask.m
//  FLDownloader
//
//  Created by fenglin on 16/7/26.
//  Copyright © 2016年 cys. All rights reserved.
//

#import "FLDownloadTask.h"

@interface FLDownloadTask ()

@property (nonatomic, strong, readwrite) NSHashTable *taskObservers;

@property (nonatomic, strong, readwrite)NSHashTable *cachePaths; //< 缓存目录。


@property (nonatomic, copy, readwrite)NSString *taskUniqueIdentifier; //< 任务的唯一标识符。

@property (nonatomic, copy, readwrite)NSString *downloadURL;

@property (nonatomic, assign, readwrite)FLDownloadTaskState taskState;

@property (nonatomic, strong, readwrite)NSDictionary *userInfo;





@end

@implementation FLDownloadTask

- (instancetype)init
{
    self = [super init];
    if (self) {
        _taskObservers = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
        _cachePaths = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
        _taskState = FLDownloadTaskStateReady;
        _taskUniqueIdentifier = [[self class] currentTimesamp];
    }
    return self;
}

+ (NSString *)currentTimesamp{
    NSDate *now = [NSDate date];//根据当前系统的时区产生当前的时间，绝对时间，所以同为中午12点，不同的时区，这个时间是不同的。
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeZone = [NSTimeZone systemTimeZone];//系统所在时区
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss SS";
    NSString *systemTimeZoneStr =  [df stringFromDate:now];
    return systemTimeZoneStr;
}

+(FLDownloadTask *)taskWithDownloadUrl:(NSString *)downloadURL
                             cachePath:(NSString*)cachePath
                              observer:(NSObject*)observer
                         taskIdentifer:(NSString **)taskIdentifier
                          withUserInfo:(NSDictionary *)userInfo{
    NSAssert((downloadURL != nil && cachePath != nil && observer != nil && taskIdentifier != nil), @"init error ; due to downloadURL , cachePath , observer or taskIdentifier to be nil");
    FLDownloadTask *task = [[FLDownloadTask alloc] init];
    task.downloadURL = downloadURL;
    task.userInfo =userInfo;
    if (taskIdentifier) {
        *taskIdentifier = task.taskUniqueIdentifier;
    }
    [task addTaskObserver:observer];
    [task addTaskCachePath:cachePath];
    return task;
}

#pragma mark -- Public Method
- (void)addTaskObserver:(id)observer{
    if (!observer) {
        return;
    }
    if (![_taskObservers containsObject:observer]) {
        [_taskObservers addObject:observer];
    }
}

- (void)addTaskCachePath:(NSString *)path{
    if (!path) {
        return;
    }
    for (NSString *cachePath in _cachePaths) {
        if ([cachePath isEqualToString:path]) {
            return;
        }
    }
    [_cachePaths addObject:path];
}

- (void)removeTaskObserver:(id)observer{
    if (!observer) {
        return;
    }
    if ([_taskObservers containsObject:observer]) {
        [_taskObservers removeObject:observer];
    }
}

- (BOOL)isEqualToTask:(FLDownloadTask *)task{
    if (!task) {
        return NO;
    }
    if ([task.downloadURL isEqualToString:self.downloadURL]) {
        return YES;
    }
    return NO;
}



@end
