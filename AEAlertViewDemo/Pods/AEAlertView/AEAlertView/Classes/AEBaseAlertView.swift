//
//  ALBaseAlertView.swift
//  ALAlertView
//
//  Created by Allen on 2018/9/8.
//  Copyright © 2018年 Allen. All rights reserved.
//

import UIKit

enum AEAlertViewButtonType {
    case Filled,
    Bordered
}

extension UIButton {
    func setBackgroundColor(color: UIColor, state: UIControlState) {
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


class AEBaseAlertView: UIView {
    
    var titleLabel: UILabel!
    var messageTextView: AEAlertTextView!
    var contentView: UIView?
    
    var actionButtons: [AEAlertViewButton]? {
        didSet {
            guard let buttons = actionButtons else {
                return
            }
            setActionButtons(buttons: buttons)
        }
    }
    
    private(set) var alertBackgroundView: UIView!
    private(set) var backgroundViewVerticalCenteringConstraint: NSLayoutConstraint!
    
    
    public func setContentView(contentView: UIView, width: NSInteger, height: NSInteger) {
        self.contentView(view: contentView, width: width, height: height)
    }
    
    var maximumWidth: CGFloat = 0 {
        didSet {
            if maximumWidth != 0 {
                setMaximumWidth(maximumWidth: maximumWidth)
            }
        }
    }
    var titleTopMargin: NSInteger? {
        didSet {
            setTitleTopMargin(Margin: titleTopMargin ?? 0)
        }
    }
    var titleLeadingAndTrailingPadding: NSInteger? {
        didSet {
            setTitleLeadingAndTrailingPadding(Padding: titleLeadingAndTrailingPadding ?? 0)
        }
    }
    var messageLeadingAndTrailingPadding: NSInteger? {
        didSet {
            setMessageLeadingAndTrailingPadding(Padding: messageLeadingAndTrailingPadding ?? 0)
        }
    }
    var buttonBottomMargin: NSInteger? {
        didSet {
            setButtonBottomMargin(Margin: buttonBottomMargin ?? 0)
        }
    }
    var messageWithButtonMargin: NSInteger? {
        didSet {
            setMessageWithButtonMargin(Margin: messageWithButtonMargin ?? 0)
        }
    }
    var messageAlignment: NSTextAlignment? {
        didSet {
            setMessageAlignment(Alignment: messageAlignment ?? .center)
        }
    }
    var messageHeight: NSInteger? {
        didSet {
            guard let height = messageHeight else {
                return
            }
            setMessageHeight(messageHeight: height, isScroll: true)
        }
    }
    var contentViewTopMargin: NSInteger? {
        didSet {
            setContentViewTopMargin(Margin: contentViewTopMargin ?? 0)
        }
    }
    var contentViewBottomMargin: NSInteger? {
        didSet {
            setContentViewBottomMargin(Margin: contentViewBottomMargin ?? 0)
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
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
        titleLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.white
        titleLabel.text = "Title Label"
        alertBackgroundView.addSubview(titleLabel)
        
        messageTextView = AEAlertTextView(frame: CGRect.zero)
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
        messageTextView.backgroundColor = UIColor.clear
        messageTextView.textAlignment = .center
        messageTextView.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        
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
            actionButtonContainerView.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
      
        alertBackgroundView.addSubview(actionButtonContainerView)
        
        actionButtonContainerView = UIView(frame: CGRect.zero)
        actionButtonContainerView.translatesAutoresizingMaskIntoConstraints = false
            actionButtonContainerView.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
    
        alertBackgroundView.addSubview(actionButtonContainerView)
        
        
        self.addConstraint(NSLayoutConstraint(item: alertBackgroundView!, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        
        var alertBackgroundViewWidth = (UIApplication.shared.keyWindow?.bounds.width ?? UIScreen.main.bounds.size.width) * 0.7
        if (alertBackgroundViewWidth > maximumWidth) {
            alertBackgroundViewWidth = maximumWidth
        }
        
        alertBackgroundWidthConstraint = NSLayoutConstraint(item: alertBackgroundView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: alertBackgroundViewWidth)
        self.addConstraint(alertBackgroundWidthConstraint!)
        
        backgroundViewVerticalCenteringConstraint = NSLayoutConstraint(item: alertBackgroundView!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        self.addConstraint(backgroundViewVerticalCenteringConstraint!)
        
        self.addConstraint(NSLayoutConstraint(item: alertBackgroundView!, attribute: .height, relatedBy: .lessThanOrEqual, toItem: self, attribute: .height, multiplier: 0.9, constant: 0.0))
        
        
        // 约束750,便于后续修改约束
        let titleLabelCons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-51@750-[titleLabel]-51@750-|", options: NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: ["titleLabel":titleLabel])
        alertBackgroundView.addConstraints(titleLabelCons)
        
        let messageCons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-24@750-[messageTextView]-24@750-|", options: NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: ["messageTextView":messageTextView])
        alertBackgroundView.addConstraints(messageCons)
        
        
        alertBackgroundView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "H:|[contentViewContainerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["contentViewContainerView":contentViewContainerView]))
        alertBackgroundView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "H:|[actionButtonContainerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["actionButtonContainerView":actionButtonContainerView]))
        alertBackgroundView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "V:|-35@750-[titleLabel]-5@750-[messageTextView]-25@750-[contentViewContainerView]-25@750-[actionButtonContainerView]-(13@750)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["titleLabel":titleLabel,"messageTextView":messageTextView,"contentViewContainerView":contentViewContainerView,"actionButtonContainerView":actionButtonContainerView]))
    }
    
    private var alertBackgroundWidthConstraint: NSLayoutConstraint!
    private var contentViewContainerView: UIView!
    private var actionButtonContainerView: UIView!
    
    
    private func setTitleLeadingAndTrailingPadding(Padding: NSInteger) {
        let metrics = ["padding": NSNumber(integerLiteral: Padding)]
        alertBackgroundView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "H:|-padding-[titleLabel]-padding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel":titleLabel]))
    }
    
    private func setMessageLeadingAndTrailingPadding(Padding: NSInteger) {
        let metrics = ["padding": NSNumber(integerLiteral: Padding)]
        alertBackgroundView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "H:|-padding-[messageTextView]-padding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: ["messageTextView":messageTextView]))
    }
    
    private func setButtonBottomMargin(Margin: NSInteger) {
        let metrics = ["margin": NSNumber(integerLiteral: Margin)]
        alertBackgroundView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "V:|-35@750-[titleLabel]-5@750-[messageTextView]-25@750-[contentViewContainerView]-25@750-[actionButtonContainerView]-margin-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel":titleLabel,"messageTextView":messageTextView,"contentViewContainerView":contentViewContainerView,"actionButtonContainerView":actionButtonContainerView]))
    }
    
    private func setTitleTopMargin(Margin: NSInteger) {
        let metrics = ["margin": NSNumber(integerLiteral: Margin)]
        alertBackgroundView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "V:|-margin-[titleLabel]-5@750-[messageTextView]-25@750-[contentViewContainerView]-25@750-[actionButtonContainerView]-(13@750)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel":titleLabel,"messageTextView":messageTextView,"contentViewContainerView":contentViewContainerView,"actionButtonContainerView":actionButtonContainerView]))
    }
    
    private func setMessageWithButtonMargin(Margin: NSInteger) {
        let metrics = ["margin": NSNumber(integerLiteral: Margin)]
        alertBackgroundView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "V:|-35@750-[titleLabel]-5@750-[messageTextView]-25@750-[contentViewContainerView]-margin-[actionButtonContainerView]-(13@750)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel":titleLabel,"messageTextView":messageTextView,"contentViewContainerView":contentViewContainerView,"actionButtonContainerView":actionButtonContainerView]))
    }
    
    private func setMessageAlignment(Alignment: NSTextAlignment) {
        messageTextView.textAlignment = Alignment
    }
    
    private func setMessageHeight(messageHeight: NSInteger ,isScroll: Bool?) {
        if isScroll ?? false == true {
            messageTextView.isScrollEnabled = true
        }
        let metrics = ["height": NSNumber(integerLiteral: messageHeight)]
        alertBackgroundView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "V:|-35@750-[titleLabel]-5@750-[messageTextView(height)]-25@750-[contentViewContainerView]-25@750-[actionButtonContainerView]-(13@750)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel":titleLabel,"messageTextView":messageTextView,"contentViewContainerView":contentViewContainerView,"actionButtonContainerView":actionButtonContainerView]))
    }
    
    private func setContentViewTopMargin(Margin: NSInteger) {
        let metrics = ["top": NSNumber(integerLiteral: Margin)]
        alertBackgroundView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "V:|-35@750-[titleLabel]-5@750-[messageTextView]-top-[contentViewContainerView]-25@750-[actionButtonContainerView]-(13@750)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel":titleLabel,"messageTextView":messageTextView,"contentViewContainerView":contentViewContainerView,"actionButtonContainerView":actionButtonContainerView]))
    }
    
    private func setContentViewBottomMargin(Margin: NSInteger) {
        let metrics = ["bottom": NSNumber(integerLiteral: Margin)]
        alertBackgroundView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "V:|-35@750-[titleLabel]-5@750-[messageTextView]-25@750-[contentViewContainerView]-bottom-[actionButtonContainerView]-(13@750)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel":titleLabel,"messageTextView":messageTextView,"contentViewContainerView":contentViewContainerView,"actionButtonContainerView":actionButtonContainerView]))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if messageHeight ?? 0 == 0 {
            setMessageHeight(messageHeight: NSInteger(getTextHeigh(text: messageTextView.text, font: messageTextView.font ?? UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline), width: alertBackgroundView.frame.width - 40)), isScroll: false)
        }
        
    }
    
    private func getTextHeigh(text:String,font:UIFont,width:CGFloat) -> CGFloat {
        let normalText = text as NSString
        let size = CGSize(width: width, height: 1000)
        
            let dictionary = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)
            let stringSize = normalText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dictionary as? [NSAttributedStringKey : Any], context: nil).size

            return stringSize.height
    }
    
    ///Pass through touches outside the backgroundView for the presentation controller to handle dismissal
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for view in subviews {
            if (view.hitTest(self.convert(point, to: view), with: event) != nil) {
                return true
            }
        }
        return false
    }
    
    private func setMaximumWidth(maximumWidth: CGFloat) {
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
                "H:[contentView(width)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: ["contentView":contentView!]))
        
        contentViewContainerView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "V:|-2-[contentView(height)]-2-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: ["contentView":contentView!]))
        
        contentViewContainerView.addConstraint(NSLayoutConstraint(item: contentView!, attribute: .centerX, relatedBy: .equal, toItem: contentViewContainerView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        
        contentViewContainerView.addConstraint(NSLayoutConstraint(item: contentView!, attribute: .centerY, relatedBy: .equal, toItem: contentViewContainerView, attribute: .centerY, multiplier: 1.0, constant: 0.0))
    }
    
    private func setActionButtons(buttons: [UIButton]) {
        
        if (actionButtons?.count ?? 0) > 0 {
            for button in actionButtons! {
                button.removeFromSuperview()
            }
        }
        //If there are 2 actions, display the buttons next to each other.
        if buttons.count == 2 {
            let firstButton = actionButtons![0]
            let lastButton = actionButtons![1]
            
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
            
            /// 默认间距是15
            actionButtonContainerView.addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat:
                    "H:|-15-[firstButton]-[lastButton]-15-|", options: NSLayoutFormatOptions.alignAllCenterY, metrics: nil, views: ["firstButton":firstButton,"lastButton":lastButton]))
            
            actionButtonContainerView.addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat:
                    "V:|-[firstButton(40)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["contentViewContainerView":contentViewContainerView,"firstButton":firstButton]))
            
            actionButtonContainerView.addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat:
                    "V:[lastButton(40)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["lastButton":lastButton]))
            
        }else if buttons.count == 1 {
            //只有一个按钮,按钮的大小要定制
            //if only one button, we need to custom it.
            let theButton = buttons[0]
            actionButtonContainerView.addSubview(theButton)
            
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
                    "H:|-51-[theButton]-51-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["theButton":theButton]))
            
            actionButtonContainerView.addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat:
                    "V:|-[theButton(40)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["contentViewContainerView":contentViewContainerView, "theButton":theButton]))
            
        }else {
            for i in 0..<buttons.count {
                
                let actionButton = buttons[i]
                actionButtonContainerView.addSubview(actionButton)
                
                actionButtonContainerView.addConstraints(
                    NSLayoutConstraint.constraints(withVisualFormat:
                        "H:|-51-[actionButton]-51-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["actionButton":actionButton]))
                
                actionButtonContainerView.addConstraints(
                    NSLayoutConstraint.constraints(withVisualFormat:
                        "V:[actionButton(40)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["actionButton":actionButton]))
                
                
                if i == 0 {
                    actionButtonContainerView.addConstraints(
                        NSLayoutConstraint.constraints(withVisualFormat:
                            "V:|-[actionButton]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["contentViewContainerView":contentViewContainerView, "actionButton":actionButton]))
                }else {
                    let previousButton = buttons[i - 1]
                    actionButtonContainerView.addConstraints(
                        NSLayoutConstraint.constraints(withVisualFormat:
                            "V:[previousButton]-[actionButton]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["previousButton":previousButton, "actionButton":actionButton]))
                }
                
                if i == buttons.count - 1 {
                    actionButtonContainerView.addConstraints(
                        NSLayoutConstraint.constraints(withVisualFormat:
                            "V:[actionButton]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["actionButton":actionButton]))
                }
                
            }
        }
    }
    
}



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


class AEAlertViewButton: UIButton {
    
    var type: AEAlertViewButtonType?
    var cornerRadius: CGFloat? {
        didSet {
            setCornerRadius(cornerRadius: cornerRadius ?? 0)
        }
    }
    
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
        cornerRadius = 4.0
        clipsToBounds = true
        setTitleColor(UIColor.white, for: .normal)
        setTitleColor(UIColor.white, for: .highlighted)
        setTitleColor(UIColor.white, for: .disabled)
        tintColorDidChange()
    }
    
    override func tintColorDidChange() {
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
    
    override var intrinsicContentSize: CGSize {
        get {
            if isHidden {
                return CGSize.zero
            }
            return CGSize(width: super.intrinsicContentSize.width + 12.0, height: 30.0)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        setNeedsDisplay()
    }
    
}

