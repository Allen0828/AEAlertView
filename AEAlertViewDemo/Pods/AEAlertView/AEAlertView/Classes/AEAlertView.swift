//
//  ALAlertView.swift
//  ALAlertView
//
//  Created by Allen on 2018/9/7.
//  Copyright © 2018年 Allen. All rights reserved.

import UIKit

public enum AEAlertActionStyle {
    case Default,
    Cancel,
    Destructive
}

public enum AEAlertViewStyle {
    case Default,
    Image
}

open class AEAlertView: UIView {
    
    ///展示 Show
    open func show() {
        showAlert()
    }
    
    ///关闭 Close
    open func close() {
        closeAlert()
    }
    
    ///推荐宽度为屏幕款 * 0.7  Recommended width for screen section * 0.7
    open func setContentView(contentView: UIView, width: CGFloat, height: CGFloat) {
        content(view: contentView, width: NSInteger(width), height: NSInteger(height))
    }
    
    ///弹出标题  Title
    open var title: String? {
        didSet {
            setTitle(title: title)
        }
    }
    
    ///内容 The message displayed under the alert view's title
    open var message: String? {
        didSet {
            setMessage(message: message)
        }
    }
    
    ///内容高度如果文字超出 文字可以滚动 Content height can scroll if text exceeds text
    open var messageHeight: Int? {
        didSet {
            guard let height = messageHeight else { return }
            setMessageHeight(height: height)
        }
    }
    
    ///添加action AddAction
    open func addAction(action: AEAlertAction) {
        actions?.append(action)
    }
    
    ///alert背景色 The background color of the alert view
    open var alertViewBackgroundColor: UIColor? {
        didSet {
            setAlertViewBackgroundColor(color: alertViewBackgroundColor!)
        }
    }
    
    ///Title字体 The font used to display the title in the alert view
    open var titleFont: UIFont! {
        didSet {
            setTitleFont(font: titleFont)
        }
    }
    
    ///message字体 The font used to display the messsage in the alert view
    open var messageFont: UIFont! {
        didSet {
            setMessageFont(font: messageFont)
        }
    }
    
    ///Title字体颜色 The color used to display the alert view's title
    open var titleColor: UIColor? {
        didSet {
            setTitleColor(color: titleColor)
        }
    }
    
    ///message字体颜色 The color used to display the alert view's message
    open var messageColor: UIColor? {
        didSet {
            setMessageColor(color: messageColor)
        }
    }
    
    ///确定的背景颜色 The background color for the alert view's buttons corresponsing to default style actions
    open var buttonColor: UIColor?
    
    ///取消按钮的背景颜色 The background color for the alert view's buttons corresponsing to cancel style actions
    open var cancelButtonColor: UIColor?
    
    ///警告按钮的背景颜色 The background color for the alert view's buttons corresponsing to destructive style actions
    open var destructiveButtonColor: UIColor?
    
    ///按钮禁用时背景色 The background color for the alert view's buttons corresponsing to disabled actions
    open var disabledButtonColor: UIColor?
    
    ///确定按钮标题的颜色 The color used to display the title for buttons corresponsing to default style actions
    open var buttonTitleColor: UIColor?
    
    ///取消按钮标题的颜色 The color used to display the title for buttons corresponding to cancel style actions
    open var cancelButtonTitleColor: UIColor?
    
    ///警告按钮标题的颜色 The color used to display the title for buttons corresponsing to destructive style actions
    open var destructiveButtonTitleColor: UIColor?
    
    ///禁用状态按钮标题的颜色 The color used to display the title for buttons corresponsing to disabled actions
    open var disabledButtonTitleColor: UIColor?
    
    ///确定按钮的描边颜色 默认为空 default style actions borderColor default is nil
    open var buttonLayerBorderColor: UIColor?
    
    ///取消按钮的描边颜色 默认为空 color style actions borderColor default is nil
    open var cancelButtonLayerBorderColor: UIColor?
    
    ///警告按钮的描边颜色 默认为空 destructive style actions  borderColor default is nil
    open var destructiveButtonLayerBorderColor: UIColor?
    
    ///alertView圆角 The radius of the displayed alert view's corners
    open var alertViewCornerRadius: CGFloat?
    
    ///按钮圆角 默认4 The radius of button corners default is 4.0
    open var buttonCornerRadius: CGFloat?
    
    ///所有按钮
    open private(set) var actions: [AEAlertAction]?
    
    ///确定按钮字体 The font used for buttons
    open var buttonTitleFont: UIFont!
    
    ///取消按钮的字体 The font used for cancel buttons
    open var cancelButtonTitleFont: UIFont!
    
    ///警告按钮的字体 The font used for destructive buttons
    open var destructiveButtonTitleFont: UIFont!
    
    ///标题的Padding The leading and trailing distance for title
    open var titleLeadingAndTrailingPadding: Int? {
        didSet {
            guard let padding = titleLeadingAndTrailingPadding else { return }
            setTitleLeadingAndTrailingPadding(padding: padding)
        }
    }
    
    ///内容的Padding The leading and trailing distance for message
    open var messageLeadingAndTrailingPadding: Int? {
        didSet {
            guard let padding = messageLeadingAndTrailingPadding else { return }
            setMessageLeadingAndTrailingPadding(padding: padding)
        }
    }
    
    ///按钮距离下方Margin The bottom distance for buttons
    open var buttonBottomMargin: Int? {
        didSet {
            guard let margin = buttonBottomMargin else { return }
            setButtonBottomMargin(margin: margin)
        }
    }
    
    ///标题距离上方Margin The title top distance
    open var titleTopMargin: Int? {
        didSet {
            guard let margin = titleTopMargin else { return }
            setTitleTopMargin(margin: margin)
        }
    }
    
    ///内容距离按钮Margin Distance between message and buttons
    open var messageWithButtonMargin: Int? {
        didSet {
            guard let margin = messageWithButtonMargin else { return }
            setMessageWithButtonMargin(margin: margin)
        }
    }
    
    ///内容Alignment默认是center Default is center
    open var messageAlignment: NSTextAlignment? {
        didSet {
            guard let alignment = messageAlignment else { return }
            setMessageAlignment(alignment: alignment)
        }
    }
    
    ///自定义View距离上方Margin Content view top
    open var contentViewTopMargin: Int? {
        didSet {
            guard let margin = contentViewBottomMargin else { return }
            setContentViewTopMargin(margin: margin)
        }
    }
    
    ///自定义View距离下方Margin Content view bottom
    open var contentViewBottomMargin: Int? {
        didSet {
            guard let margin = contentViewBottomMargin else { return }
            setContentViewBottomMargin(margin: margin)
        }
    }
    
    
    public convenience init() {
        self.init(alertViewStyle: .Default, title: nil, message: nil)
    }
    
    public override convenience init(frame: CGRect) {
        self.init(alertViewStyle: .Default, title: nil, message: nil)
    }
    
    public convenience init(alertViewStyle: AEAlertViewStyle) {
        self.init(alertViewStyle: alertViewStyle, title: nil, message: nil)
    }
    
    public init(alertViewStyle: AEAlertViewStyle, title: String?, message: String?) {
        let frame = CGRect(x: 0, y: 0,
                           width: UIScreen.main.bounds.size.width,
                           height: UIScreen.main.bounds.size.height)
        super.init(frame: frame)
        
        self.alertViewStyle = alertViewStyle
        actions = NSArray() as? [AEAlertAction]
        buttonTitleFont = UIFont.systemFont(ofSize: 14)
        cancelButtonTitleFont = UIFont.systemFont(ofSize: 14)
        destructiveButtonTitleFont = UIFont.systemFont(ofSize: 14)
        
        buttonCornerRadius = 4.0
        
        if alertViewStyle == AEAlertViewStyle.Default {
            buttonColor = UIColor.orange
            buttonTitleColor = UIColor.white
            
            cancelButtonColor = UIColor.lightGray
            cancelButtonTitleColor = UIColor.white
            
            destructiveButtonColor = UIColor.white
            destructiveButtonTitleColor = UIColor.blue
        }else {
            buttonColor = UIColor.orange
            buttonTitleColor = UIColor.white
            
            cancelButtonColor = UIColor.lightGray
            cancelButtonTitleColor = UIColor.white
            
            destructiveButtonColor = UIColor.white
            destructiveButtonTitleColor = UIColor.blue
        }
        
        alertView = AEBaseAlertView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        alertView?.alertBackgroundView.backgroundColor = UIColor.white
        
        alertView?.titleLabel.text = title
        alertView?.messageTextView.text = message
        alertView?.titleLabel.textColor = UIColor.darkGray
        alertView?.messageTextView.textColor = UIColor.lightGray
        
        titleFont = UIFont.systemFont(ofSize: 16)
        titleColor = UIColor.darkGray
        
        messageFont = UIFont.systemFont(ofSize: 15)
        messageColor = UIColor.lightGray
        
        addSubview(alertView!)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private var alertView: AEBaseAlertView?
    private var alertViewStyle: AEAlertViewStyle?
    
    
    private func showAlert() {
        
        createActionButtons()
        UIApplication.shared.delegate?.window??.addSubview(self)
        
        alertView?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        alertView?.alpha = 0
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseInOut,
                       animations: {
                        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
                        self.alertView?.transform = CGAffineTransform(scaleX: 1, y: 1)
                        self.alertView?.alpha = 1
        },
                       completion: nil)
    }
    
    private func closeAlert() {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            self.alertView?.alpha = 0
            self.alpha = 0
        }) { (finished) in
            for view in self.subviews {
                view.removeFromSuperview()
            }
            self.removeFromSuperview()
        }
    }
    
    private func createActionButtons() {
        
        let buttons = NSMutableArray()
        
        guard let actionsCount = actions?.count else {
            return
        }
        for i in 0..<actionsCount {
            
            let action = actions![i]
            let button = AEAlertViewButton(type: .custom)
            
            button.contentEdgeInsets = UIEdgeInsetsMake(-15, -15, -15, -15)
            button.tag = i
            button.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
            button.isEnabled = action.enabled ?? true
            button.cornerRadius = buttonCornerRadius
            button.type = AEAlertViewButtonType.Bordered
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(action.title, for: .normal)
            button.setTitleColor(disabledButtonTitleColor, for: .disabled)
            button.setBackgroundColor(color: disabledButtonColor ?? UIColor.darkGray, state: .disabled)
            
            if action.style == AEAlertActionStyle.Cancel {
                
                button.setTitleColor(cancelButtonTitleColor, for: .normal)
                button.setTitleColor(cancelButtonTitleColor, for: .highlighted)
                button.setBackgroundColor(color: cancelButtonColor!, state: .normal)
                button.setBackgroundColor(color: cancelButtonColor!, state: .highlighted)
                button.titleLabel?.font = cancelButtonTitleFont
                
                if cancelButtonLayerBorderColor != nil {
                    button.layer.borderWidth = 1.0
                    button.layer.borderColor = cancelButtonLayerBorderColor?.cgColor
                }else {
                    button.layer.borderWidth = 0.0
                }
                
            }else if action.style == AEAlertActionStyle.Destructive {
                
                button.setTitleColor(destructiveButtonTitleColor, for: .normal)
                button.setTitleColor(destructiveButtonTitleColor, for: .highlighted)
                button.setBackgroundColor(color: destructiveButtonColor!, state: .normal)
                button.setBackgroundColor(color: destructiveButtonColor!, state: .highlighted)
                button.titleLabel?.font = destructiveButtonTitleFont
                if alertViewStyle == AEAlertViewStyle.Image {
                    button.type = AEAlertViewButtonType.Filled
                }
                if destructiveButtonLayerBorderColor != nil {
                    button.layer.borderWidth = 1.0
                    button.layer.borderColor = destructiveButtonLayerBorderColor?.cgColor
                }else {
                    button.layer.borderWidth = 0.0
                }
            } else {
                
                button.setTitleColor(buttonTitleColor, for: .normal)
                button.setTitleColor(buttonTitleColor, for: .highlighted)
                button.setBackgroundColor(color: buttonColor!, state: .normal)
                button.setBackgroundColor(color: buttonColor!, state: .highlighted)
                button.titleLabel?.font = buttonTitleFont
                if buttonLayerBorderColor != nil {
                    button.layer.borderWidth = 1.0
                    button.layer.borderColor = buttonLayerBorderColor?.cgColor
                }else {
                    button.layer.borderWidth = 0.0
                }
            }
            
            buttons.add(button)
            action.actionButton = button
        }
        alertView?.actionButtons = buttons as? [AEAlertViewButton]
    }
    
    
    @objc private func actionButtonPressed(button: AEAlertViewButton) {
        
        let action = self.actions![button.tag]
        if action.handler != nil {
            action.handler!(action)
        }
    }
    
    private func setTitle(title: String?) {
        alertView?.titleLabel.text = title
    }
    
    private func setMessage(message: String?) {
        alertView?.messageTextView.text = message
    }
    
    private func setTitleFont(font: UIFont) {
        alertView?.titleLabel.font = font
    }
    
    private func setMessageFont(font: UIFont) {
        alertView?.messageTextView.font = font
    }
    
    private func setTitleColor(color: UIColor?) {
        alertView?.titleLabel.textColor = color
    }
    
    private func setMessageColor(color: UIColor?) {
        alertView?.messageTextView.textColor = color
    }
    
    
    private func content(view: UIView, width: NSInteger, height: NSInteger) {
        alertView?.setContentView(contentView: view, width: width, height: height)
    }
    
    private func setTitleLeadingAndTrailingPadding(padding: Int) {
        alertView?.titleLeadingAndTrailingPadding = NSInteger(padding)
    }
    
    private func setMessageLeadingAndTrailingPadding(padding: Int) {
        alertView?.messageLeadingAndTrailingPadding = NSInteger(padding)
    }
    
    private func setButtonBottomMargin(margin: Int) {
        alertView?.buttonBottomMargin = NSInteger(margin)
    }
    
    private func setTitleTopMargin(margin: Int) {
        alertView?.titleTopMargin = NSInteger(margin)
    }
    
    private func setMessageWithButtonMargin(margin: Int) {
        alertView?.messageWithButtonMargin = NSInteger(margin)
    }
    
    private func setMessageAlignment(alignment: NSTextAlignment) {
        alertView?.messageAlignment = alignment
    }
    
    private func setMessageHeight(height: Int) {
        alertView?.messageHeight = NSInteger(height)
    }
    
    private func setContentViewTopMargin(margin: Int) {
        alertView?.contentViewTopMargin = NSInteger(margin)
    }
    
    private func setContentViewBottomMargin(margin: Int) {
        alertView?.contentViewBottomMargin = NSInteger(margin)
    }
    
    private func setAlertViewBackgroundColor(color: UIColor) {
        alertView?.alertBackgroundView.backgroundColor = color
    }
    
    
}

public class AEAlertAction: NSObject {
    
    public init(title: String, style: AEAlertActionStyle, handler:@escaping (_ action: AEAlertAction)->()) {
        self.title = title
        self.style = style
        self.handler = handler
    }
    
    public var title: String?
    public var style: AEAlertActionStyle?
    public var handler:((_ action: AEAlertAction)->())?
    public var enabled: Bool? {
        didSet {
            setEnabled(enabled: enabled ?? true)
        }
    }
    
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



