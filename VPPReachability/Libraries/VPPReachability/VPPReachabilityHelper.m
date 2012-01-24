//
//  VPPReachabilityHelper.m
//  VPPLibraries
//
//  Created by Víctor on 21/10/11.
//  Copyright 2011 Víctor Pena Placer. All rights reserved.
//

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
