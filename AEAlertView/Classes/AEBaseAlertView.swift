//
//  AEBaseAlertView.swift
//  AEAlertView
//
//  代码地址: https://github.com/Allen0828/AEAlertView
//  Copyright © 2017年 Allen. All rights reserved.
//

/*
 如果你对弹窗要求比较高, 可以忽略AEAlertView和 AEUIAlertView. 直接使用此类 可以让你做出你想要的弹窗
 
 需要注意的是 如果继承自此类 在设置button时 需要将
 translatesAutoresizingMaskIntoConstraints 设置为 false

 If you have high requirements for bullet windows, you can ignore AEAlertView and AEUIAlertView. Direct use of this kind of window can let you make the bullet windows you want.
 
 Note that if inherited from this class, you need to set the button
 Translation Autoresizing MaskInto Constraints is set to false
 */


import UIKit

/// 按钮类型 Button type
public enum AEAlertViewButtonType {
    case Filled,
    Bordered
}

/// 按钮排列 Button Arrangement
public enum AEAlertViewButtonArrangement {
    case Horizontal,
    Vertical
}

open class AEBaseAlertView: UIView {
    
    /// 标题 /Tilte
    var titleLabel: UILabel!
    /// 内容 /Messsage
    var messageTextView: AEAlertTextView!
    /// 自定义View /custom view
    var contentView: UIView?
    /// 用来放置按钮的View /Used to place buttons
    var actionButtonContainerView: UIView!
    /// alert背景View 可以用来设置背景颜色等 /alertBackgroundView
    private(set) var alertBackgroundView: UIView!
    
    private(set) var backgroundViewVerticalCenteringConstraint: NSLayoutConstraint!
    private var alertBackgroundWidthConstraint: NSLayoutConstraint!
    private var contentViewContainerView: UIView!
    
    /// 设置自定义View /setContentView Func
    public func setContentView(contentView: UIView, width: NSInteger, height: NSInteger) {
        self.contentView(view: contentView, width: width, height: height)
    }
    
    /// 弹窗最大的宽度 默认为屏幕宽度 - 两边间距 (38 * 2)  /Maximum width of bullet window. Default is Screen Width-Side Spacing
    public var maximumWidth: CGFloat = 0 {
        didSet {
           setMaximumWidth(maximumWidth: maximumWidth)
        }
    }
    
    /// 标题距离背景顶部的间距  /The distance between the title and the top of the background
    public var titleTopMargin: NSInteger? {
        didSet {
            setTitleTopMargin(Margin: titleTopMargin ?? 0)
        }
    }
    
    /// 内容距离标题的间距  /Distance between content and title
    public var messageTopMargin: Int? {
        didSet {
            setMessageTopMargin(margin: messageTopMargin ?? 0)
        }
    }
    
    /// 设置标题距离 alertBackgroundView左右的间距 默认左右 51@750  /Title Distance, Background Left and Right Distance
    public var titleLeadingAndTrailingPadding: NSInteger = 0 {
        didSet {
            setTitleLeadingAndTrailingPadding( titleLeadingAndTrailingPadding)
        }
    }
    
    /// 设置内容 距离左右边框的间距 数值越小距离alertBackgroundView越近 默认左右各 24@750  /message Distance, Background Left and Right Distance
    public var messageLeadingAndTrailingPadding: NSInteger = 0 {
        didSet {
            setMessageLeadingAndTrailingPadding( messageLeadingAndTrailingPadding)
        }
    }
    
    /// 按钮距离AlertView底部的间距 默认 13@750   / button Distance, buttom
    public var buttonBottomMargin: NSInteger = 0  {
        didSet {
            setButtonBottomMargin(buttonBottomMargin)
        }
    }
    
    /// 内容距离按钮的位置 默认将自定义view填充在messageView中 所有此属于等于 自定义view距离按钮上方的距离  /The location of the content distance button fills the custom view in the message view by default, which belongs to the distance equal to the distance above the custom view distance button.
    public var messageWithButtonMargin: NSInteger? {
        didSet {
            setMessageWithButtonMargin(Margin: messageWithButtonMargin ?? 0)
        }
    }
    
    /// 内容对其方式 默认center / messageAlignment
    public var messageAlignment: NSTextAlignment = .center {
        didSet {
            setMessageAlignment(messageAlignment)
        }
    }
    
    /// 内容高度 如果不设置 默认为计算出来的文字高度 如果设置 超出的文字可以滑动  /If the content height is not set to the calculated text height by default, if it is set to exceed the text height, it can slide.
    public var messageHeight: NSInteger = 0 {
        didSet {
            setMessageHeight(messageHeight, isScroll: true)
        }
    }
    
    /// 自定义view距离message底部的间距 默认 25@750  /Customize the distance between the view and the bottom of the message
    public var contentViewTopMargin: NSInteger = 0 {
        didSet {
            setContentViewTopMargin(contentViewTopMargin)
        }
    }
    
    /// 自定义view距离按钮头部的间距 默认 25@750  /Custom View Distance Button Header Spacing
    public var contentViewBottomMargin: NSInteger = 0{
        didSet {
            setContentViewBottomMargin(contentViewBottomMargin)
        }
    }
    
    /// 设置按钮  addButtons
    public var actionButtons: [AEAlertViewButton]? {
        didSet {
            guard let buttons = actionButtons else {
                return
            }
            setActionButtons(buttons: buttons)
        }
    }
    
    // MARK: 按钮相关
    /// 按钮距离父控件的上下间距 上下必须为相等数  默认上下各6  /Button Distance Upper and Lower Spacing of Parent Control
    public var buttonSuperMargin: NSInteger = 6
    
    /// 按钮距离左右的间距 2个按钮时默认左右15 1个或多个按钮时默认51  /The distance between the buttons
    public var buttonsSuperPadding: NSInteger = 15
    public var buttonSuperPadding: NSInteger = 51

    /// 设置按钮排列方式 只能设置2个按钮时的样式 默认左右各一个   /Style of setting button arrangement mode when only 2 buttons can be set
    public var buttonArrangement: AEAlertViewButtonArrangement = .Horizontal
    
    // BASEVIEW
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        maximumWidth = 480.0
        
        alertBackgroundView = UIView(frame: CGRect.zero)
        alertBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        alertBackgroundView.backgroundColor = UIColor(white: 0.97, alpha: 1.0)
        alertBackgroundView.layer.cornerRadius = 8
        addSubview(alertBackgroundView!)
        
        titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.white
        titleLabel.text = "Title Label"
        alertBackgroundView.addSubview(titleLabel)
        
        messageTextView = AEAlertTextView(frame: CGRect.zero)
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
        messageTextView.backgroundColor = UIColor.clear
        messageTextView.textAlignment = .center
        messageTextView.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
        
            messageTextView.setContentHuggingPriority(
                UILayoutPriority(rawValue: 0), for: .vertical)
            messageTextView.setContentCompressionResistancePriority(
                UILayoutPriority.defaultHigh, for: .vertical)
        
        messageTextView.allowsEditingTextAttributes = false
        
        messageTextView.isScrollEnabled = false
        messageTextView.isEditable = false
        messageTextView.textColor = UIColor.white
        messageTextView.text = "Message Text View"
        alertBackgroundView.addSubview(messageTextView)
        
        contentViewContainerView = UIView(frame: CGRect.zero)
        contentViewContainerView.translatesAutoresizingMaskIntoConstraints = false
        
            contentView?.setContentCompressionResistancePriority(
                UILayoutPriority.required, for: .vertical)
        
        alertBackgroundView.addSubview(contentViewContainerView)
        
        actionButtonContainerView = UIView(frame: CGRect.zero)
        actionButtonContainerView.translatesAutoresizingMaskIntoConstraints = false
            actionButtonContainerView.setContentCompressionResistancePriority( UILayoutPriority.required, for: .vertical)
      
        alertBackgroundView.addSubview(actionButtonContainerView)
        
        actionButtonContainerView = UIView(frame: CGRect.zero)
        actionButtonContainerView.translatesAutoresizingMaskIntoConstraints = false
            actionButtonContainerView.setContentCompressionResistancePriority( UILayoutPriority.required, for: .vertical)
    
        alertBackgroundView.addSubview(actionButtonContainerView)
        
        
        self.addConstraint(NSLayoutConstraint(item: alertBackgroundView!, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        
        // MARK: 此处是弹窗 默认的宽度
        var alertBackgroundViewWidth = (UIApplication.shared.keyWindow?.bounds.width ?? UIScreen.main.bounds.size.width) - (38 * 2)
        if (alertBackgroundViewWidth > maximumWidth) {
            alertBackgroundViewWidth = maximumWidth
        }
        
        alertBackgroundWidthConstraint = NSLayoutConstraint(item: alertBackgroundView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: alertBackgroundViewWidth)
        self.addConstraint(alertBackgroundWidthConstraint!)
        
        backgroundViewVerticalCenteringConstraint = NSLayoutConstraint(item: alertBackgroundView!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        self.addConstraint(backgroundViewVerticalCenteringConstraint!)
        
        self.addConstraint(NSLayoutConstraint(item: alertBackgroundView!, attribute: .height, relatedBy: .lessThanOrEqual, toItem: self, attribute: .height, multiplier: 0.9, constant: 0.0))
        
        // 约束750,便于后续修改约束  
        let titleLabelCons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-51@750-[titleLabel]-51@750-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:nil, views: ["titleLabel":titleLabel as Any])
        alertBackgroundView.addConstraints(titleLabelCons)
        
        let messageCons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-24@750-[messageTextView]-24@750-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:nil, views: ["messageTextView":messageTextView as Any])
        alertBackgroundView.addConstraints(messageCons)
        
        alertBackgroundView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "H:|[contentViewContainerView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["contentViewContainerView":contentViewContainerView as Any]))
        alertBackgroundView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "H:|[actionButtonContainerView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["actionButtonContainerView":actionButtonContainerView as Any]))
        alertBackgroundView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "V:|-35@750-[titleLabel]-10@750-[messageTextView]-25@750-[contentViewContainerView]-25@750-[actionButtonContainerView]-(13@750)-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["titleLabel":titleLabel as Any, "messageTextView":messageTextView as Any, "contentViewContainerView":contentViewContainerView as Any, "actionButtonContainerView":actionButtonContainerView as Any]))
    }

    // MARK: 设置间距
    private func setTitleLeadingAndTrailingPadding(_ padding: NSInteger) {
        let metrics = ["padding": NSNumber(integerLiteral: padding)]
        alertBackgroundView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "H:|-padding-[titleLabel]-padding-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel":titleLabel as Any]))
    }
    
    private func setMessageLeadingAndTrailingPadding(_ padding: NSInteger) {
        let metrics = ["padding": NSNumber(integerLiteral: padding)]
        alertBackgroundView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "H:|-padding-[messageTextView]-padding-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["messageTextView":messageTextView as Any]))
    }
    
    private func setButtonBottomMargin(_ margin: NSInteger) {
        let metrics = ["margin": NSNumber(integerLiteral: margin)]
        alertBackgroundView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "V:|-35@750-[titleLabel]-10@750-[messageTextView]-25@750-[contentViewContainerView]-25@750-[actionButtonContainerView]-margin-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel":titleLabel as Any, "messageTextView":messageTextView as Any, "contentViewContainerView":contentViewContainerView as Any, "actionButtonContainerView":actionButtonContainerView as Any]))
    }
    
    private func setTitleTopMargin(Margin: NSInteger) {
        let metrics = ["margin": NSNumber(integerLiteral: Margin)]
        alertBackgroundView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "V:|-margin-[titleLabel]-10@750-[messageTextView]-25@750-[contentViewContainerView]-25@750-[actionButtonContainerView]-(13@750)-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel":titleLabel as Any, "messageTextView":messageTextView as Any, "contentViewContainerView":contentViewContainerView as Any, "actionButtonContainerView":actionButtonContainerView as Any]))
    }
    
    private func setMessageTopMargin(margin: Int) {
        let metrics = ["margin": NSNumber(integerLiteral: margin)]
        alertBackgroundView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "V:|-35@750-[titleLabel]-margin-[messageTextView]-25@750-[contentViewContainerView]-25@750-[actionButtonContainerView]-(13@750)-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel":titleLabel as Any, "messageTextView":messageTextView as Any, "contentViewContainerView":contentViewContainerView as Any, "actionButtonContainerView":actionButtonContainerView as Any]))
    }
    
    private func setMessageWithButtonMargin(Margin: NSInteger) {
        let metrics = ["margin": NSNumber(integerLiteral: Margin)]
        alertBackgroundView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "V:|-35@750-[titleLabel]-10@750-[messageTextView]-25@750-[contentViewContainerView]-margin-[actionButtonContainerView]-(13@750)-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel":titleLabel as Any, "messageTextView":messageTextView as Any, "contentViewContainerView":contentViewContainerView as Any, "actionButtonContainerView":actionButtonContainerView as Any]))
    }
    
    private func setMessageAlignment(_ alignment: NSTextAlignment) {
        messageTextView.textAlignment = alignment
    }
    
    private func setMessageHeight(_ messageHeight: NSInteger ,isScroll: Bool?) {
        if isScroll ?? false == true {
            messageTextView.isScrollEnabled = true
        }
        let metrics = ["height": NSNumber(integerLiteral: messageHeight)]
        alertBackgroundView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "V:|-35@750-[titleLabel]-10@750-[messageTextView(height)]-25@750-[contentViewContainerView]-25@750-[actionButtonContainerView]-(13@750)-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel":titleLabel as Any, "messageTextView":messageTextView as Any, "contentViewContainerView":contentViewContainerView as Any, "actionButtonContainerView":actionButtonContainerView as Any]))
    }
    
    private func setContentViewTopMargin(_ margin: NSInteger) {
        let metrics = ["top": NSNumber(integerLiteral: margin)]
        alertBackgroundView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "V:|-35@750-[titleLabel]-5@750-[messageTextView]-top-[contentViewContainerView]-25@750-[actionButtonContainerView]-(13@750)-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel":titleLabel as Any, "messageTextView":messageTextView as Any, "contentViewContainerView":contentViewContainerView as Any, "actionButtonContainerView":actionButtonContainerView as Any]))
    }
    
    private func setContentViewBottomMargin(_ margin: NSInteger) {
        let metrics = ["bottom": NSNumber(integerLiteral: margin)]
        alertBackgroundView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "V:|-35@750-[titleLabel]-10@750-[messageTextView]-25@750-[contentViewContainerView]-bottom-[actionButtonContainerView]-(13@750)-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel":titleLabel as Any, "messageTextView":messageTextView as Any, "contentViewContainerView":contentViewContainerView as Any, "actionButtonContainerView":actionButtonContainerView as Any]))
    }
    
    ///Pass through touches outside the backgroundView for the presentation controller to handle dismissal
    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for view in subviews {
            if (view.hitTest(self.convert(point, to: view), with: event) != nil) {
                return true
            }
        }
        return false
    }
    
    private func setMaximumWidth(maximumWidth: CGFloat) {
        if maximumWidth == 0 { return }
        if alertBackgroundWidthConstraint != nil {
            alertBackgroundWidthConstraint.constant = maximumWidth
        }
    }
    
    private func contentView(view: UIView, width: NSInteger, height: NSInteger) {
        self.contentView?.removeFromSuperview()
        self.contentView = view
        let metrics = ["height": NSNumber(integerLiteral: height),
                       "width": NSNumber(integerLiteral: width)]
        
        self.contentView?.translatesAutoresizingMaskIntoConstraints = false
        contentViewContainerView.addSubview(contentView!)
        
        contentViewContainerView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "H:[contentView(width)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["contentView":contentView!]))
        
        contentViewContainerView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "V:|-2-[contentView(height)]-2-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["contentView":contentView!]))
        
        contentViewContainerView.addConstraint(NSLayoutConstraint(item: contentView!, attribute: .centerX, relatedBy: .equal, toItem: contentViewContainerView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        
        contentViewContainerView.addConstraint(NSLayoutConstraint(item: contentView!, attribute: .centerY, relatedBy: .equal, toItem: contentViewContainerView, attribute: .centerY, multiplier: 1.0, constant: 0.0))
    }
    
    // 按钮默认高度 40 距离父view 上下各6
    private func setActionButtons(buttons: [UIButton]) {
        
        if buttons.count > 0 {
            for button in buttons {
                button.removeFromSuperview()
            }
        }
        
        var metrics = ["margin": NSNumber(integerLiteral: buttonSuperMargin)]
        
        //If there are 2 actions, display the buttons next to each other.
        // 横向排列
        if buttons.count == 2 && buttonArrangement == .Horizontal {
            metrics.updateValue(NSNumber(integerLiteral: buttonsSuperPadding), forKey: "padding")
            
            let firstButton = buttons[0]
            let lastButton = buttons[1]
            
            actionButtonContainerView.addSubview(firstButton)
            actionButtonContainerView.addSubview(lastButton)
            actionButtonContainerView.addConstraint(
                NSLayoutConstraint(item: firstButton,
                                   attribute: .width,
                                   relatedBy: .equal,
                                   toItem: lastButton,
                                   attribute: .width,
                                   multiplier: 1.0,
                                   constant: 0.0))
            
            actionButtonContainerView.addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat:
                    "H:|-(padding)-[firstButton]-[lastButton]-(padding)-|", options: NSLayoutConstraint.FormatOptions.alignAllCenterY, metrics: metrics, views: ["firstButton":firstButton,"lastButton":lastButton]))
            
            actionButtonContainerView.addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat:
                    "V:|-(margin)-[firstButton(40)]-(margin)-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["contentViewContainerView":contentViewContainerView as Any,"firstButton":firstButton]))
            
            actionButtonContainerView.addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat:
                    "V:[lastButton(40)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["lastButton":lastButton]))
            
        }else if buttons.count == 1 {
            //只有一个按钮,按钮的大小要定制
            //if only one button, we need to custom it.
            let theButton = buttons[0]
            actionButtonContainerView.addSubview(theButton)
            
            metrics.updateValue(NSNumber(integerLiteral: buttonSuperPadding), forKey: "padding")
            
            actionButtonContainerView.addConstraint(
                NSLayoutConstraint(item: theButton,
                                   attribute: .centerY,
                                   relatedBy: .equal,
                                   toItem: actionButtonContainerView,
                                   attribute: .centerY,
                                   multiplier: 1.0,
                                   constant: 0.0))
            
            actionButtonContainerView.addConstraint(
                NSLayoutConstraint(item: theButton,
                                   attribute: .centerX,
                                   relatedBy: .equal,
                                   toItem: actionButtonContainerView,
                                   attribute: .centerX,
                                   multiplier: 1.0,
                                   constant: 0.0))
            
            actionButtonContainerView.addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat:
                    "H:|-(padding)-[theButton]-(padding)-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["theButton":theButton]))
            
            // 设置Button的高度
            actionButtonContainerView.addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat:
                    "V:|-(margin)-[theButton(40)]-(margin)-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["contentViewContainerView":contentViewContainerView as Any, "theButton":theButton]))
            
        }else {
            metrics.updateValue(NSNumber(integerLiteral: buttonSuperPadding), forKey: "padding")
            
            for i in 0..<buttons.count {
                
                let actionButton = buttons[i]
                actionButtonContainerView.addSubview(actionButton)
                
                actionButtonContainerView.addConstraints(
                    NSLayoutConstraint.constraints(withVisualFormat:
                        "H:|-(padding)-[actionButton]-(padding)-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["actionButton":actionButton]))
                
                actionButtonContainerView.addConstraints(
                    NSLayoutConstraint.constraints(withVisualFormat:
                        "V:[actionButton(40)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["actionButton":actionButton]))
                
                
                if i == 0 {
                    actionButtonContainerView.addConstraints(
                        NSLayoutConstraint.constraints(withVisualFormat:
                            "V:|-[actionButton]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["contentViewContainerView":contentViewContainerView as Any, "actionButton":actionButton]))
                }else {
                    let previousButton = buttons[i - 1]
                    actionButtonContainerView.addConstraints(
                        NSLayoutConstraint.constraints(withVisualFormat:
                            "V:[previousButton]-[actionButton]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["previousButton":previousButton, "actionButton":actionButton]))
                }
                
                if i == buttons.count - 1 {
                    actionButtonContainerView.addConstraints(
                        NSLayoutConstraint.constraints(withVisualFormat:
                            "V:[actionButton]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["actionButton":actionButton]))
                }
                
            }
        }
    }
    
}


// MARK: 自定义TextView
class AEAlertTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        textContainerInset = UIEdgeInsets.zero
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if !self.bounds.size.equalTo(self.intrinsicContentCGSize()) {
            invalidateIntrinsicContentSize()
        }
    }
    private func intrinsicContentCGSize() -> CGSize {
        if self.text.count > 0 {
            
            return self.contentSize
        } else {
            return CGSize.zero
        }
    }
}

// MARK: 自定义alertAction
public class AEAlertViewButton: UIButton {
    
    var type: AEAlertViewButtonType?
    /// 由于新版swift中 属性有冲突 所有修改为 radius corner 默认为4
    var radiusCorner: CGFloat? {
        didSet {
            setCornerRadius(cornerRadius: radiusCorner ?? 4)
        }
    }
    /// 重新声明cornerRadius 属性
//    override var cornerRadius: CGFloat {
//        didSet {
//            setCornerRadius(cornerRadius: cornerRadius )
//        }
//    }
    
    required init?(coder aDecoder: NSCoder) {
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
        setTitleColor(UIColor.white, for: .normal)
        setTitleColor(UIColor.white, for: .highlighted)
        setTitleColor(UIColor.white, for: .disabled)
        tintColorDidChange()
    }
    
    override public func tintColorDidChange() {
        super.tintColorDidChange()
        
        if type == AEAlertViewButtonType.Filled {
            if isEnabled {
                backgroundColor = tintColor
            }
        }else {
            setTitleColor(tintColor, for: .normal)
        }
        setNeedsDisplay()
    }
    
    private func setCornerRadius(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
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
    
}

extension UIButton {
    func setBackgroundColor(color: UIColor, state: UIControl.State) {
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
