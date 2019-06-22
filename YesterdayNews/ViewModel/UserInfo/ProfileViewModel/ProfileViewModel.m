//
//  ProfileViewModel.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/6/1.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "ProfileViewModel.h"
#import "YBImageBrowserTipView.h"
#import "User.h"
#import <AFNetworking.h>

@interface ProfileViewModel()

@end

@implementation ProfileViewModel

- (instancetype)init
{
    self = [super init];
    if(self){
        [self refreshData];
        
    }
    return self;
}

- (void)refreshData
{
    // post request to get usericon url
    [self getUserIconwithUserName: [[User getInstance] getUsername]];
    // other property like username and so on
    self.username = [[User getInstance] getUsername];
    self.like = @"1";
    self.following = @"2";
    self.follower = @"3";
}

/* 更新头像 */
- (void)updateIconwithIconData:(NSData *)iconData withUserName:(NSString *)name
{
    // post request to change user icon
    // 查看是否已登陆
    if(![User getInstance].hasLogin) {
        NSLog(@"[LOG] you didn't login");
        [[UIApplication sharedApplication].keyWindow yb_showForkTipView:@"请先登录"];
        return;
    }
    NSString *url = @"http://localhost:3000/user/avatar";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求体和响应体为JSON
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    // 添加cookie
    NSString *cookieStr = [NSString stringWithFormat:@"Bearer %@", [[User getInstance] getToken]];
    [manager.requestSerializer setValue: cookieStr forHTTPHeaderField:@"Authorization"];
    // 使用表单提交
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    // 发起post请求
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:iconData name:@"file" fileName:@"jmf.png" mimeType:@"image/png"];
        NSData *username = [name dataUsingEncoding:NSUTF8StringEncoding];
        [formData appendPartWithFormData:username name:@"username"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 修改头像成功
        NSString *avatar = responseObject[@"avatar"];
        self.userIconUrl = [[@"http://localhost:3000/image/avatar/" stringByAppendingString:avatar] stringByAppendingString:@".png"];
        NSLog(@"[LOG] change icon url to :%@", self.userIconUrl);
        [[UIApplication sharedApplication].keyWindow yb_showHookTipView:@"头像修改成功"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication].keyWindow yb_showHookTipView:@"头像修改失败"];
    }];
}

/* 获取头像 */
- (void)getUserIconwithUserName:(NSString *)username
{
    // AFNetManager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求体和响应体为JSON
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    // 添加cookie-token
    NSString *cookieStr = [NSString stringWithFormat:@"Bearer %@", [[User getInstance] getToken]];
    [manager.requestSerializer setValue: cookieStr forHTTPHeaderField:@"Authorization"];
    // 设置url
    NSString *url = [NSString stringWithFormat: @"http://localhost:3000/user/info/%@", username];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 成功回调
        NSDictionary *userInfoDic = responseObject[@"username"];
        id avatar = [userInfoDic objectForKey:@"avatar"];
        // 没有设置过头像
        if(avatar == nil || !avatar || avatar == [NSNull null]) {
            self.userIconUrl = @"http://localhost:3000/image/avatar/MTc2MjI0NjU3MTIwMDE4MDIxMDU=.png";
        }
        // 设置过头像
        else {
            self.userIconUrl = [NSString stringWithFormat:@"http://localhost:3000/image/avatar/%@.png", username];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 失败回调
        NSLog(@"[LOG] get usericon fail");
    }];
}

@end
