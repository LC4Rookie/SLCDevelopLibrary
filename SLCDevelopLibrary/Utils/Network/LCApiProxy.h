//
//  LCApiProxy.h
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/3/18.
//  Copyright © 2019 宋林城. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface LCApiProxy : NSObject

@property (nonatomic, strong) AFHTTPRequestSerializer <AFURLRequestSerialization> * requestSerializer;
@property (nonatomic, strong) AFHTTPResponseSerializer <AFURLResponseSerialization> * responseSerializer;

+ (instancetype)sharedInstance;

- (NSInteger)callGETWithUrl:(NSString *)url params:(id)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;
- (NSInteger)callPOSTWithUrl:(NSString *)url params:(id)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;
- (NSInteger)callPUTWithUrl:(NSString *)url params:(id)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;
- (NSInteger)callDeleteWithUrl:(NSString *)url params:(id)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;
- (NSInteger)callPatchWithUrl:(NSString *)url params:(id)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;
- (NSInteger)callUploadFileWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;
- (NSInteger)callDownloadWithUrl:(NSString *)url params:(NSDictionary *)params progress:(void (^)(NSProgress *progress))progress success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

- (void)cancelRequestWithRequestID:(NSNumber *)requestID;
- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList;
@end

NS_ASSUME_NONNULL_END
