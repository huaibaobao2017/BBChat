//
//  guardImages.swift
//  Center
//
//  Created by bb on 2017/11/3.
//  Copyright © 2017年 bb. All rights reserved.
//

var registerData = ["title": "请输入你的手机号", "buttonType": "下一步", "buttonTag": "1001"]

var loginData = ["title": "手机验证码登录", "buttonType": "登录", "buttonTag": "1002"]
// 我
var myData = [
    ["section": "1", "rows":
        [
            ["title": "钱包", "imageUrl": "MoreMyBankCard"]
        ]
    ],
    ["section": "2", "rows":
        [
            ["title": "收藏", "imageUrl": "MoreMyFavorites"],
            ["title": "相册", "imageUrl": "MoreMyAlbum"],
            ["title": "卡包", "imageUrl": "MyCardPackageIcon"],
            ["title": "表情", "imageUrl": "MoreExpressionShops"]
        ]
    ],
    ["section": "3", "rows":
        [
            ["title": "设置", "imageUrl": "MoreSetting"]
        ]
    ]
]
// 设置
var settingData = [
    ["section": "1", "rows": ["账号与安全"]],
    ["section": "2", "rows": ["新消息通知", "隐私", "通用"]],
    ["section": "3", "rows": ["帮助与反馈","关于"]],
    ["section": "4", "rows": ["退出登录"]]
]
// 账号与安全
var securityData = [
    ["section": "1", "rows": ["聊天号", "手机号"]],
    ["section": "2", "rows": ["密码", "声音锁"]],
    ["section": "3", "rows": ["应急联系人","登录设备管理", "更多安全设置"]],
    ["section": "4", "rows": ["安全中心"]]
]
// 个人信息
var infoData = [
    ["section": "1", "rows": ["头像", "名字", "聊天号", "我的二维码", "更多"]],
    ["section": "2", "rows": ["我的地址"]]
]
