//
//  VPPReachabilityHelper.m
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


#import "VPPReachabilityHelper.h"
#import "SynthesizeSingleton.h"

@implementation VPPReachabilityHelper
@synthesize hostName;

SYNTHESIZE_SINGLETON_FOR_CLASS(VPPReachabilityHelper);

+ (VPPReachabilityHelper *) sharedInstance {
    BOOL mustInitialize = !sharedVPPReachabilityHelper;
    
    VPPReachabilityHelper *r = [VPPReachabilityHelper sharedVPPReachabilityHelper];
    if (mustInitialize) {
        r.hostName = kVPPReachbilityHelperHostname;
    }
    
    return r;

}

- (BOOL) isInternetAvailable {
	NetworkStatus internetStatus = [reachability_ currentReachabilityStatus];
	return ((internetStatus == ReachableViaWiFi) || (internetStatus == ReachableViaWWAN));
}

- (void) notifyDelegate:(id<VPPReachabilityHelperDelegate>)delegate {
	[delegate internetAvailable:[self isInternetAvailable]];
}

- (void) notifyAllDelegates {
	for (id<VPPReachabilityHelperDelegate> d in delegates_) {
		[self notifyDelegate:d];
	}
}


- (void) start {
    if (delegates_ != nil) {
        [delegates_ release];
    }
	delegates_ = [[NSMutableArray alloc] init];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];

	reachability_ = [[Reachability reachabilityWithHostName:self.hostName] retain];
	[reachability_ startNotifier];
}

//Called by Reachability whenever status changes.
- (void) reachabilityChanged:(NSNotification*)note
{
	[self notifyAllDelegates];
}

- (void) addDelegate:(id<VPPReachabilityHelperDelegate>)delegate {
    if (delegates_ == nil) {
        [self start];
    }
	if (![delegates_ containsObject:delegate]) {
		[delegates_ addObject:delegate];
		[self notifyDelegate:delegate];
	}
}
- (void) removeDelegate:(id<VPPReachabilityHelperDelegate>)delegate {
	[delegates_ removeObject:delegate];
}

@end
