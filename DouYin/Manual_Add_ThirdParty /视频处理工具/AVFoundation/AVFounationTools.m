//
//  AVFounationTools.m
//  Shooting
//
//  Created by Jobs on 2020/8/24.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "AVFounationTools.h"

@interface AVFounationTools ()

@property(nonatomic,strong)NSArray *devices;
@property(nonatomic,strong)NSArray <AVCaptureInput *>*inputs;
@property(nonatomic,strong)NSArray *connections;
@property(nonatomic,strong)AVCaptureMultiCamSession *session;

@end

@implementation AVFounationTools

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

static AVFounationTools *avfounationTools = nil;
+(AVFounationTools *)sharedInstance{
    @synchronized(self){
        if (!avfounationTools) {
            avfounationTools = AVFounationTools.new;
        }
    }return avfounationTools;
}

-(instancetype)init{
    if (self = [super init]) {
        [self initSession];
        [self initDevices];
        [self initInputs];
        [self initLayersAndConnections];
        [self refeshCamera];
        [self LIVE];
    }return self;
}

- (AVCaptureDeviceInput *)inputWithCaptureDevice:(AVCaptureDevice *)device {
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:NULL];
    return input;
}

- (void)initSession {
    self.session = [[AVCaptureMultiCamSession alloc] init];
}

- (void)initDevices {
    NSArray *back = @[AVCaptureDeviceTypeBuiltInTelephotoCamera,
                      AVCaptureDeviceTypeBuiltInWideAngleCamera,
                      AVCaptureDeviceTypeBuiltInUltraWideCamera];
    
    AVCaptureDeviceDiscoverySession *backDiscoverySession = [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:back mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionBack];
    
    NSArray *front = @[AVCaptureDeviceTypeBuiltInWideAngleCamera];
    AVCaptureDeviceDiscoverySession *frontDiscoverySession = [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:front mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionFront];
    
    NSMutableArray *mutArr = [backDiscoverySession.devices mutableCopy];
    [mutArr addObjectsFromArray:frontDiscoverySession.devices];
    
    self.devices = [mutArr copy];
}

- (void)initInputs {
    AVCaptureInput *input1 = [self inputWithCaptureDevice:self.devices[0]];
    self.inputs = @[input1];
}

- (void)initLayersAndConnections {
    if (self.vc) {
        AVCaptureVideoPreviewLayer *previewLayer1 = [[AVCaptureVideoPreviewLayer alloc] initWithSessionWithNoConnection:self.session];
        previewLayer1.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        previewLayer1.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [self.vc.view.layer addSublayer:previewLayer1];
        AVCaptureConnection *c1 = [AVCaptureConnection connectionWithInputPort:self.inputs[0].ports.firstObject videoPreviewLayer:previewLayer1];
        self.connections = @[c1];
    }else{
        NSLog(@"抛异常");
    }
}

- (void)refeshCamera {
    [self refreshInputs];
    [self refreshConnections];
}

- (void)refreshInputs {
    NSArray *addedInputs = [self.session inputs];
    [self.session beginConfiguration];
    if (addedInputs.count > 0) {
        for (AVCaptureInput *input in addedInputs) {
            [self.session removeInput:input];
        }
    }
    for (AVCaptureInput *input in self.inputs) {
        if ([self.session canAddInput:input]) {
            [self.session addInputWithNoConnections:input];
        }
    }
    [self.session commitConfiguration];
}

- (void)refreshConnections {
    NSArray *addedConnections = [self.session connections];
    [self.session beginConfiguration];
    
    if (addedConnections.count > 0) {
        for (AVCaptureConnection *connection in addedConnections) {
            [self.session removeConnection:connection];
        }
    }
    for (AVCaptureConnection *connection in self.connections) {
        if ([self.session canAddConnection:connection]) {
            [self.session addConnection:connection];
        }
    }
    [self.session commitConfiguration];
}

-(void)LIVE{
     [self.session startRunning];
}

@end
