//
//  ViewModelManager.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/6/1.
//  Copyright © 2019 Cookieschen. All rights reserved.
//
#import "ViewModelManager.h"

@interface ViewModelManager()

@property(nonatomic, strong) NSMutableDictionary *viewModels;

@end

@implementation ViewModelManager
static ViewModelManager *manager = nil;

+ (instancetype)getManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(manager == nil){
            manager = [[ViewModelManager alloc] init];
        }
    });
    return manager;
};

- (instancetype)init {
    self = [super init];
    if(self){
        self.viewModels = [[NSMutableDictionary alloc] init];
    }
    return self;
};

- (id)getViewModel:(NSString *)name {
    if([self.viewModels objectForKey: name] == nil){
        [self.viewModels setObject:[[NSClassFromString(name) alloc] init] forKey:name];
    }
    return [self.viewModels objectForKey: name];
}

@end
