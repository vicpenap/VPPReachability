//
//  VPPReachabilityHelper.h
//  VPPLibraries
//
//  Created by Víctor on 21/10/11.
//  Copyright 2011 Víctor Pena Placer. All rights reserved.
//


// this is the host used to set the hostName prop until you modified it in 
// runtime. Change it according to the needs of your app
#define kVPPReachbilityHelperHostname @"www.victorpena.es"

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "VPPReachabilityHelperDelegate.h"

/**
 VPPReachability Library simplifies the access status to a given hostname. It 
 allows two ways of use:
 
 - Direct queries.
 - Delegating.
 
 First of all, you should start the helper, by doing something like 
 `[[VPPReachabilityHelper sharedInstance] start];`. The helper will immediately
 start receiving network status updates.
 
 ### Direct queries
 Once the helper is started, each call to isInternetAvailable will return the 
 current status. 
 
 ### Delegating
 If you want to be notified each time the access status changes, use this method.
 Implement VPPReachabilityHelperDelegate and add your class as delegate with
 addDelegate:.
 
 @warning Remember to update hostName before starting the helper.
 
 @warning This library uses the included Reachability classes made by Apple Inc, the included SynthesizeSingleton library made by Matt Gallagher and the
SystemConfiguration framework.
 */




@interface VPPReachabilityHelper : NSObject {
@private
	Reachability *reachability_;
	NSMutableArray *delegates_;
}


/** ---
 @name Helper properties
 */

/** This is the host name used to check network access.
 
 By default its value will be the one defined in kVPPReachbilityHelperHostname.
 You should rather modify that constant, or this property in runtime, **always**
 before calling start.
 */
@property (nonatomic, retain) NSString *hostName;


/** ---
 @name Accessing the helper
 */
/** Returns the singleton instance */
+ (VPPReachabilityHelper*) sharedInstance;

/** ---
 @name Managing helper state
 */
/// Starts receiving internet status notifications
- (void) start;

/// Returns whether access to the hostname is available or not
@property (nonatomic, readonly, getter = isInternetAvailable) BOOL internetAvailable;

/** ---
 @name Managing delegates
 */

/** Adds a new delegate.
 
 Each time internet status changes, all delegates are notified.
 
 Furthermore, delegate will be notified with the last information available. 
 
 @warning **Important** if the helper was not previously started, calling this 
 method will call start too. */
- (void) addDelegate:(id<VPPReachabilityHelperDelegate>)delegate;

/// Removes a listener
- (void) removeDelegate:(id<VPPReachabilityHelperDelegate>)delegate;


@end
