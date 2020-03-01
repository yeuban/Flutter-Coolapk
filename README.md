# Coolapk Flutter

![Build](https://github.com/Cyenoch/Flutter-Coolapk/workflows/CI/badge.svg?branch=master)

兴趣使然

本项目主要适配桌面端（宽屏）
由于path_provider目前没有足够好的windows实现，所有ExtendedImage都关闭了cache

手机使用时(或是软件宽度<740时)，导航功能移动至侧滑

目录结构说明->

```emm
ios/ ios平台相关
android/ android平台相关
windows/ windows平台相关
linux/ linux平台相关
assets/ 资源文件夹
.github/workflows/ github Actions配置
lib/
  /network/
    /api/ 存放基本的api
    /model/ 存放常用的Model
  /page/
    /auto_page/ 暂无
    /home/ 主页
    /launcher/ 启动页
    /login/ 登录页
    /product/ 数码详情页
  /store/
  /util/ 通用工具
  /widget/ 存放控件
    /data_list/ 数据列表控件(准备转成auto_page)
    /item_adapter/ item适配器
test/ 测试(基本不用)
```

功能完成情况:

- [x] 登录
- [ ] 注册
- [ ] 首页
  - [x] 框架
  - [ ] 关注
  - [ ] 热榜
  - [x] 话题
  - [x] 酷图
  - [ ] 视频
  - [x] 问答
  - [ ] 看看号
  - [x] 直播
  - [ ] 酷品
- [ ] 数码
  - [x] 框架
  - [x] 排行榜
  - [ ] 手机
  - [ ] 数码
- [ ] item适配
  - [x] emoji显示
  - [ ] 问答item适配
    - [x] 显示
    - [ ] 功能
  - [ ] 首页轮播item适配
    - [x] 显示
    - [ ] 功能
- [ ] 各种子页面适配
  - [x] 数码详情页数据显示
    - [ ] 相关操作
  - [ ] and more....
- [ ] 动态详情页以及相关操作
  - [ ] 动态内容
  - [ ] 点赞
  - [ ] 点赞回复
  - [ ] 转发
  - [ ] 回复消息
  - [ ] 回复 别人回复的消息
  - [ ] 回复 别人回复的消息 的消息
  - [ ] 评论排序
  - [ ] 收藏
  - [ ] 举报
  - [ ] 举报回复
  - [ ] 关注楼主
  - [ ] 跳转到楼主/评论用户信息
  - [ ] 查看赞
  - [ ] 查看回复
- [ ] 发动态
- [ ] 发酷图
- [ ] 发二手
- [ ] 发图文
- [ ] 发提问
- [ ] 发话题
- [ ] 搜索
- [ ] 话题页
  - [ ] 关注话题
  - [ ] 话题页面对该话题进行发动态/图文/提问
  - [ ] 搜索此话题内容
- [ ] 酷图页
  - [x] 显示列表
  - [ ] 查看酷图
  - [ ] 保存酷图
  - [ ] 点赞/评论/转发/收藏
  - [ ] 举报
- [ ] 问答
  - [ ] 关注问题
  - [ ] 添加回答
  - [ ] 邀请回答
  - [ ] 转发提问
- [ ] 看看号相关
  - [ ] 订阅
  - [ ] 对某看看号进行发动态/图文/提问
- [ ] 直播
- [ ] 我(页)
  - [ ] 我的关注页
  - [ ] 我的收藏页
    - [ ] 新建收藏单
    - [ ] 分享/点赞/关注/修改信息/删除
    - [ ] 我的图文
  - [ ] 我关注的好友页
  - [ ] 关注我的好友页
  - [ ] 我的所有动态
- [ ] 用户信息页
  - [ ] 编辑资料
  - [ ] 显示用户信息
  - [ ] 显示动态/关注的应用/应用集/发现/评分/酷图/我开发的软件
  - [ ] 分享/加关注/私信
- [ ] 通知页
  - [ ] @我的动态
  - [ ] @我的评论
  - [ ] 我收到的赞
  - [ ] 好友关注
  - [ ] 私信
  - [ ] 显示通知
  - [ ] 清除通知
  
看起来还挺多的。。。

项目使用Provider进行全局状态管理,主要由两个全局状态,Theme和User
item_adapter目录下的auto_item_adapter进行item的适配

欢迎提交pr
欢迎进群py讨论
- [751659171](https://jq.qq.com/?_wv=1027&k=5iu6dt5)

欢迎给我点赞(star) 投币(捐赠) 转发(fork)三连支持=,=你的每亿点帮助都会转化成我的动力
<p align="center" hidden>
	<img src="https://s2.ax1x.com/2020/03/01/365mqJ.jpg" alt="Sample" emm="220 330" width="0" height="0">
	<img src="https://s2.ax1x.com/2020/03/01/365uZ9.md.png" alt="Sample" emm="220 300" width="0" height="0">
</p>
