#IOS版本升级
##copy自<http://blog.csdn.net/blog_t/article/details/53812958>
从iOS8系统开始，用户可以在设置里面设置在WiFi环境下，自动更新安装的App。此功能大大方便了用户，但是一些用户没有开启此项功能，因此还是需要在程序里面提示用户的

1. 方法一：在服务器接口约定对应的数据，这样，服务器直接传递信息，提示用户有新版本，可以去商店升级 

	注意：这个方法是有毛病的，若您的App还没审核通过，而移动端后台数据已经更新，后台给您返回的版本号是最新的版本号，老版本会提示用户升级，但是用户点击升级后跳转至AppStore却发现App还未更新

2. 方法二：检测手机上安装的App版本，然后跟App Store上App的版本信息联合来判断（目前最常用的方法）

+ 步骤一：获取当前运行的版本信息，通过info.plist文件的bundle version中获取

		NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];  //当前版本号
		NSString *currentVersion = 
		[infoDic objectForKey:@"CFBundleShortVersionString"];  
		
+ 步骤二：获取AppStore中的App版本信息

		-(void)judgeAppVersion{　//AppStore访问地址（重点）  
    	NSString *urlStr = 
    	@"https://itunes.apple.com//lookup?id=AppID";  
   		 NSURL *url = [NSURL URLWithString:urlStr];  
   		 NSURLRequest *req =
   		  [NSURLRequest requestWithURL:url];  
   		 [NSURLConnection connectionWithRequest:
   		 req delegate:self];  
		}  
		
		#pragma mark - NSURLConnectionDataDelegate  
		-(void)connection:(NSURLConnection *)connection 
		didReceiveData:(NSData *)data{  
   		 NSError *error;<br>　　//解析  
   		 NSDictionary *appInfo = 
   		 [NSJSONSerialization JSONObjectWithData:data
   		 options:NSJSONReadingAllowFragments error:&error];  
   		 NSArray *infoContent = [appInfo objectForKey:@"results"];  
   		 //最新版本号  
    	NSString *version = [[infoContent objectAtIndex:0] objectForKey:@"version"];  
    	//应用程序介绍网址（用户升级跳转URL）  
   		 NSString *trackViewUrl = [[infoContent objectAtIndex:0] objectForKey:@"trackViewUrl"];  
		}  
		
+ 解析从AppStore获取到的App信息(这里就只介绍重点使用到的信息)

		[objc] view plain copy
		minimumOsVersion = "8.0";         //App所支持的最低iOS系统  
		fileSizeBytes = ;                 //应用的大小  
		releaseDate = "";                 //发布时间  
		trackCensoredName = "";           //审查名称        
		trackContentRating = "";          //评级   
		trackId = ;                       //应用程序ID  
		trackName = "";                   //应用程序名称  
		trackViewUrl = "";                //应用程序介绍网址  
		version = "4.0.3";                //版本号  

+ 步骤三：判断当前线上App的版本号与所使用的App版本号是否一致


		if (![version isEqualToString:currentVersion]) {  
		        [SimplifyAlertView alertWithTitle:@"检查更新：i店" message:[NSString stringWithFormat:@"发现新版本(%@),是否升级",version] operationResult:^(NSInteger selectedIndex) {  
		            if (selectedIndex == 1) {  
		                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:trackViewUrl]];  
		            }  
		        } cancelButtonTitle:@"取消" otherButtonTitles:@"升级", nil nil];  
		 }  
