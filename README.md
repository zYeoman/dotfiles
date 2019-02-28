# Dotfiles

```
├── dual
│   ├── gitconfig
│   ├── gitignore
│   ├── gitmessage
│   ├── pip.conf
│   ├── prepare-commit-msg
│   └── vimrc
├── imgs
│   └── k-means-img-out.png
├── linux
│   ├── 40-change
│   ├── authorized_keys
│   ├── i3config
│   ├── i3status.conf
│   ├── install.sh
│   ├── lock.jpg
│   ├── pkglist.txt
│   ├── pythonrc
│   ├── tmux.conf
│   ├── xinitrc
│   ├── Xresources
│   └── zshrc
├── README.md
├── README.template.md
├── tools
│   ├── cal.py
│   ├── cheat
│   ├── clock.sh
│   ├── cloud
│   │   ├── cloud-dl
│   │   └── README.md
│   ├── face.py
│   ├── factoclock.py
│   ├── ipv6.sh
│   ├── k-means-img.py
│   ├── sendmail.pl
│   ├── transfer
│   ├── zip.go
│   └── www.avdh8.com.html
└── windows
    ├── AndroidStudio.jar
    ├── compresszip.bat
    ├── conemu.xml
    ├── rainmeter
    │   ├── Calendar.ini
    │   ├── CNCalendar.dll
    │   ├── Luna.dll
    │   ├── Notes.ini
    │   ├── 节日.ini
    │   └── 任务栏信息.ini
    └── reg
        ├── ConsolasWithKai.reg
        └── ShowSeconds.reg
```

## Install

### Linux

```bash
cd linux
./install.sh
```
#### 40-changes
cp to `/usr/lib/dhcpcd/dhcpcd-hooks/40-change`，自动更新IP

## tools

### k-means-img.py
使用图片 k-means 得到主要颜色生成主题颜色。

#### 结果
![k-means-img](https://raw.githubusercontent.com/zYeoman/dotfiles/master/imgs/k-means-img-out.png?token=AJeVsofeL0Go74-Nu4jrlCwjSJubLbn2ks5YcfpjwA%3D%3D)

#### TODO
* 生成主题文件
* 抓取某些细节颜色

#### Ref
[图片主题色提取算法小结](https://xcoder.in/2014/09/17/theme-color-extract/)

### factoclock.py
一个冷知识。来自 [factoclock](http://factoclock.com)

#### 结果
实例

```
In the motorcycle sport enduro, 113 is regarded as an unlucky number to be given to a race entrant and is colloquially known as a "blind pew".
```

### zip.go
图片压缩，并生成压缩包。

#### TODO
* Output with color and category

### face.py
把一张脸叠加到另一张上，很魔性。

#### Requirements

```
cv2
dlib
numpy
```

#### Usage
* 下载 dlib 的`shape_predictor_68_face_landmarks.dat`数据文件。
* 修改代码中数据文件位置。
* 运行。

### cal.py
在图片上加上日历。
还没搞完。

### ipv6.sh
罗姆楼 ipv6 配置

### sendmail.pl
发送邮件

### clock.sh
番茄闹钟
