# 余烬 · iOS 壳（Xcode 云端构建）

用 Apple 官方的 `xcodebuild` 编译，产出**未签名** ipa，你再用自己的 p12 证书签。

## 为什么这么做

之前的包是我在 Windows 上手写 Mach-O 链接器生成的，装上后启动即退、且无崩溃日志。
这套工程把「链接器」这个变量换成 Apple 官方的，如果还闪退，就只剩证书和描述文件两种可能。

## 上传到 GitHub

1. 打开 github.com，右上角 **+** → **New repository**
2. 名字填 `embers-ios-2011`，选 **Private**，点 **Create repository**
3. 在新仓库页面点 **uploading an existing file**
4. 把本文件夹里的 `project.yml`、`Sources`、`README.md` 拖进去
5. 点 **Commit changes**

**`.github` 目录要单独处理**（浏览器可能忽略隐藏文件夹）：

6. 回到仓库首页，点 **Add file** → **Create new file**
7. 文件名输入框里粘贴：`.github/workflows/build.yml`
8. 把本文件夹里 `.github/workflows/build.yml` 的内容整个复制进去
9. 点 **Commit changes**

## 等它构建

提交后自动开始。点仓库顶部的 **Actions** 标签，能看到一个 `Build IPA` 的任务在跑。

大约 2–4 分钟。绿色勾出现后：

1. 点进那个任务
2. 页面底部 **Artifacts** 区域，下载 `YuanJin-unsigned`
3. 得到一个 zip，解压出 `YuanJin-unsigned.ipa`

## 签名安装

用全能签导入这个未签名 ipa，选你的 p12 证书，签名，安装。

Bundle ID 是 `net.de5.guanjin2011`，和你之前的包一致，装之前建议先删旧的。

## 如果还闪退

那问题就不在二进制了。可能的方向：

- 描述文件里没有你的设备 UDID（Ad-Hoc 分发必须包含）
- p12 对应的证书已被 Apple 吊销
- p12 缺少配套的 `.mobileprovision`
- 证书类型是「企业证书」但描述文件是「开发证书」，两者不匹配

到时候把 `YuanJin.app` 的 `embedded.mobileprovision` 和证书信息发我，能直接看出是哪一条。

## 改内容

- 网址：`Sources/AppDelegate.m` 里的 `kHomeURL`
- 名称：`Sources/Info.plist` 里的 `CFBundleDisplayName`
- Bundle ID：`project.yml` 里的 `PRODUCT_BUNDLE_IDENTIFIER`
- 图标：`Sources/Assets.xcassets/AppIcon.appiconset/`
