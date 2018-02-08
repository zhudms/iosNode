#Jenkins(for mac)相关参数配置文件及位置说明
原创 2015年07月15日 10:51:56 1473

Jenkins参数设置（端口，内存分配情况）

我在是mac上用pkg文件安装jenkins的。默认情况下



/Library/Preferences/路径下的  org.jenkins-ci.plist  文件 是Jenkins相关参数配置文件。可以通过修改该文件来修改系统参数。



设置默认端口

 sudo defaults write /Library/Preferences/org.jenkins-ci httpPort ‘9999‘

读取设置

defaults read /Library/Preferences/org.jenkins-ci



Jenkins启动运行相关配置

/Library/LaunchDaemons/路径下的 org.jenkins-ci.plist 文件 是Jenkins运行相关的配置。例如 运行日志（日志文件路径）  是否创建session 是否启动运行 等



日志文件

/var/log/jenkins 路径下的Jenkins.log 通过查看该文件来了解Jenkins的运行状态


