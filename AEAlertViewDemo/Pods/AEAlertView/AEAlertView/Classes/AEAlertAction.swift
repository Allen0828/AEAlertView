//
//  AEAlertAction.swift
//  AEAlertAction
//
//  代码地址: https://github.com/Allen0828/AEAlertView
//  Copyright © 2017年 Allen. All rights reserved.
//

import UIKit

/// Action 样式
public enum AEAlertActionStyle {
    case defaulted,
    cancel,
    other
}

open class AEAlertAction: NSObject {
    
    public init(title: String, style: AEAlertActionStyle, handler: @escaping (_ action: AEAlertAction)->()) {
        self.title = title
        self.style = style
        self.handler = handler
    }
    
    public var title: String?
    public var style: AEAlertActionStyle = .defaulted
    public var handler:((_ action: AEAlertAction)->())?
    public var enabled: Bool? {
        didSet { setEnabled(enabled: enabled ?? true) }
    }
    /// 默认为所有按钮中的下标 除非你手动设置
    public var tag: Int {
        get {
            return _tag
        }
        set {
            _tag = newValue
        }
    }
    private var _tag: Int = -1
    
    public weak var actionButton: UIButton?
    
    override init() {
        super.init()
        enabled = true
        
    }
    
    private func setEnabled(enabled: Bool) {
        actionButton?.isEnabled = enabled
        if actionButton?.isEnabled == false {
            actionButton?.layer.borderColor = UIColor.lightGray.cgColor
        }else {
            actionButton?.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
}

// MARK: - 自定义alertAction
open class AEAlertViewButton: UIButton {
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
        layer.borderWidth = 0.0
        clipsToBounds = true
    }
    
    override public var intrinsicContentSize: CGSize {
        get {
            if isHidden {
                return CGSize.zero
            }
            return CGSize(width: super.intrinsicContentSize.width + 12.0, height: 30.0)
        }
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        setNeedsDisplay()
    }
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        setNeedsDisplay()
    }
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        setNeedsDisplay()
    }
    
    public func setBackgroundColor(color: UIColor, state: UIControl.State) {
        setBackgroundImage(imageWithColor(color: color), for: state)
    }
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
