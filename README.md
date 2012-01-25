VPPReachability Library for iOS simplifies the access status to a given hostname. 
It allows two ways of use:
 
 - Direct queries.
 - Delegating.

## Direct queries

Once the helper is started, each call to isInternetAvailable will return the 
current status. 
 
## Delegating

If you want to be notified each time the access status changes, use this method.
Implement VPPReachabilityHelperDelegate and add your class as delegate.

This project contains a sample application using it. Just open the project in 
XCode, build it and run it. 

The library source code is located at [VPPReachability/Libraries/VPPReachability](https://github.com/vicpenap/VPPReachability/tree/master/VPPReachability/Libraries/VPPReachability).

For full documentation check out 
http://vicpenap.github.com/VPPReachability
