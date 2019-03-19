//
//  LCApiProxy.m
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/3/18.
//  Copyright © 2019 宋林城. All rights reserved.
//

#import "LCApiProxy.h"

@interface LCApiProxy ()

@property (nonatomic, strong) NSMutableDictionary *dispatchTable;
@property (nonatomic, strong) AFHTTPSessionManager *serverManager;
@end

@implementation LCApiProxy

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    static LCApiProxy *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LCApiProxy alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public methods
- (NSInteger)callGETWithUrl:(NSString *)url params:(id)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure {
    
    __block NSURLSessionDataTask *serverTask = nil;
    serverTask = [self.serverManager GET:url parameters:params progress:^(NSProgress *uploadProgress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSNumber *requestID = @([serverTask taskIdentifier]);
        [self.dispatchTable removeObjectForKey:requestID];
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
    NSNumber *requestId = @([serverTask taskIdentifier]);
    self.dispatchTable[requestId] = serverTask;
    return [requestId integerValue];
}

- (NSInteger)callPOSTWithUrl:(NSString *)url params:(id)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure {
    
    __block NSURLSessionDataTask *serverTask = nil;
    serverTask = [self.serverManager POST:url parameters:params progress:^(NSProgress *uploadProgress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSNumber *requestID = @([serverTask taskIdentifier]);
        [self.dispatchTable removeObjectForKey:requestID];
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
    NSNumber *requestId = @([serverTask taskIdentifier]);
    self.dispatchTable[requestId] = serverTask;
    return [requestId integerValue];
}

- (NSInteger)callPUTWithUrl:(NSString *)url params:(id)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure {
    
    __block NSURLSessionDataTask *serverTask = nil;
    serverTask = [self.serverManager PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSNumber *requestID = @([serverTask taskIdentifier]);
        [self.dispatchTable removeObjectForKey:requestID];
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    NSNumber *requestId = @([serverTask taskIdentifier]);
    self.dispatchTable[requestId] = serverTask;
    return [requestId integerValue];
}

- (NSInteger)callDeleteWithUrl:(NSString *)url params:(id)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure {
    
    __block NSURLSessionDataTask *serverTask = nil;
    serverTask = [self.serverManager DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSNumber *requestID = @([serverTask taskIdentifier]);
        [self.dispatchTable removeObjectForKey:requestID];
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    NSNumber *requestId = @([serverTask taskIdentifier]);
    self.dispatchTable[requestId] = serverTask;
    return [requestId integerValue];
}

- (NSInteger)callPatchWithUrl:(NSString *)url params:(id)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure {
    
    __block NSURLSessionDataTask *serverTask = nil;
    serverTask = [self.serverManager PATCH:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSNumber *requestID = @([serverTask taskIdentifier]);
        [self.dispatchTable removeObjectForKey:requestID];
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    NSNumber *requestId = @([serverTask taskIdentifier]);
    self.dispatchTable[requestId] = serverTask;
    return [requestId integerValue];
}

- (NSInteger)callUploadFileWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure {
    
    __block NSURLSessionDataTask *serverTask = nil;
    NSMutableDictionary *parameters = [params mutableCopy];
    [parameters removeObjectForKey:@"files"];
    [parameters removeObjectForKey:@"fileParamsName"];
    if ([parameters count] == 0) {
        parameters = nil;
    }
    serverTask = [self.serverManager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSString *fileParamsName = [params objectForKey:@"fileParamsName"];
        NSArray *files = [params objectForKey:@"files"];
        for (NSDictionary *dict in files) {
            NSString *fileName = [dict objectForKey:@"fileName"];
            NSData *fileData = [dict objectForKey:@"fileData"];
            NSString *fileType = [dict objectForKey:@"fileType"];
            if (fileData == nil) {
                continue;
            }
            [formData appendPartWithFileData:fileData name:fileParamsName fileName:fileName mimeType:fileType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSNumber *requestID = @([serverTask taskIdentifier]);
        [self.dispatchTable removeObjectForKey:requestID];
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    NSNumber *requestId = @([serverTask taskIdentifier]);
    self.dispatchTable[requestId] = serverTask;
    return [requestId integerValue];
}

- (NSInteger)callDownloadWithUrl:(NSString *)url params:(NSDictionary *)params progress:(void (^)(NSProgress *progress))progress success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure {
    
    __block NSURLSessionDownloadTask *serverTask = nil;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:1 timeoutInterval:30];
    serverTask = [self.serverManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress(downloadProgress);
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *filePath = [params objectForKey:@"filePath"];
        NSString *fullpath = [filePath stringByAppendingPathComponent:response.suggestedFilename];
        NSURL *filePathUrl = [NSURL fileURLWithPath:fullpath];
        return filePathUrl;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            failure(error);
        }else {
            NSString *path = [params objectForKey:@"filePath"];
            NSString *fullpath = [path stringByAppendingPathComponent:response.suggestedFilename];
            success(fullpath);
        }
    }];
    [serverTask resume];
    NSNumber *requestId = @([serverTask taskIdentifier]);
    self.dispatchTable[requestId] = serverTask;
    return [requestId integerValue];
}

- (void)cancelRequestWithRequestID:(NSNumber *)requestID {
    
    NSURLSessionDataTask *requestOperation = self.dispatchTable[requestID];
    [requestOperation cancel];
    [self.dispatchTable removeObjectForKey:requestID];
}

- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList {
    
    for (NSNumber *requestId in requestIDList) {
        [self cancelRequestWithRequestID:requestId];
    }
}

#pragma mark - private mothods
- (AFSecurityPolicy*)customSecurityPolicy {
    // /先导入证书
    //NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"ZhiYangServiceCA" ofType:@"cer"];//证书的路径
    //NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    //NSData *certData = [NSUSERDEFAULTS objectForKey:@"httpcer"];
    //NSLog(@"NSData类方法读取的内容是：%@",[[NSString alloc] initWithData:certData encoding:NSUTF16StringEncoding]);
    //NSLog(@"%@",[[ NSString alloc] initWithData:certData encoding:NSASCIIStringEncoding]);
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    //securityPolicy.pinnedCertificates = @[certData];
    
    return securityPolicy;
}

#pragma mark - getters and setters
- (AFHTTPSessionManager *)serverManager {
    
    if (!_serverManager) {
        _serverManager = [AFHTTPSessionManager manager];
        _serverManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _serverManager.responseSerializer = [AFJSONResponseSerializer serializer];
        [_serverManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _serverManager.requestSerializer.timeoutInterval = 30.f;
        [_serverManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        [_serverManager setSecurityPolicy:[self customSecurityPolicy]];
    }
    return _serverManager;
}

- (NSMutableDictionary *)dispatchTable {
    
    if (!_dispatchTable) {
        _dispatchTable = [[NSMutableDictionary alloc] init];
    }
    return _dispatchTable;
}

- (void)setRequestSerializer:(AFHTTPRequestSerializer<AFURLRequestSerialization> *)requestSerializer {
    
    _requestSerializer = requestSerializer;
    self.serverManager.requestSerializer = requestSerializer;
}

- (void)setResponseSerializer:(AFHTTPResponseSerializer<AFURLResponseSerialization> *)responseSerializer {
    
    _responseSerializer = responseSerializer;
    self.serverManager.responseSerializer = responseSerializer;
}

@end
