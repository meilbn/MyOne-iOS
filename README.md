# MyOne-iOS
我的《一个》 iOS App

其实主要是因为不太想看广告，所以在抓包之后尝试自己写一下。不过仅仅是学习和娱乐而已。
与[官方的 App](http://wufazhuce.com/) 区别暂时有：

0. 没有广告（初衷）。
1. 没有阅读限制。官方是首页、文章、问题、东西都限制为查看最近的 10 条。
2. 暂时不做登录，收藏应该是存在本地。
3. 暂时不做分享功能。

如果想使用一些官方 App 中有但是这个 App 没有的功能的话，请使用官方 App（这也是废话）。
获取过的数据会先存在本地，下次查看也是先加载本地的缓存(还没想好是否真的要这样，感觉有些数据具有时效性，加载本地的话，有些数据可能已经过时了，比如点赞数)。获取最新的数据的话，暂时还没想好要怎么覆盖好一点，这个后面慢慢想。

感谢开源，本项目暂时使用到的第三方开源库有：

1. [AFNetworking](https://github.com/AFNetworking/AFNetworking)
2. [SDWebImage](https://github.com/rs/SDWebImage)
3. [MBProgressHUD](https://github.com/jdg/MBProgressHUD)
4. [iCarousel](https://github.com/nicklockwood/iCarousel)
5. [MJExtension](https://github.com/CoderMJLee/MJExtension)
6. [Masonry](https://github.com/SnapKit/Masonry)
7. [DSTransparentNavigationBar](https://github.com/diegoserranoa/DSTransparentNavigationBar)

项目中图片的展示方式，我是根据 [Ray Wenderlich](http://www.raywenderlich.com/) 上[这篇文章](http://www.raywenderlich.com/94302/implement-circular-image-loader-animation-cashapelayer)改写的，原文是用 Swift 写的，我是把这个项目拿来改成 Objective-C 而已，然后在运行的过程中发现最后图片显示出来之后会有闪烁，然后我就去看了文章的评论，发现有一个哥们儿也发现了这个问题，然后看到了评论里面作者的回复，最后解决了这个问题。感觉这个效果很不错，感谢！

做这个项目，[Reveal](http://revealapp.com/) 真的是帮了我的大忙！要是光在手机上看官方的 App 的话，不可能在这么短的时间内完成的，多亏了 Reveal，我才能看到 App 内部的一些信息，能让我很快地完成这个项目，没白买！而且在日常的工作中，我也是经常使用 Reveal 的，真的是一个非常棒的软件！