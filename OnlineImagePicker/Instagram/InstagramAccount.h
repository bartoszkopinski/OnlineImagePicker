//
//  InstagramAccount.h
//  OnlineImagePicker
//
//  Created by David Gileadi on 9/29/14.
//  Copyright (c) 2014 David Gileadi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <InstagramKit/InstagramKit.h>
#import "OnlineImageAccountsController.h"

/**
 * Supports user authentication for Instagram.
 */
@interface InstagramAccount : NSObject<OnlineImageAccount>

/** The single shared instance of this class. */
+(InstagramAccount *) sharedInstance;

@end
