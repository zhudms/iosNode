/********* LinkfaceIDOCRPlugin.m Cordova Plugin Implementation *******/

#import "CordovaLinkfaceOCRID.h"
#import "STIDCard.h"
#import "STAPIAccountInfo.h"
#import "LocalDef.h"
#import "STIDCardScanner.h"


@implementation CordovaLinkfaceOCRID
    @synthesize viewController,commandDelegate,scanVC;
    //    NSDate *senddate;
    //    NSInteger time1;
    UIWindow *window;
    
- (void)startOCRID:(CDVInvokedUrlCommand*)command
    {
        @autoreleasepool {
            NSLog(@"into native");
            
            NSInteger echo =[[command.arguments objectAtIndex:0] integerValue];
            
            if(echo!=0){
                
                //    NSInteger time1;
                self.command=command;
                [self prepareScan];
                [self toScan:echo];
                
            }else{
                [self sendOCRIDResult];
                
            }
        }
        
        
        
        
    }
    
-(void)prepareScan{
    
    window = [UIApplication sharedApplication].delegate.window;
    
    [self setOCRID];
    //    _resultVC=[[ResultViewController alloc]init];
    //    _resultVC.dicRecogResult = [[NSMutableDictionary alloc] init];
    //    _resultVC.arrKeys = [[NSMutableArray alloc] init];
    //声明权限
}
    
    
-(void)toScan:(NSInteger) type{
    //    senddate = [NSDate date];
    //    time1=[senddate timeIntervalSince1970];
    ////    NSLog(@"current time1=@%ld",time1);
    if (type==scanFront) {
        
        //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{//获得主线程权限后再执行？（界面打开需要4s左右，不加1s左右）
        _type = kResultTypeFront;
        
        [self scanFront];
        
        //        });
        NSLog(@"get type@%@",@"1");
        
    }else if(type==scanBack){
        _type = kResultTypeBack;
        [self scanBack];
        
        NSLog(@"get type@%@",@"2");
        
    }else if(type==scanBoth){
        _type = kResultTypeScanFrontAndBack;
        [self scanFrontAndBack];
        NSLog(@"get type@%@",@"0");
        
    }    else{
        NSLog(@"equals fail %@",@"a");
        
    }
    
    
}
    
-(void)sendOCRIDResult{
    //    CDVPluginResult* pluginResult = nil;
    //
    //    // if (echo != nil && [echo length] > 0) {
    //    //     pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
    //    // } else {
    //    //     pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    //    // }
    //    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.command.callbackId];
    
}
    
    
-(void)setOCRID{
    [STIDCard setupTheAPIAccountWithID:ACCOUNT_API_ID andWithSecret:ACCOUNT_API_SECRET];
}
    
- (void)scanFront{
    
    //    self.lbError.hidden = YES;
    
    scanVC =[[STIDCardScanner alloc] initWithOrientation:
             AVCaptureVideoOrientationPortrait];
    scanVC.delegate = self;
    //            scanVC.snapshotSeconds = 1;扫描间隔
    /**
     *  以下调用将会把扫描界面的蒙版变成透明度为0.6的#736357
     */
    UIColor *maskColor = [UIColor colorWithRed:115.0/255.0 green:99.0/255.0 blue:87.0/255.0 alpha:1.0];
    [scanVC setTheMaskLayerColor:maskColor andAlpha:0.6];
    /**
     *  以下调用将会把扫描界面的框线变为#534741
     */
    UIColor *lineColor = [UIColor colorWithRed:83.0/255.0 green:71.0/255.0 blue:65.0/255.0 alpha:1.0];
    [scanVC setTheScanLineColor: lineColor];
    scanVC.cardMode = kIDCardFrontal;
    [scanVC moveWindowVerticalFromCenterWithDelta:-50];
    
    [self showScanPage:scanVC];
    
}
    
    
    
    
- (void)scanBack{
    self.lbError.hidden = YES;
    scanVC = [[STIDCardScanner alloc] initWithOrientation:AVCaptureVideoOrientationPortrait];
    scanVC.delegate = self;
    
    scanVC.cardMode = kIDCardBack;
    
    [self showScanPage:scanVC];
}
    
- (void)scanFrontAndBack{
    _scanFrontAndBackVC = [[STIDCardScanner alloc] initWithOrientation:AVCaptureVideoOrientationPortrait];
    _scanFrontAndBackVC.delegate = self;
    _scanFrontAndBackVC.cardMode = kIDCardFrontal;
    
    
    [self showScanPage:_scanFrontAndBackVC];
}
    
-(void)showScanPage:(STIDCardScanner *)scanVC{
    if (scanVC!=nil) {
        [window.rootViewController presentViewController:scanVC animated:YES completion:nil];
    }else{
        NSLog(@"scanVC error");
    }
    
    //        测试耗时（使用当前类型只能精确到s，意义不大）
    //    senddate = [NSDate date];
    //NSInteger time2=[senddate timeIntervalSince1970];
    //     NSLog(@"current time2=@%ld",time2);
    //     NSLog(@"current time split=@%ld",time2-time1);
}
    
-(void)hideScanPage{
    if (scanVC!=nil) {
        [window.rootViewController dismissViewControllerAnimated:true completion:nil];
        
    }else{
        NSLog(@"scanVC error");
    }
}
    
- (void)getCardResult:(STIDCard *)idcard {
    //在这里处理SDK返回的身份证信息，具体可见示例代码
    NSLog(@"获取了getCardResult");
    
    NSLog(@"%s","getResult");
    NSLog(@"name=@%@,sex=@%@,minzu=@%@,year=@%@,mouth=@%@,day=@%@,adress=@%@,ID=@%@",idcard.strName,
          idcard.strSex,idcard.strNation,idcard.strYear,idcard.strMonth,idcard.strDay,idcard.strAddress,idcard.strID);
    
    NSLog(@"签发=@%@,有效期=@%@",idcard.strAuthority,
          idcard.strValidity);
    //    if(idcard.imgOriginCaptured!=nil){
    UIImageView* ima=[[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 200, 100)];
    ima.image=idcard.imgCardDetected;
//    [self.view addSubview:ima];
//    [self.view bringSubviewToFront:ima];
    
    NSString *path_document = NSHomeDirectory();
    //设置一个图片的存储路径
    NSString *imagePath = [path_document stringByAppendingString:@"/Documents/pic.png"];
    //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
    [UIImagePNGRepresentation(idcard.imgCardDetected) writeToFile:imagePath atomically:YES];
    
    
    if (_type==kResultTypeFront) {
        
    }else if(_type==kResultTypeBack){
        
    }else if (_type==kResultTypeScanFrontAndBack){
        
    }else{
    }
    
}
    
-(void)didCancel{
    [self  hideScanPage];
    NSLog(@"did cancel");
}
    
-(void) getSnapshot:(UIImage *)imgSnap{
    NSLog(@"获取了一次屏幕快照");
}
    
    
- (void)getError:(STIDCardErrorCode)errorCode {
    //在这里处理调用失败的代码，具体见展示demo
    NSLog(@"获取了getError  errorCode=%ld",errorCode);

}
    
    
-(NSString*)getErrorMessage:(STIDCardErrorCode)errorCode{
    NSString* message;
    switch (errorCode) {
        
        [self getErrorMessage:errorCode];
        case kIDCardAPIAcountFailed:
        message= @"API账户信息错误：\n请检查您的API id和API secret 信息";
        break;
        case kIDCardHandleInitFailed:
        
        message=  @"算法SDK初始化失败：\n可能是模型路径错误，SDK权限过期，包名绑定错误";
        break;
        
        case kIDCardCameraAuthorizationFailed:
        message = @"相机授权错误：\n请去设置->隐私->相机中修改授权";
        //            dispatch_async(dispatch_get_main_queue(), ^{
        //                [self dismissViewControllerAnimated:YES completion:nil];
        //                self.lbError.hidden = NO;
        //            });
        //        }
        break;
        default:
        message=@"get error message fail";
        break;
    }
    
    
    
}
    @end
