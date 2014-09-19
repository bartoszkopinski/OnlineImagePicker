//
//  InstagramUserImagesSource.m
//  OnlineImagePicker
//
//  Created by David Gileadi on 9/8/14.
//  Copyright (c) 2014 David Gileadi. All rights reserved.
//

#import "InstagramUserImagesSource.h"
#import <InstagramKit/InstagramKit.h>

@interface InstagramUserImagesSource()
@property(nonatomic) InstagramPaginationInfo *currentPaginationInfo;
@end

@implementation InstagramUserImagesSource

/** This image source is only available if a user has been authenticated to Instagram. */
-(BOOL) isAvailable {
    return [InstagramEngine sharedEngine].accessToken != nil;
}

-(void) loadImagesWithSuccess:(OnlineImageSourceResultsBlock)onSuccess orFailure:(OnlineImageSourceFailureBlock)onFailure {
    self.currentPaginationInfo = nil;
    [self nextImagesWithSuccess:onSuccess orFailure:onFailure];
}

-(void) nextImagesWithSuccess:(OnlineImageSourceResultsBlock)onSuccess orFailure:(OnlineImageSourceFailureBlock)onFailure {
    [[InstagramEngine sharedEngine] getSelfFeedWithCount:self.pageSize maxId:self.currentPaginationInfo.nextMaxId success:^(NSArray *media, InstagramPaginationInfo *paginationInfo) {
        self.currentPaginationInfo = paginationInfo;
        NSMutableArray *results = [NSMutableArray arrayWithCapacity:media.count];
        for (InstagramMedia *media in media)
            if (!media.isVideo)
                [results addObject:[[InstagramImageInfo alloc] initWithMedia:media];
        onSuccess(results);
    } failure:^(NSError *error) {
        onFailure(error);
    }];
}

@end