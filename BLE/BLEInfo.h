//
//  BLEInfo.h
//  BT
//
//  Created by user on 16/1/12.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface BLEInfo : NSObject

@property (nonatomic ,strong)CBPeripheral *discoveredPeripheral;
@property (nonatomic ,strong)NSNumber *rssi;
@property (nonatomic ,strong)NSDictionary *dataDic;

@end
