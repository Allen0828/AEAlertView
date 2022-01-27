//
//  AEAlertAction.swift
//  AEAlertAction
//
//  代码地址: https://github.com/Allen0828/AEAlertView
//  Copyright © 2017年 Allen. All rights reserved.
//

import UIKit

/// imgae放置的方向 只支持左右 (方便计算action高度)
public enum AEDirectionalEdge {
    /// leading
    case left
    /// trailing
    case right
}

/// Action 样式
public enum AEAlertActionStyle {
    case defaulted,
    cancel
}

open class AEAlertAction: NSObject {
    
    
    public var title: String?
    public var titleColor: UIColor? = UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1)
    public var cancelTitleColor: UIColor? = UIColor.darkGray
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 14)
    public var cancelTitleFont: UIFont = UIFont.systemFont(ofSize: 14)
    
    public var image: UIImage?
    public var imagePlacement: AEDirectionalEdge = .left
    
    public var numberOfLines: Int = 1
    public var textAlignment: NSTextAlignment = .center
    public var backgroundColor: UIColor?
    public var cancelBackgroundColor: UIColor?
    
    /// layer 属性 推荐在 AEAlertView-style等于custom时 使用
    /// layerBorderWidth>0 才会生效
    public var layerBorderColor: UIColor? = UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1)
    public var cancelLayerBorderColor: UIColor? = UIColor.darkGray
    public var layerBorderWidth: CGFloat = 0
    public var layerCornerRadius: CGFloat = 0
        
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
    
    public convenience init(title: String, handler: @escaping (_ action: AEAlertAction)->()) {
        self.init(title: title, style: .defaulted, handler: handler)
    }
    
    public init(title: String, style: AEAlertActionStyle, handler: @escaping (_ action: AEAlertAction)->()) {
        super.init()
        
        self.title = title
        self.style = style
        self.handler = handler
        self.enabled = true
    }


    private var _tag: Int = -1
    public weak var actionButton: AEAlertViewButton?
    
}

extension AEAlertAction {
    private func setEnabled(enabled: Bool) {
        actionButton?.isEnabled = enabled
        actionButton?.layer.borderColor = UIColor.lightGray.cgColor
    }
    
}


// MARK: - 自定义alertAction
open class AEAlertViewButton: UIButton {
    
    public var imagePlacement: AEDirectionalEdge = .left
    
    public weak var action: AEAlertAction? {
        didSet {
            guard let `action` = action else { return }
            self.imagePlacement = action.imagePlacement
            setTitle(action.title, for: .normal)
            setImage(action.image, for: .normal)
            imageView?.contentMode = .scaleAspectFit
            layer.cornerRadius = action.layerCornerRadius
            titleLabel?.numberOfLines = action.numberOfLines
            titleLabel?.textAlignment = action.textAlignment
            if action.style == .defaulted {
                setTitleColor(action.titleColor, for: .normal)
                setBackgroundColor(color: action.backgroundColor, state: .normal)
                setBackgroundColor(color: action.backgroundColor, state: .highlighted)
                titleLabel?.font = action.titleFont
                if action.layerBorderWidth > 0 {
                    layer.borderWidth = action.layerBorderWidth
                    layer.borderColor = action.layerBorderColor?.cgColor
                }
            } else {
                setTitleColor(action.cancelTitleColor, for: .normal)
                setBackgroundColor(color: action.cancelBackgroundColor, state: .normal)
                setBackgroundColor(color: action.cancelBackgroundColor, state: .highlighted)
                titleLabel?.font = action.cancelTitleFont
                if action.layerBorderWidth > 0 {
                    layer.borderWidth = action.layerBorderWidth
                    layer.borderColor = action.cancelLayerBorderColor?.cgColor
                }
            }
            
        }
    }
    
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
    
    public func setBackgroundColor(color: UIColor?, state: UIControl.State) {
        if color == nil { return }
        setBackgroundImage(imageWithColor(color: color ?? UIColor.white), for: state)
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
    
    
    @available(iOS 13.0, *)
    private func getImagePlacement(_ type: AEDirectionalEdge) -> NSDirectionalRectEdge {
        switch type {
        case .left:
            return .leading
        case .right:
            return .trailing
        }
    }
    
    public func setButtonEdgeInsets() {
        let space: CGFloat = 4
        var labelWidth : CGFloat = 0.0
        var imageEdgeInset = UIEdgeInsets.zero
        var labelEdgeInset = UIEdgeInsets.zero
        let imageWith = self.imageView?.frame.size.width
        labelWidth = (self.titleLabel?.intrinsicContentSize.width) ?? 0
        switch self.imagePlacement {
        case .left:
            imageEdgeInset = UIEdgeInsets(top: 0, left: -space/2.0, bottom: 0, right: space/2.0);
            labelEdgeInset = UIEdgeInsets(top: 0, left: space/2.0, bottom: 0, right: -space/2.0);
        case .right:
            imageEdgeInset = UIEdgeInsets(top: 0, left: labelWidth+space/2.0, bottom: 0, right: -labelWidth-space/2.0)
            labelEdgeInset = UIEdgeInsets(top: 0, left: -imageWith!-space/2.0, bottom: 0, right: imageWith!+space/2.0)
        }
        self.titleEdgeInsets = labelEdgeInset
        self.imageEdgeInsets = imageEdgeInset
    }
    
}





//    iOS 15
//    public var showsActivityIndicator: Bool?
//    public var subtitle: String?
//    public var subtitleColor: UIColor?
//    public var cancelSubtitleColor: UIColor?
//    public var subtitleFont: UIFont = UIFont.systemFont(ofSize: 12)
//    end iOS 15
//    {
//        didSet {
//            if #available(iOS 15, tvOS 15.0, *) {
//                _actionButton.configuration?.imagePlacement = getImagePlacement(imagePlacement)
//                _actionButton.configuration?.imagePadding = 8
//                _actionButton.configuration?.titleAlignment = .center
//            }
//        }
//    }

//    @available(iOS 15.0, tvOS 15.0, *)

//    {
//        get { return _actionButton.configuration?.subtitle }
//        set { _actionButton.configuration?.subtitle = newValue
//
//        }
//    }
//    @available(iOS 15.0, tvOS 15.0, *)
//    public var subtitleColor: UIColor?
//    {
//        get { return _subtitleColor }
//        set {
//            _subtitleColor = newValue
//            _actionButton.configuration?.subtitleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
//                var out = incoming
//                out.foregroundColor = newValue
//                out.font = self._subtitleFont
//                return out
//            }
//        }
//    }
//    @available(iOS 15.0, tvOS 15.0, *)
//    public var subtitleFont: UIFont?
//    {
//        get { return _subtitleFont }
//        set {
//            _subtitleFont = newValue
//            _actionButton.configuration?.subtitleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { [unowned self] incoming in
//                var out = incoming
//                out.foregroundColor = self._subtitleColor
//                out.font = newValue
//                return out
//            }
//        }
//    }

//    @available(iOS 15.0, tvOS 15.0, *)
//    public var showsActivityIndicator: Bool?
//    {
//        get { return _actionButton.configuration?.showsActivityIndicator }
//        set { _actionButton.configuration?.showsActivityIndicator = newValue ?? false }
//    }


//    {
//        get {
//            if #available(iOS 15.0, tvOS 15.0, *) {
//                return _actionButton.configuration?.image
//            }
//            return _actionButton.currentImage
//        }
//        set {
//            if #available(iOS 15.0, tvOS 15.0, *) {
//                _actionButton.configuration?.image = newValue
//                _actionButton.configuration?.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 1, weight: .ultraLight, scale: .small)
//            } else {
//                _actionButton.setImage(newValue, for: .normal)
//                _actionButton.imageView?.contentMode = .scaleAspectFit
//            }
//        }
//    }
//    @available(iOS 15.0, tvOS 15.0, *)
//    public var attributedSubtitle: AttributedString?
//    {
//        get { return _actionButton.configuration?.attributedSubtitle }
//        set { _actionButton.configuration?.attributedSubtitle = newValue }
//    }

//    @available(iOS 15.0, tvOS 15.0, *)
//    private var configuration: UIButton.Configuration?
//    {
//        get { return _actionButton.configuration }
//        set { _actionButton.configuration = newValue }
//    }




//    {
//        didSet { _actionButton.titleLabel?.numberOfLines = numberOfLines }
//    }

//    {
//        didSet { _actionButton.titleLabel?.textAlignment = textAlignment }
//    }

//    {
//        didSet {
//            if #available(iOS 15.0, tvOS 15.0, *) {
//                _actionButton.configuration?.title = title
//                _actionButton.configuration?.baseForegroundColor = textColor
//            } else {
//                _actionButton.setTitleColor(textColor, for: .normal)
//                _actionButton.setTitleColor(textColor, for: .highlighted)
//            }
//        }
//    }

//    {
//        didSet {
//            if #available(iOS 15.0, tvOS 15.0, *) {
//                configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { [unowned self] incoming in
//                    var out = incoming
//                    out.font = self.textFont
//                    return out
//                }
//            } else {
//                _actionButton.titleLabel?.font = textFont
//            }
//        }
//    }



/// defaulted 标题的颜色
//    public var buttonTitleColor: UIColor? = UIColor(red: 26/255, green: 104/255, blue: 254/255, alpha: 1)
// 只在 AEAlertViewStyle == custom 才会生效
/// defaulted 描边颜色 默认为浅蓝色
//    public var buttonLayerBorderColor: UIColor? = UIColor(red: 26/255, green: 104/255, blue: 254/255, alpha: 1)
/// defaulted 描边宽度 默认1
//    public var buttonLayerBorderWidth: CGFloat = 1
/// defaulted 圆角 默认4
//    public var buttonCornerRadius: CGFloat = 4


/// 用于更新按钮信息
//    public func updated() {
//        if #available(iOS 15.0, tvOS 15.0, *) {
//            _actionButton.configurationUpdateHandler = { [unowned self] button in
//                var config = button.configuration
//                config?.showsActivityIndicator = self.showsActivityIndicator ?? false
//                config?.imagePlacement = self.getImagePlacement(self.imagePlacement)
//                config?.title = self.title
//                config?.subtitle = self.subtitle
//                button.isEnabled = self.enabled ?? false
//                button.configuration = config
//            }
//            _actionButton.setNeedsUpdateConfiguration()
//        } else {
//            setButtonEdgeInsets()
//        }
//    }
