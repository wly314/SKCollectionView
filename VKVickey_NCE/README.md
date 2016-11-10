
# iOS VKVickey_NCE

简单的是语言，深层地做研究，别让程序打败了自己。

###  第三方库管理

CocoaPods 管理第三方库。第三方库以每个大的版本号为一次稳定版本，当前项目使用稳定版本，如果第三方库有大版本升级，则可以根据项目是否对第三方库进行升级。

```
例如：
pod 'AFNetworking', '~> 3.0'，意思为项目当前使用的AFNetworking为4.0.0以下最新版本。
如果AFNetworking升级到4.0.0，则根据自己的项目考虑是否升级，如果升级，只需要Podfile更改为：pod 'AFNetworking', '~> 4.0'，然后执行 pod update 即可。

```
```
使用以下第三库：
AutoLayout布局管理： 		Masonry，本次使用版本2.0以下版本。
数据请求：				AFNetworking，本次使用版本2.0以下版本。
网络图片加载与缓存：		SDWebImage，本次使用版本2.0以下版本。
下拉刷新、上拉加载：		MJRefresh，本次使用版本2.0以下版本。
数据库：					FMDB，本次使用版本2.0以下版本。
网络加载指示器			MBProgressHUD，本次使用版本2.0以下版本。
```

Podfile 如下：

```
platform:ios, '7.0'

target "VKVickey_NCE" do

pod 'Masonry', '~> 1.0'
pod 'AFNetworking', '~> 3.0'
pod 'SDWebImage', '~> 3.0'
pod 'MJRefresh', '~> 3.0'
pod 'FMDB', '~> 2.0'
pod 'MBProgressHUD', '~> 1.0'

end

```

###  代码规范
代码规范参照以下标准：

* [iOS开发代码规范 (待完善)](http://leou.farbox.com/post/dai-ma-gui-fan-dai-wan-shan)
* [iOS重构注意事项 (待完善)](http://leou.farbox.com/post/zhong-gou-zhu-yi-shi-xiang)

###	关于代码审核
建立代码审核机制，相互监督，消灭不合格代码，以便于后期维护，复用。

1. 所有代码审核，按照代码规范审核。
2. 每个版本／功能完成，做内存检测和性能优化。

