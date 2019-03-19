//
//  LCAPIBaseManager.h
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/3/18.
//  Copyright © 2019 宋林城. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCApiProxy.h"
@class LCAPIBaseManager;

static NSString *const LCURLJoint = @"LCURLJoint";

typedef NS_ENUM (NSUInteger, LCAPIManagerErrorType){
    /** 没有产生过API请求，这个是manager的默认状态。 */
    LCAPIManagerErrorTypeDefault,
    /** API请求成功且返回数据正确，此时manager的数据是可以直接拿来使用的。 */
    LCAPIManagerErrorTypeSuccess,
    /** API请求成功但返回数据不正确。如果回调数据验证函数返回值为NO，manager的状态就会是这个。 */
    LCAPIManagerErrorTypeNoContent,
    /** 参数错误，此时manager不会调用API，因为参数验证是在调用API之前做的。 */
    LCAPIManagerErrorTypeParamsError,
    /** 请求超时。具体超时时间的设置请自己去看APIProxy的相关代码。 */
    LCAPIManagerErrorTypeTimeout,
    /** 网络不通。在调用API之前会判断一下当前网络是否通畅，这个也是在调用API之前验证的，和上面超时的状态是有区别的。 */
    LCAPIManagerErrorTypeNoNetWork,
    /** API请求失败 */
    LCAPIManagerErrorTypeFailed,
    /** API请求失败 返回信息由接口定义 */
    LCAPIManagerErrorTypeCustom,
};

typedef NS_ENUM (NSUInteger, LCAPIManagerRequestType) {
    LCAPIManagerRequestTypeGet,
    LCAPIManagerRequestTypePost,
    LCAPIManagerRequestTypeUploadFile,
    LCAPIManagerRequestTypePut,
    LCAPIManagerRequestTypeDelete,
    LCAPIManagerRequestTypePatch,
    LCAPIManagerRequestTypeDownload,
};

/** LCAPIBaseManager的派生类必须符合这些protocal */
@protocol LCAPIManager <NSObject>
@required
- (NSString *)requestUrl;
- (LCAPIManagerRequestType)requestType;
@optional
- (AFHTTPRequestSerializer <AFURLRequestSerialization> *)requestSerializer;
- (AFHTTPResponseSerializer <AFURLResponseSerialization> *)responseSerializer;
@end

/** 验证器，用于验证API的返回或者调用API的参数是否正确 */
@protocol LCAPIManagerValidator <NSObject>
@required
/*
 所有的callback数据都应该在这个函数里面进行检查，事实上，到了回调delegate的函数里面是不需要再额外验证返回数据是否为空的。
 因为判断逻辑都在这里做掉了。
 而且本来判断返回数据是否正确的逻辑就应该交给manager去做，不要放到回调到controller的delegate方法里面去做。
 */
- (BOOL)manager:(LCAPIBaseManager *)manager isCorrectWithCallBackData:(id)data;

/* 验证调用API的参数 */
- (BOOL)manager:(LCAPIBaseManager *)manager isCorrectWithParamsData:(id)data;
/* 验证API失败返回的信息是否需要特殊处理 */
- (BOOL)manager:(LCAPIBaseManager *)manager isSpecialHandleForError:(NSError *)error;
@end

/** 让manager能够获取调用API所需要的数据 */
@protocol LCApiManagerParamSource <NSObject>
@required
- (id)paramsForApi:(LCAPIBaseManager *)manager;
@end

/** api回调 */
@protocol LCApiManagerCallBackDelegate <NSObject>
@required
- (void)managerCallAPIDidSuccess:(LCAPIBaseManager *)manager;
- (void)managerCallAPIDidFailed:(LCAPIBaseManager *)manager;
@optional
- (void)managerCallAPIProgress:(LCAPIBaseManager *)manager;
@end

NS_ASSUME_NONNULL_BEGIN

@interface LCAPIBaseManager : NSObject

@property (nonatomic, weak) id<LCApiManagerCallBackDelegate> delegate;
@property (nonatomic, weak) id<LCApiManagerParamSource> paramSource;
@property (nonatomic, weak) id<LCAPIManagerValidator> validator;
@property (nonatomic, weak) NSObject<LCAPIManager> *child; //里面会调用到NSObject的方法，所以这里不用id
@property (nonatomic, strong) NSProgress *progress;
@property (nonatomic, strong) id responseObj;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, copy) NSString *errorMessage;
@property (nonatomic, assign) LCAPIManagerErrorType errorType;

/** 请求数据 */
- (void)loadData;

/** 处理error信息 */
- (NSString *)apiErrorMessage;

/** 错误信息转字典 */
- (NSDictionary *)dictionaryWithError:(NSError *)error;

/** 取消所有请求 */
- (void)cancelAllRequests;
@end

NS_ASSUME_NONNULL_END
