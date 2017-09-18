#IOS常用语句
##初始化
###在AppDelegate.m里初始化window:
```#import "AppDelegate.h"

    @interface AppDelegate ()

    @end

    @implementation AppDelegate
    - (void)dealloc
    {
    [_window release];                  //释放window
    [super dealloc];
    }
#pragma make -- app启动完成走这个方法
  - (BOOL)application:(UIApplication *)application       didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

#//初始化Window对象
self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
#//设置颜色:
self.window.backgroundColor = [UIColor whiteColor];
#//让window可见:
[self.window makeKeyAndVisible];
#//为window创建根视图控制器:
UIViewController *vc = [[UIViewController alloc] init];
#//将vc设置为window的根视图控制器:
self.window.rootViewController = vc;

```

###UILable : (标签控件的常用属性)
```
//初始化标签控件:
     UILabel *label = [[UILabel alloc]  
     initWithFrame:CGRectMake(100, 200, 175, 100)];

//设置背景颜色:
label.backgroundColor = [UIColor grayColor];
//设置label要显示的文字:
label.text = @"Hello student!";
//设置文字对齐方式:(左中右三种 0.1.2)
label.textAlignment = NSTextAlignmentCenter;    //给1也行
//设置字体颜色:
label.textColor = [UIColor yellowColor];
//设置字体和大小:
//    label.font = [UIFont fontWithName:@"Zapfino" size:20];
  //设置显示的行数(换行):(0表示自动去换行)
label.numberOfLines = 0;
//设置断行模式:
 label.lineBreakMode = NSLineBreakByWordWrapping;   //按 
 字母用Char换Word

```

###UITextField :(文本框的常用属性)
```//初始化文本框:
 UITextField *textfield = [[UITextField alloc] 
initWithFrame:CGRectMake(100, 100, 175, 50)];

//设置提示文字:
textfield.placeholder = @"请输入密码:";

//设置边框样式:
textfield.borderStyle = UITextBorderStyleRoundedRect;

//设置边框宽度和颜色:
textfield.layer.borderWidth = 5.0;
textfield.layer.borderColor = [UIColor blueColor].CGColor

//设置文本颜色:
textfield.textColor = [UIColor redColor];

//设置文本对齐方式:(0.1.2  左 中 右)
textfield.textAlignment = 0;

//设置字体:
textfield.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];    
 #注意字体的书写一定要标准

//是否允许编辑:
textfield.enabled = YES;  //(NO 不可编辑,默认为yes)

//开始输入时清空之前的内容:
textfield.clearsOnBeginEditing = NO;    //(NO就清空了,默认为 YES)

//设置密码输入模式(小点):
textfield.secureTextEntry = YES;      //no为正常输入

//设置键盘的样式:
 //    textfield.keyboardType = UIKeyboardTypeDefault;     
//  比如只能输入数字textfield.keyboardType =   UIKeyboardTypeNumberPad;

//设置键盘右下角按钮内容:
textfield.returnKeyType = UIReturnKeyNext;  //有很多种
```
###UIButton :(按钮的常用属性)
```//初始化按钮:
 UIButton *button = [UIButton   buttonWithType:UIButtonTypeCustom];
//设置位子
button.frame = CGRectMake(100, 100, 175, 64);
//设置按钮文字:
[button setTitle:@"我是按钮" forState:UIControlStateNormal];

 //设置边框:
 //    button.layer.borderWidth = 2.0;

 //设置边框颜色:
//    button.layer.borderColor= [UIColor greenColor].CGColor;

//设置背景颜色
 // button.backgroundColor = [UIColor blackColor];

//设置圆角:
//    button.layer.cornerRadius = 10;

  //设置背景图:
 //    [button setBackgroundImage:[UIImage    
 imageNamed:@"1.jpg"] forState:UIControlStateNormal];


  //设置前景图
 //    [button setImage:[UIImage imageNamed:@"666.jpg"] 
 forState:UIControlStateNormal];
//    UIImage *frontImage = [button  
 imageForState:UIControlStateNormal];
//    NSLog(@"%@", frontImage);


  //    //设置按钮字体颜色:
  [button setTitleColor:[UIColor redColor] 
 forState:UIControlStateNormal];

//修改字体大小以及字体:
//修改字体大小以及字体:
   button.titleLabel.font = [UIFont fontWithName:@"Zapfino" 
size:20];
//获取字体颜色:
   UIColor *wordColor = [button  
titleColorForState:UIControlStateNormal];
NSLog(@"%@", wordColor);

//为按钮button添加点击事件:
[button addTarget:self action:@selector(didClickedDogButton:) forControlEvents:UIControlEventTouchUpInside];

//为按钮移除点击事件
[button removeTarget:self action:@selector(didClickedDogButton:) forControlEvents:UIControlEventTouchUpInside];

//最后将按钮添加到window上
 [view addSubview:button];

#注意:按钮是系统自动释放 不用再release ,否则将会过度释放
```
###UIImageView :(图片显示控件的常用属性)
```//创建UIImageView对象:
UIImageView *imageView = [[UIImageView   
alloc]initWithFrame:self.window.frame];
//设置颜色:
//    imageView.backgroundColor = [UIColor orangeColor];
//为imageView设置图片:
//    imageView.image = [UIImage imageNamed:@"1.jpg"];
```
作者：西西哈哈
链接：http://www.jianshu.com/p/df3db78e6c26
來源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

