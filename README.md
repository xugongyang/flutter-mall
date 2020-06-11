# flutter-mall

> 项目结构
```
├── lib  项目核心代码
│   ├── api  网络请求相关接口
│   ├── common widget 公用方法
│   ├── event 全局事件总总栈
│   ├── main.dart  flutter 入口文件
│   ├── model 实体层部分
│   ├── pages
│   │   ├── compenents 公共组件
│   │   ├── main 主要页面（首页、分类、购物车、我的）
│   │   ├── sub 子页面
│   │   └── widget 页面部件
│   ├── router  路由
│   ├── store 状态管理
│   └── utils  工具
│       ├── api_request.dart   API请求
│       ├── event_bus.dart  全局事件
│       ├── locale_lang_util.dart  国际化支持语言
│       ├── shared_preferences.da rt 本地存储
│       └── translations.dart  文本显示转换（国际化）
├── assets  资源文件
│   ├── fonts  字体
│   └── images 图片
├── locale
│   └── lang 国际化支持语言
│       ├── en_US.json
│       └── zh_CH.json
├── pubspec.yaml  项目依赖管理
```
