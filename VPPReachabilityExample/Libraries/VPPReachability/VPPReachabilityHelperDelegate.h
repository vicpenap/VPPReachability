//
//  VPPReachabilityHelperDelegate.h
//  VPPLibraries
//
//  Created by Víctor on 21/10/11.
//  Copyright 2011 Víctor Pena Placer. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 
 This protocol defines a mandatory method that will notify with network
 status updates 
 */
@protocol VPPReachabilityHelperDelegate


@required
/** This method is called when the access to the hostname set in 
 VPPReachabilityHelper changes. 
 
 @param available is YES if the specified hostname is accesible, 
 otherwise is NO.
 */
- (void) internetAvailable:(BOOL)available;

@end
