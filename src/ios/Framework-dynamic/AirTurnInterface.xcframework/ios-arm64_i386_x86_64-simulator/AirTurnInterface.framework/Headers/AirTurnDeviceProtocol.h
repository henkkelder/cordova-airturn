//
//  AirTurnDevice.h
//  AirTurnInterface
//
//  Created by Nick Brook on 01/05/2020.
//  Copyright © 2020 Nick Brook. All rights reserved.
//

#import <AirTurnInterface/AirTurnTypes.h>

/// A protocol for specifying methods and properties common to keyboard and AirDirect AirTurns
@protocol AirTurnDeviceProtocol <NSObject>

/// Get an action for a given port
/// @param port The port
/// @param digital Determines if the digital or analog port should be fetched
- (nullable AirTurnAppAction)actionForPort:(AirTurnPort)port digital:(BOOL)digital;

/// Set an action for a given port
/// @param action The action to set
/// @param port The port
/// @param digital Determines if the digital or analog port should be fetched
- (void)setAction:(nullable AirTurnAppAction)action forPort:(AirTurnPort)port digital:(BOOL)digital;

@end
