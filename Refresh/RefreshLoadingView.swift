//
//  RefreshLoadingView.swift
//
//  Created by wubaolai on 2018/7/29.
//  Copyright © 2018年 wubaolai. All rights reserved.
//

import UIKit

public class RefreshLoadingView: UIView {

    public var offsetY: CGFloat = 130
    public var indicatorSize = CGSize.init(width: 20.0, height: 20.0)

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubview(loadingView)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        loadingView.frame = CGRect.init(x: (frame.width - indicatorSize.width) / 2, y: offsetY, width: indicatorSize.width, height: indicatorSize.height)
    }

    // MARK: - Lazy load
    public lazy var loadingView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView.init(frame: .zero)
        let style = UIActivityIndicatorView.Style.gray
        indicatorView.style = style
        indicatorView.startAnimating()
        return indicatorView
    }()

}
