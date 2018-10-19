//
//  Refresh-Extension.swift
//
//  Created by wubaolai on 2018/7/29.
//  Copyright © 2018年 wubaolai. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

public extension UIView {

    // Extension add variable
    fileprivate struct RefreshRuntimeKey {
        static let refreshkey = UnsafeRawPointer.init(bitPattern: "refreshkey".hashValue)
        static let loadTypekey = UnsafeRawPointer.init(bitPattern: "loadTypekey".hashValue)
        static let refreshNoNetworkViewkey = UnsafeRawPointer.init(bitPattern: "refreshNoNetworkViewkey".hashValue)
        static let refreshRequestErrorViewViewkey = UnsafeRawPointer.init(bitPattern: "refreshRequestErrorViewViewkey".hashValue)
        static let refreshNoDataViewkey = UnsafeRawPointer.init(bitPattern: "refreshNoDataViewkey".hashValue)
        static let loadingViewkey = UnsafeRawPointer.init(bitPattern: "loadingViewkey".hashValue)

    }

    /**
     *  设置页面显示的类型
     */
    public var loadType: RefreshLoadType? {
        set(newValue) {
            objc_setAssociatedObject(self, RefreshRuntimeKey.loadTypekey!, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            return  objc_getAssociatedObject(self, RefreshRuntimeKey.loadTypekey!) as? RefreshLoadType
        }
    }

    /**
     *  刷新回调
     */
    public var refreshBlock: RefreshRefreshingBlock? {
        set(newValue) {
            objc_setAssociatedObject(self, RefreshRuntimeKey.refreshkey!, newValue, .OBJC_ASSOCIATION_COPY)
        }
        get {
            return  objc_getAssociatedObject(self, RefreshRuntimeKey.refreshkey!) as? RefreshRefreshingBlock
        }
    }

    // MARK: - 视图
    /**
     *  没有网络时显示的视图
     */
    public var refreshNoNetworkView: RefreshNoNetworkView? {
        set(newValue) {
            objc_setAssociatedObject(self, RefreshRuntimeKey.refreshNoNetworkViewkey!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let view = objc_getAssociatedObject(self, RefreshRuntimeKey.refreshNoNetworkViewkey!) as? RefreshNoNetworkView else {
                return self.getRefreshNoNetworkView()
            }
            return view
        }
    }

    /**
     *  访问出错时显示的视图
     */
    public var refreshRequestErrorView: RefreshRequestErrorView? {
        set(newValue) {
            objc_setAssociatedObject(self, RefreshRuntimeKey.refreshRequestErrorViewViewkey!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let view = objc_getAssociatedObject(self, RefreshRuntimeKey.refreshRequestErrorViewViewkey!) as? RefreshRequestErrorView else {
                return self.getRefreshRequestErrorView()
            }
            return view
        }
    }

    /**
     *  没有数据显示的视图
     */
    public var refreshNoDataView: RefreshNoDataView? {
        set(newValue) {
            objc_setAssociatedObject(self, RefreshRuntimeKey.refreshNoDataViewkey!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let view = objc_getAssociatedObject(self, RefreshRuntimeKey.refreshNoDataViewkey!) as? RefreshNoDataView else {
                return self.getRefreshNoDataView()
            }
            return view
        }
    }

    /**
     *  加载中的视图
     */
    public var refreshLoadingView: RefreshLoadingView? {
        set(newValue) {
            objc_setAssociatedObject(self, RefreshRuntimeKey.loadingViewkey!, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let view = objc_getAssociatedObject(self, RefreshRuntimeKey.loadingViewkey!) as? RefreshLoadingView else {
                return self.getLoadingView()
            }
            
            return  view
        }
    }

}

public extension UIView {

    public func set(loadType: RefreshLoadType) {

        if let _ = self.refreshNoDataView, let _ = self.refreshNoDataView?.superview {
            self.refreshNoDataView?.removeFromSuperview()
        }

        if let _ = self.refreshNoNetworkView, let _ = self.refreshNoNetworkView?.superview {
            self.refreshNoNetworkView?.removeFromSuperview()
        }

        if let _ = self.refreshRequestErrorView, let _ = self.refreshRequestErrorView?.superview {
            self.refreshRequestErrorView?.removeFromSuperview()
        }

        if let _ = self.refreshLoadingView, let _ = self.refreshLoadingView?.superview {
            self.refreshLoadingView?.removeFromSuperview()
        }

        self.loadType = loadType
        switch loadType {
        case .noData:
            guard let noDataView = self.refreshNoDataView else {
                return
            }
            addSubview(noDataView)
            noDataView.snp.makeConstraints { (make) in
                make.left.top.equalToSuperview()
                make.width.equalToSuperview()
                make.height.equalToSuperview()
            }

        case .noNetwork:
            guard let noNetWorkView = self.refreshNoNetworkView else {
                return
            }
            addSubview(noNetWorkView)
            noNetWorkView.snp.makeConstraints { (make) in
                make.left.top.equalToSuperview()
                make.width.equalToSuperview()
                make.height.equalToSuperview()
            }

        case .error:
            guard let errorView = self.refreshRequestErrorView else {
                return
            }
            addSubview(errorView)
            errorView.snp.makeConstraints { (make) in
                make.left.top.equalToSuperview()
                make.width.equalToSuperview()
                make.height.equalToSuperview()
            }

        case .loading:
            guard let loadingView = self.refreshLoadingView else{
                return
            }
            addSubview(loadingView)
            loadingView.snp.makeConstraints { (make) in
                make.left.top.equalToSuperview()
                make.width.equalToSuperview()
                make.height.equalToSuperview()
            }

        default:break
        }
    }
}

extension UIView {

    // 获取无网络View
    fileprivate func getRefreshNoNetworkView() -> RefreshNoNetworkView {
        let rNoNetworkView = RefreshNoNetworkView.init(frame: .zero)
        rNoNetworkView.refreshNoNetworkViewBlock = {[weak self] in
            guard let strongSelf = self else {
                return
            }
            if let _ = strongSelf.refreshBlock {
                strongSelf.refreshBlock!()
            }
        }
        self.refreshNoNetworkView = rNoNetworkView
        
        return rNoNetworkView
    }

    // 请求错误View
    fileprivate func getRefreshRequestErrorView() -> RefreshRequestErrorView {
        let errorView = RefreshRequestErrorView.init(frame: .zero)
        errorView.refreshRequestErrorViewBlock = {[weak self] in
            guard let strongSelf = self else {
                return
            }
            if let _ = strongSelf.refreshBlock {
                strongSelf.refreshBlock!()
            }
        }
        self.refreshRequestErrorView = errorView
        
        return errorView
    }

    // 没有数据View
    fileprivate func getRefreshNoDataView() -> RefreshNoDataView {
        let noDataView = RefreshNoDataView.init(frame: .zero)
        noDataView.refreshBlock = {[weak self] in
            guard let strongSelf = self else {
                return
            }
            if let _ = strongSelf.refreshBlock {
                strongSelf.refreshBlock!()
            }
        }
        self.refreshNoDataView = noDataView
        
        return noDataView
    }

    // 加载中
    fileprivate func getLoadingView() -> RefreshLoadingView {
        let loadingView = RefreshLoadingView()
        self.refreshLoadingView = loadingView
        
        return loadingView
    }

}

