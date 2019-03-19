//
//  LCAPIBaseManager.m
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/3/18.
//  Copyright © 2019 宋林城. All rights reserved.
//

#import "LCAPIBaseManager.h"

@interface LCAPIBaseManager ()

@property (nonatomic, strong) NSMutableArray *requestIdList;
@end

@implementation LCAPIBaseManager

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.delegate = nil;
        self.validator = nil;
        self.paramSource = nil;
        if ([self conformsToProtocol:@protocol(LCAPIManager)]) {
            self.child = (id <LCAPIManager>)self;
        } else {
            self.child = (id <LCAPIManager>)self;
            NSException *exception = [[NSException alloc] initWithName:@"LCAPIBaseManager提示" reason:[NSString stringWithFormat:@"%@没有遵循LCAPIManager协议",self.child] userInfo:nil];
            @throw exception;
        }
    }
    return self;
}

- (void)loadData {
    
    id params = [self.paramSource paramsForApi:self];
    self.errorMessage = @"";
    self.errorType = 0;
    self.responseObj = nil;
    self.error = nil;
    [self loadDataWithParams:params];
}

/** 根据参数进行通讯 */
- (void)loadDataWithParams:(NSDictionary *)params {
    
    LCAPIManagerRequestType httpType = [self.child requestType];
    NSString *url = [self.child requestUrl];
    id requestParams = [params mutableCopy];
    if (![requestParams isKindOfClass:[NSArray class]]) {
        //进行url params特殊处理
        NSString *jointString = [requestParams objectForKey:LCURLJoint];
        if (!kStringIsEmpty(jointString)) {
            NSString *lastElement = [url substringFromIndex:url.length-1];
            if ([lastElement isEqualToString:@"/"]) {
                url = [NSString stringWithFormat:@"%@%@",url ,jointString];
            }else {
                url = [NSString stringWithFormat:@"%@/%@",url ,jointString];
            }
        }
        [requestParams removeObjectForKey:LCURLJoint];
    }
    NSLog(@"LCAPIBaseManager请求信息: URL = %@ \n params = %@",url, params);;
    
    //检测传入数据是否正确
    if ([self.validator manager:self isCorrectWithParamsData:requestParams]) {
        //网络是否正常
        if (![[NSUSERDEFAULTS objectForKey:KNetWorkState] boolValue]) {
            self.errorType = LCAPIManagerErrorTypeNoNetWork;
            [self handleRequestFail:nil];
        }
        //请求格式格式 默认为json
        if ([self.child respondsToSelector:@selector(requestSerializer)]) {
            [LCApiProxy sharedInstance].requestSerializer = [self.child requestSerializer];
        }else {
            [LCApiProxy sharedInstance].requestSerializer = [AFJSONRequestSerializer serializer];
        }
        //返回格式格式 默认为json
        if ([self.child respondsToSelector:@selector(responseSerializer)]) {
            [LCApiProxy sharedInstance].responseSerializer = [self.child responseSerializer];
        }else {
            [LCApiProxy sharedInstance].responseSerializer = [AFJSONResponseSerializer serializer];
        }
        //此处处理过于繁琐，可尝试将AFN中dataTaskWithHTTPMethod方法暴露到接口中调用简化下方操作处理
        switch (httpType) {
            case LCAPIManagerRequestTypePost:{
                NSInteger requestId = [[LCApiProxy sharedInstance] callPOSTWithUrl:url params:requestParams success:^(id responseObj) {
                    [self handleRequestSuccess:responseObj];
                } failure:^(NSError *error) {
                    self.errorType = LCAPIManagerErrorTypeFailed;
                    [self handleRequestFail:error];
                }];
                [self.requestIdList addObject:@(requestId)];
                break;
            }
            case LCAPIManagerRequestTypeUploadFile:{
                NSInteger requestId = [[LCApiProxy sharedInstance] callUploadFileWithUrl:url params:requestParams success:^(id responseObj) {
                    [self handleRequestSuccess:responseObj];
                } failure:^(NSError *error) {
                    self.errorType = LCAPIManagerErrorTypeFailed;
                    [self handleRequestFail:error];
                }];
                [self.requestIdList addObject:@(requestId)];
                break;
            }
            case LCAPIManagerRequestTypeDownload:{
                NSInteger requestId = [[LCApiProxy sharedInstance] callDownloadWithUrl:url params:params progress:^(NSProgress *progress) {
                    [self handleRequestProgress:progress];
                } success:^(id responseObj) {
                    [self handleRequestSuccess:responseObj];
                } failure:^(NSError *error) {
                    self.errorType = LCAPIManagerErrorTypeFailed;
                    [self handleRequestFail:error];
                }];
                [self.requestIdList addObject:@(requestId)];
                break;
            }
            case LCAPIManagerRequestTypeGet:{
                NSInteger requestId = [[LCApiProxy sharedInstance] callGETWithUrl:url params:requestParams success:^(id responseObj) {
                    [self handleRequestSuccess:responseObj];
                } failure:^(NSError *error) {
                    self.errorType = LCAPIManagerErrorTypeFailed;
                    [self handleRequestFail:error];
                }];
                [self.requestIdList addObject:@(requestId)];
                break;
            }
            case LCAPIManagerRequestTypePut:{
                NSInteger requestId = [[LCApiProxy sharedInstance] callPUTWithUrl:url params:requestParams success:^(id responseObj) {
                    [self handleRequestSuccess:responseObj];
                } failure:^(NSError *error) {
                    self.errorType = LCAPIManagerErrorTypeFailed;
                    [self handleRequestFail:error];
                }];
                [self.requestIdList addObject:@(requestId)];
                break;
            }
            case LCAPIManagerRequestTypePatch:{
                NSInteger requestId = [[LCApiProxy sharedInstance] callPatchWithUrl:url params:requestParams success:^(id responseObj) {
                    [self handleRequestSuccess:responseObj];
                } failure:^(NSError *error) {
                    self.errorType = LCAPIManagerErrorTypeFailed;
                    [self handleRequestFail:error];
                }];
                [self.requestIdList addObject:@(requestId)];
                break;
            }
            case LCAPIManagerRequestTypeDelete:{
                NSInteger requestId = [[LCApiProxy sharedInstance] callDeleteWithUrl:url params:requestParams success:^(id responseObj) {
                    [self handleRequestSuccess:responseObj];
                } failure:^(NSError *error) {
                    self.errorType = LCAPIManagerErrorTypeFailed;
                    [self handleRequestFail:error];
                }];
                [self.requestIdList addObject:@(requestId)];
                break;
            }
            default:
                break;
        }
    }else {
        self.errorType = LCAPIManagerErrorTypeParamsError;
        [self handleRequestFail:nil];
    }
}

- (void)handleRequestProgress:(NSProgress *)progress {
    
    self.progress = progress;
    if ([self.delegate respondsToSelector:@selector(managerCallAPIProgress:)]) {
        [self.delegate managerCallAPIProgress:self];
    }
}

- (void)handleRequestSuccess:(id)responseObj {
    
    //判断返回数据是否正确
    if ([self.validator manager:self isCorrectWithCallBackData:responseObj]) {
        if ([self.delegate respondsToSelector:@selector(managerCallAPIDidSuccess:)]) {
            [self.delegate managerCallAPIDidSuccess:self];
        }
    }else {
        //接口返回的数据验证不正确
        self.errorType = LCAPIManagerErrorTypeNoContent;
        [self handleRequestFail:nil];
    }
}

- (void)handleRequestFail:(NSError *)error {
    
    self.error = error;
    //error=nil时可能为数据上传或接收格式问题或者网络问题
    if (error) {
        //处理error信息
//        NSHTTPURLResponse *response = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
//        NSInteger status = response.statusCode;
//        NSDictionary *errorDict = [self dictionaryWithError:error];
//        NSString *code = [NSString stringWithFormat:@"%@",[errorDict objectForKey:@"code"]];
        
        if ([self.validator manager:self isSpecialHandleForError:error]) {
            self.errorType = LCAPIManagerErrorTypeCustom;
        }else {
            
        }
    }
    if ([self.delegate respondsToSelector:@selector(managerCallAPIDidFailed:)]) {
        [self.delegate managerCallAPIDidFailed:self];
    }
}

/** 取消所有请求 */
- (void)cancelAllRequests {
    
    [[LCApiProxy sharedInstance] cancelRequestWithRequestIDList:self.requestIdList];
    [self.requestIdList removeAllObjects];
}

/** 错误信息转字典 */
- (NSDictionary *)dictionaryWithError:(NSError *)error {
    
    if (error == nil) {
        return nil;
    }
    NSData *errorData = (NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
    if (errorData == nil) {
        return nil;
    }
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:errorData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        return nil;
    }
    return dic;
}

/** 处理error信息 */
- (NSString *)apiErrorMessage {
    
    NSString *message = @"网络通讯失败";
    switch (self.errorType) {
        case LCAPIManagerErrorTypeNoContent:{
            message = kStringIsEmpty(self.errorMessage) ? @"获取数据异常" : self.errorMessage;
            break;
        }
        case LCAPIManagerErrorTypeFailed:{
            message = @"网络通讯失败";
            break;
        }
        case LCAPIManagerErrorTypeNoNetWork:{
            message = @"请检查网络连接";
            break;
        }
        case LCAPIManagerErrorTypeCustom:
        case LCAPIManagerErrorTypeParamsError:{
            message = self.errorMessage;
            break;
        }
        default:
            break;
    }
    return message;
}

- (NSString *)getJointParamsString:(NSDictionary *)params {
    
    if (params == nil) {
        params = [NSDictionary dictionary];
    }
    NSMutableDictionary *tempParams = [params mutableCopy];
    //查看是否含有jobNo字段，不存在插入
    //    if ([params objectForKey:@"jobNo"] == nil) {
    //        [tempParams setObject:JobNo forKey:@"jobNo"];
    //    }
    __block NSString *jointString;
    [tempParams enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
        
        if (kStringIsEmpty(jointString)) {
            jointString = [NSString stringWithFormat:@"?%@=%@",key,value];
        }else {
            jointString = [NSString stringWithFormat:@"%@&%@=%@",jointString,key,value];
        }
    }];
    return jointString;
}

#pragma mark - getters and setters
- (NSMutableArray *)requestIdList {
    
    if (!_requestIdList) {
        _requestIdList = [NSMutableArray array];
    }
    return _requestIdList;
}

@end
