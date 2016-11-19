//
//  ViewController.m
//  BLE
//
//  Created by user on 16/11/1.
//  Copyright © 2016年 zshuo. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "BLEInfo.h"
#import "BLETableViewCell.h"

#define WID ([[UIScreen mainScreen] bounds].size.width<[[UIScreen mainScreen] bounds].size.height?[[UIScreen mainScreen] bounds].size.width:[[UIScreen mainScreen] bounds].size.height)
#define  HEI ([[UIScreen mainScreen] bounds].size.width>[[UIScreen mainScreen] bounds].size.height?[[UIScreen mainScreen] bounds].size.width:[[UIScreen mainScreen] bounds].size.height)
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,CBCentralManagerDelegate,CBPeripheralDelegate>
{
    UISwitch *BLESwitch;//开关
    UIView *oldcontentView;//已连接view
    UILabel *contentLabel;//已连接Label
    UILabel *isContentLabel;//是否连接蓝牙Label
    UITableView *BLETableView;
    
    NSMutableArray *BLEdataArray;
    
    NSString *string;
    int count;
}
@property(nonatomic,strong)CBCentralManager *centerManager;//中央管理器
@property(nonatomic,strong)CBPeripheral *periperal;//外围设备

@property(nonatomic,strong)CBCharacteristic *characteristic;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    count = 0;
    UIView *navgationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WID, 64)];
    navgationView.backgroundColor = [UIColor colorWithRed:234/255.0 green:235/255.0 blue:236/255.0 alpha:1.0];
    [self.view addSubview:navgationView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(WID/2-100, 24, 200, 30)];
    titleLabel.text = @"BLE";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:24];
    [navgationView addSubview:titleLabel];
    
    UIButton *seekButton = [UIButton buttonWithType:UIButtonTypeCustom];
    seekButton.frame = CGRectMake(WID-80, 24, 60, 30);
    seekButton.layer.borderWidth = 1;
    seekButton.layer.borderColor = [[UIColor clearColor]CGColor];
    seekButton.layer.cornerRadius = 5;
    [seekButton setTitle:@"搜索" forState:UIControlStateNormal];
    [seekButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    seekButton.backgroundColor =[UIColor colorWithRed:24/255.0 green:174/255.0 blue:25/255.0 alpha:1.0];
    [seekButton addTarget:seekButton action:@selector(seekButton:) forControlEvents:UIControlEventTouchUpInside];
    [navgationView addSubview:seekButton];
    
    UILabel *bluetoothLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 74, 80, 35)];
    bluetoothLabel.text = @"蓝牙";
    bluetoothLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:bluetoothLabel];
    
    BLESwitch = [[UISwitch alloc]initWithFrame:CGRectMake(WID-70, 74, 50, 35)];
    BLESwitch.on = NO;
    [BLESwitch addTarget:self action:@selector(setBLEPower:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:BLESwitch];
    
    UIView *link1 = [[UIView alloc]initWithFrame:CGRectMake(10, 119, WID-20, 1)];
    link1.backgroundColor = [UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1.0];
    [self.view addSubview:link1];
    
    oldcontentView = [[UIView alloc]initWithFrame:CGRectMake(0, 120, WID, 55)];
    [self.view addSubview:oldcontentView];
    
    UILabel *oldcontentLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 100, 35)];
    oldcontentLabel.text = @"上次连接";
    oldcontentLabel.font = [UIFont systemFontOfSize:20];
    [oldcontentView addSubview:oldcontentLabel];
    
    contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(WID-200, 5, 180, 25)];
    contentLabel.text = @"当前未连接";
    contentLabel.font = [UIFont systemFontOfSize:16];
    contentLabel.textAlignment = NSTextAlignmentRight;
    [oldcontentView addSubview:contentLabel];
    
    isContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(WID-100, 30, 80, 20)];
    isContentLabel.text = @"未连接";
    isContentLabel.textAlignment = NSTextAlignmentRight;
    isContentLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.5];
    isContentLabel.font = [UIFont systemFontOfSize:13];
    [oldcontentView addSubview:isContentLabel];
    
    UIView *link2 = [[UIView alloc]initWithFrame:CGRectMake(10, 54, WID-20, 1)];
    link2.backgroundColor = [UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1.0];
    [oldcontentView addSubview:link2];
    
    BLETableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 175, WID, HEI-175)];
    BLETableView.dataSource = self;
    BLETableView.delegate = self;
    [self.view addSubview:BLETableView];
    
    BLEdataArray = [[NSMutableArray alloc]init];
    
    _centerManager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    
    
    //    for (int i=0; i<6; i++) {
    //        UIButton *click = [UIButton buttonWithType:UIButtonTypeCustom];
    //        click.frame = CGRectMake(40+i*120, HEI-200, 100, 45);
    //        click.tag = 100+i;
    //        [click setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
    //        click.backgroundColor = [UIColor redColor];
    //        [click addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    //        [self.view addSubview:click];
    //    }

}
//搜索事件
-(void)seekButton:(UIButton *)sender
{
    
}

//switch事件
-(void)setBLEPower:(UISwitch *)sender
{
    
}

-(void)click:(UIButton *)sender
{
    switch (sender.tag) {
        case 100:
            string =@"0xF10F1F00000000000050";
            break;
        case 101:
            string =@"0xF10F1F33333333333340";
            break;
        case 102:
            string =@"0xF10F1F55555555555530";
            break;
        case 103:
            string =@"0xF10F1F22222222222250";
            break;
        case 104:
            string =@"0xF10F1F44444444444410";
            break;
        case 105:
            string =@"0xF10F1F11111111111120";
            break;
            
        default:
            break;
    }
    
    NSLog(@"dianjil");
    // NSString *str = @"0xF10F1F00000000000050";
    
    
    NSData *mydata = [self convertHexStrToData:string];
    
    [_periperal writeValue:mydata forCharacteristic:_characteristic type:CBCharacteristicPropertyWrite];
    
}


#pragma mark - CBCentralManager代理方法
//中心服务器状态更新后
-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case CBCentralManagerStateUnknown:
            NSLog(@">>>CBCentralManagerStateUnknown-->未知状态");
            break;
        case CBCentralManagerStateResetting:
            NSLog(@">>>CBCentralManagerStateResetting-->正在重置状态");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@">>>CBCentralManagerStateUnsupported-->设备不支持状态");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@">>>CBCentralManagerStateUnauthorized-->设备未授权状态");
            break;
        case CBCentralManagerStatePoweredOff:
            NSLog(@">>>CBCentralManagerStatePoweredOff-->设备关闭状态");
            break;
            
        case CBCentralManagerStatePoweredOn:
            NSLog(@">>>CBCentralManagerStatePoweredOn-->设备打开状态");
            BLESwitch.on = YES;
            
            //搜索所有设备服务
            [_centerManager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@YES}];
            
            //扫描外围设备
            //[_centerManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:kServiceUUID]] options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@YES}];//搜索指定设备
            [_centerManager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@YES}];//搜索所有设备
            
            
            break;
        default:
            break;
    }
}


/**
 *  发现外围设备
 *
 *  @param central           中心设备
 *  @param peripheral        外围设备
 *  @param advertisementData 特征数据
 *  @param RSSI              信号质量（信号强度）
 */
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    
    BLEInfo *bleinfo = [[BLEInfo alloc]init];
    bleinfo.discoveredPeripheral = peripheral;
    bleinfo.rssi = RSSI;
    bleinfo.dataDic = advertisementData;
    
    [self addDevice:bleinfo];
    
    NSString *str = [NSString stringWithFormat:@"搜索到的设备: %@ rssi: %@, name:%@ UUID: %@ advertisementData: %@ ", peripheral, RSSI, peripheral.name , peripheral.identifier, advertisementData];
    NSLog(@"%@",str);
    
}

-(void)addDevice:(BLEInfo *)model
{
    for (BLEInfo *info in BLEdataArray) {
        if ([info.discoveredPeripheral.identifier isEqual:model.discoveredPeripheral.identifier]) {
            //        [peripheralArray removeObject:info];
            //        [peripheralArray addObject:model];
            return;
        }
    }
    
    
    [BLEdataArray addObject:model];
    [BLETableView reloadData];
    NSLog(@"%@",BLEdataArray);
    
}

//连接到外围设备
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"连接外围设备成功!");
    //停止搜索
    [_centerManager stopScan];
    
    _periperal = peripheral;
    _periperal.delegate = self;
    
    //扫描服务 nil所有服务
    [_periperal discoverServices:nil];
}
//连接外围设备失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"连接%@失败! 失败原因:%@",peripheral.name,[error localizedDescription]);
    
}
-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"断开连接error==%@",error);
    [_centerManager connectPeripheral:peripheral options:nil];
}

#pragma mark - CBPeripheral 代理方法
//外围设备寻找到服务后
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    NSLog(@"已发现可用服务...%@",peripheral.services);
    for (CBService *service in peripheral.services) {
        [peripheral discoverCharacteristics:nil forService:service];
    }
    
}
//外围设备寻找到特征后
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    NSLog(@"已发现可用特征...%@",service.characteristics);
    if (error) {
        NSLog(@"外围设备寻找特征过程中发生错误，错误信息：%@",error.localizedDescription);
        return;
        
    }
    
    for (CBCharacteristic *character in service.characteristics) {
        
        
        // 这是一个枚举类型的属性
        CBCharacteristicProperties properties = character.properties;
        //        if (properties & CBCharacteristicPropertyBroadcast) {
        //            //如果是广播特性
        //            NSLog(@"%@  广播",character);
        //        }
        //
        //        if (properties & CBCharacteristicPropertyRead) {
        //            //如果具备读特性，即可以读取特性的value
        //            NSLog(@"%@  可读",character);
        //           // [peripheral readValueForCharacteristic:character];
        //        }
        //
        //        if (properties & CBCharacteristicPropertyWriteWithoutResponse) {
        //            //如果具备写入值不需要响应的特性
        //            //这里保存这个可以写的特性，便于后面往这个特性中写数据
        //            //_characteristic = character;
        //            NSLog(@"%@  可写,没回调",character);
        //        }
        //
        //        if (properties & CBCharacteristicPropertyWrite) {
        //            //如果具备写入值的特性，这个应该会有一些响应
        //            NSLog(@"%@  可写,有回调",character);
        //        }
        //
        //        if (properties & CBCharacteristicPropertyNotify) {
        //            //如果具备通知的特性，无响应
        //           // [peripheral setNotifyValue:YES forCharacteristic:character];
        //            NSLog(@"%@  通知",character);
        //        }
        if ([character.UUID isEqual:[CBUUID UUIDWithString:@"FFE2"]]) {
            
            [peripheral setNotifyValue:YES forCharacteristic:character];
            
            
        }
        else if ([character.UUID isEqual:[CBUUID UUIDWithString:@"FFE1"]])
        {
            _characteristic = character;
            NSString *str = @"0x6C5A1234567891234567";
            
            NSData *mydata = [self convertHexStrToData:str];
            peripheral.delegate = self;
            [peripheral writeValue:mydata forCharacteristic:character type:CBCharacteristicPropertyWrite];
            
        }
   
    }
    
    
    
}

//16进制字符串转16进制数据
- (NSData *)convertHexStrToData:(NSString *)str {
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    
    NSLog(@"hexdata: %@", hexData);
    return hexData;
}

//16进制数据转16进制字符串
- (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}
//特征值被更新后
-(void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    //NSLog(@"chae==%@",characteristic);
    
    if (error) {
        NSLog(@"更新通知状态时发生错误，错误信息：%@",error.localizedDescription);
        return;
    }
    NSLog(@"收到特征更新通知...%@",characteristic);
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFE2"]]) {
        [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        
    }
    
    
    
}
//没有更新特征值后（调用readValueForCharacteristic:方法或者外围设备在订阅后更新特征值都会调用此代理方法）
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    NSLog(@"订阅成功后更新---%@",characteristic);
    if (error) {
        NSLog(@"更新特征值时发生错误，错误信息：charact--%@ error--%@",characteristic.UUID,error.localizedDescription);
        
        return;
    }
    
    NSLog(@"介绍数据==%@",characteristic.value);
    
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFE2"]]) {
        NSLog(@"飞飞");
        NSString *str = [self convertDataToHexStr:characteristic.value];
        NSLog(@"str==%@",str);
        
        if ([str isEqualToString:@"f2023f01"]) {
            NSLog(@"验证成功");
            
            
        }
    }
    
    
}

//写入特征值回调
-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    count ++;
    if (error) {
        NSLog(@"写入特征值失败: %@",[error localizedDescription]);
    }else{
        NSLog(@"写入成功  回调值%@",characteristic);
        
        if (count == 1) {
            NSString *str = @"F10F1F00000000000010";
            
            NSData *mydata = [NSData dataWithBytes:str.UTF8String length:str.length];
            
            [peripheral writeValue:mydata forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
        }
        
        //[peripheral setNotifyValue:YES forCharacteristic:characteristic];
        
    }
}
-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error
{
    if (error) {
        NSLog(@"写入失败error%@",[error localizedDescription]);
        return;
    }
    NSLog(@"接收到数据--desciptor==%@",descriptor);
    
}
#pragma mark - UITableViewDelegate&UITableViewDataSource"
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return BLEdataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusedID = @"reusedID";
    
    BLETableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    
    if (cell == nil) {
        cell = [[BLETableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedID];
    }
    BLEInfo *model = BLEdataArray[indexPath.row];
    cell.namelabel.text = [NSString stringWithFormat:@"%@",model.discoveredPeripheral.name];
    cell.uuidlabel.text = [NSString stringWithFormat:@"%@",model.discoveredPeripheral.identifier];
    cell.rssilabel.text = [NSString stringWithFormat:@"%@",model.rssi];
    cell.isconnectlabel.text = @"未连接";
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BLETableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    BLEInfo *model = BLEdataArray[indexPath.row];
    [_centerManager connectPeripheral:model.discoveredPeripheral options:nil];
    //_periperal = model.discoveredPeripheral;
    cell.isconnectlabel.text = @"已连接";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
