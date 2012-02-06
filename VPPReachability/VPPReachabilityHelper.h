//
//  VPPReachabilityHelper.h
//  VPPLibraries
//
//  Created by Víctor on 21/10/11.

// 	Copyright (c) 2012 Víctor Pena Placer (@vicpenap)
// 	http://www.victorpena.es/
// 	
// 	
// 	Permission is hereby granted, free of charge, to any person obtaining a copy 
// 	of this software and associated documentation files (the "Software"), to deal
// 	in the Software without restriction, including without limitation the rights 
// 	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
// 	copies of the Software, and to permit persons to whom the Software is furnished
// 	to do so, subject to the following conditions:
// 	
// 	The above copyright notice and this permission notice shall be included in
// 	all copies or substantial portions of the Software.
// 	
// 	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// 	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
// 	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// 	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// 	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
// 	IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



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
