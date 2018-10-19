//
//  RefreshHeader.swift
//
//  Created by wubaolai on 2018/7/29.
//  Copyright © 2018年 wubaolai. All rights reserved.
//

import Foundation

public typealias RefreshRefreshingBlock = () -> ()

public enum RefreshLoadType: String {
    case normal     = "正常"
    case loading    = "加载中"
    case error      = "请求错误"
    case noNetwork  = "无网络"
    case noData     = "无数据"
}
