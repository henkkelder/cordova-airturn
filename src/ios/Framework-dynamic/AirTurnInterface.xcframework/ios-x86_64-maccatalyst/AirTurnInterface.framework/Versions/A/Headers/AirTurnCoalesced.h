//
//  AirTurnCoalesced.h
//  AirTurnInterface
//
//  Created by Nick Brook on 05/07/2020.
//  Copyright © 2020 Nick Brook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AirTurnInterface/AirTurnTypes.h>

/**
 A class representing all connected AirTurns (keyboard and AirDirect) merged
 */
@interface AirTurnCoalesced: NSObject

/**
 `YES` if any AirTurn is connected
 */
@property(nonatomic, readonly) BOOL isConnected;

/**
 The number of digital ports available on all connected AirTurns
 */
@property(nonatomic, readonly) NSInteger numberOfDigitalPortsAvailable;

/**
 Indicates if a specific digital port is available on any connected AirTurn
 
 @param port The port
 @return YES if the port is available
 */
- (BOOL)digitalPortAvailable:(AirTurnPort)port;

/**
 Get the port state for a given port on any AirTurn in which it is pressed
 @param port The port
 @return The port state
 */
- (AirTurnPortState)digitalPortState:(AirTurnPort)port;

@end
