#<a href="https://www.cnblogs.com/EasonJim/p/6277708.html">Jenkins卸载方法（Windows/Linux/MacOS）</a>
注意：

命令行运行的war包或者安装包，都会在命令行上提示了配置文件文件夹.jenkins，卸载时，注意一定要把这些一起删除。

比如Windows下用war包部署的命令行信息如下：



如上图所示，就是配置文件放置的位置。

一、Windows安装版本

这个最简单，在控制面板直接删除。

如果下载的是war包，先在任务管理器上停止jenkins的服务，在删除整个war包。

二、Linux下

以Ubuntu 12.04 LTS为例

命令如下：

复制代码
//服务
sudo apt-get remove jenkins

//安装包，注意这里如果不是ubuntu那就yum
sudo apt-get remove --auto-remove jenkins

//配置和数据
sudo apt-get purge jenkins

sudo apt-get purge --auto-remove jenkins
复制代码
http://installion.co.uk/ubuntu/precise/universe/j/jenkins/uninstall/index.html

http://stackoverflow.com/questions/38604715/how-can-i-remove-jenkins-completely-from-linux

三、Mac下

复制代码
//进入以下目录，双击运行
/Library/Application Support/Jenkins/Uninstall.command
//也可以这样运行
sh "/Library/Application Support/Jenkins/Uninstall.command"

//删除配置，这个可选
sudo rm -rf /var/root/.jenkins ~/.jenkins
sudo launchctl unload /Library/LaunchDaemons/org.jenkins-ci.plist
sudo rm /Library/LaunchDaemons/org.jenkins-ci.plist
sudo rm -rf /Applications/Jenkins "/Library/Application Support/Jenkins" /Library/Documentation/Jenkins
sudo rm -rf /Users/Shared/Jenkins
sudo dscl . -delete /Users/jenkins
sudo dscl . -delete /Groups/jenkins
sudo rm -f /etc/newsyslog.d/jenkins.conf
pkgutil --pkgs | grep 'org\.jenkins-ci\.' | xargs -n 1 sudo pkgutil --forget

//如果使用brew安装的，可以执行以下命令
brew uninstall jenkins
复制代码
http://stackoverflow.com/questions/11608996/how-to-uninstall-jenkins