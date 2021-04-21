#!/bin/bash
#查找Xcode.app的位置
XCODE_DIR=/Applications/Xcode.app
if [ ! -d $XCODE_DIR ]; then
    echo "在Applications中未发现Xcode.app"
    exit 1;
fi
echo "发现Xcode.app path: ${XCODE_DIR}..."

#查找并安装 PackageApplication
PACKAGE_DIR=${XCODE_DIR}/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin
packageName='PackageApplication'
packageZip="${packageName}.zip"
packagePath="${PACKAGE_DIR}/${packageName}"
if [ ! -f  $packagePath ]; then
	
	#下载文件
	curl -# -OL https://github.com/JackSteven/PackageApplication/raw/master/PackageApplication.zip
	if [ $? -ne 0 -o ! -f $packageZip ]; then
		echo "下载${packageZip}失败！"
	    exit 2
	fi
	
	#解压文件
	echo "下载${packageZip}完成"
	unzip -o $packageZip
	if [ $? -ne 0 ];then
		echo "解压${packageZip}失败!";
		exit 3
	fi

	#移动文件
	mv $packageName $PACKAGE_DIR
	rm -rf $packageZip
	sudo xcode-select -switch ${XCODE_DIR}/Contents/Developer/
	echo 'switch 完成'
	chmod +x $packagePath
	echo "${packageName}安装完成！"
fi

#清理app
appDir=`pwd`/Build/Products/Release-iphoneos
rm -rf ${appDir}/*.app

#Build app
buildCommand="xcodebuild"
wrokspace=
project=
scheme=

#查看workspace文件
echo '开始查找workspace'
for file in `ls | grep *.xcworkspace`; do
	echo "find xcworkspace => $file"
	wrokspace=$file
	break
done

if [[ -z $wrokspace ]]; then
	echo '未找到workspace'
	echo '开始查找xcodeproj'
	for p in `ls | grep *.xcodeproj`; do
		echo "find xcodeproj => $p"
		project=$p
		scheme=${p%%.*}
		break
	done
fi

if [[ -n $project ]]; then
	buildCommand="$buildCommand -project $project -scheme $scheme"
elif [[ -n $wrokspace ]]; then
	scheme=${wrokspace%%.*}
	buildCommand="$buildCommand -workspace $wrokspace -scheme $scheme"
fi
sdk=`xcodebuild -showBuildSettings | grep ' SDK_NAME = ' | awk -F ' = ' '{print $2}'`
buildCommand="$buildCommand -configuration Release -sdk $sdk"
echo "buildCommand => $buildCommand"

$buildCommand
if [ $? -ne 0 ]; then
	echo 'build 失败，请检测!'
	exit 4
fi
appPath=`find $appDir -name '*.app'`
echo "appPath => $appPath"
ipaDir=`pwd`/Build/ipa
ipaPath="${ipaDir}/${scheme}_$(date "+%Y%m%d")_release_ios.ipa"
#没有ipa文件夹就建一个
if [ ! -d $ipaDir ]; then
	mkdir $ipaDir
fi

#存在同名ipa文件先移除
if [ -f $ipaPath ]; then
	rm -rf $ipaPath
fi

#生成ipa文件
xcrunCommand="xcrun -sdk iphoneos -v PackageApplication $appPath -o $ipaPath"
echo "xcrunCommand => $xcrunCommand"
$xcrunCommand
echo "[OK]打包完成!ipa路径: $ipaPath"
open $ipaDir





