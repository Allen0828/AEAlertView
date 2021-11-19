//
//  AEAlertAction.swift
//  AEAlertAction
//
//  代码地址: https://github.com/Allen0828/AEAlertView
//  Copyright © 2017年 Allen. All rights reserved.
//

import UIKit




open class AEAlertAction: NSObject {
    
    /// Action 样式
    public enum AEAlertActionStyle {
        case defaulted,
        cancel,
        other
    }
    /// 放置的方向
    public enum AEDirectionalEdge {
        case top,
        left,
        right,
        bottom
    }
    
    public init(title: String, style: AEAlertActionStyle, handler: @escaping (_ action: AEAlertAction)->()) {
        super.init()
        self.title = title
        self.style = style
        self.handler = handler
        self.enabled = true
        _actionButton = AEAlertViewButton()
        _actionButton.setTitle(title, for: .normal)
        if style == .defaulted {
            _actionButton.setTitleColor(UIColor.blue, for: .normal)
        } else if style == .cancel {
            _actionButton.setTitleColor(UIColor.lightGray, for: .normal)
        } else {
            _actionButton.setTitleColor(UIColor.black, for: .normal)
        }
        if #available(iOS 15.0, *) {
            configuration = UIButton.Configuration.plain()
        }
    }
    
    public var title: String?
    public var attributedTitle: NSAttributedString? {
        didSet {
            _actionButton.setAttributedTitle(attributedTitle, for: .normal)
        }
    }
    public var image: UIImage? {
        didSet {
            _actionButton.setImage(image, for: .normal)
        }
    }
    public var imagePlacement: AEDirectionalEdge = .right {
        didSet {
            if #available(iOS 15, tvOS 15.0, *) {
                _actionButton.configuration?.imagePlacement = getImagePlacement(imagePlacement)
            } 
        }
    }
    
    @available(iOS 15.0, tvOS 15.0, *)
    public var subtitle: String? {
        get { return _actionButton.configuration?.subtitle }
        set { _actionButton.configuration?.subtitle = newValue }
    }
    @available(iOS 15.0, tvOS 15.0, *)
    public var attributedSubtitle: AttributedString? {
        get { return _actionButton.configuration?.attributedSubtitle }
        set { _actionButton.configuration?.attributedSubtitle = newValue }
    }
    @available(iOS 15.0, tvOS 15.0, *)
    private var configuration: UIButton.Configuration? {
        get { return _actionButton.configuration }
        set { _actionButton.configuration = newValue }
    }
    
    
    public var style: AEAlertActionStyle = .defaulted
    public var handler:((_ action: AEAlertAction)->())?
    public var enabled: Bool? {
        didSet { setEnabled(enabled: enabled ?? true) }
    }
    /// 默认为所有按钮中的下标 除非你手动设置
    public var tag: Int {
        get { return _tag }
        set { _tag = newValue }
    }
    public var numberOfLines: Int = 0 {
        didSet { _actionButton.titleLabel?.numberOfLines = numberOfLines }
    }
    public var textAlignment: NSTextAlignment = .center {
        didSet { _actionButton.titleLabel?.textAlignment = textAlignment }
    }
    public var textColor: UIColor? {
        didSet { _actionButton.setTitleColor(textColor, for: .normal) }
    }
    public var textFont: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            if #available(iOS 15.0, tvOS 15.0, *) {
                configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                    var out = incoming
//                    out.foregroundColor = UIColor.black
                    out.font = self.textFont
                    return out
                }
            } else {
                _actionButton.titleLabel?.font = textFont
            }
        }
    }
    
    
    public var contentInsets: UIEdgeInsets?
    public var backgroundColor: UIColor? = UIColor.white

    var actionButton: AEAlertViewButton {
        get { return _actionButton }
    }

    private var _tag: Int = -1
    private var _subtitle: String?
    private var _attributedSubtitle: NSAttributedString?
    private var _actionButton: AEAlertViewButton = AEAlertViewButton()
    
}

extension AEAlertAction {
    private func setEnabled(enabled: Bool) {
        _actionButton.isEnabled = enabled
        _actionButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func getImagePlacement(_ type: AEDirectionalEdge) -> NSDirectionalRectEdge {
        switch type {
        case .top:
            return .top
        case .left:
            return .leading
        case .right:
            return .trailing
        case .bottom:
            return .bottom
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
