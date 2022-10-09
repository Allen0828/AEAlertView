//
//  AEBaseAlertView.swift
//  AEAlertView
//
//  代码地址: https://github.com/Allen0828/AEAlertView
//  Copyright © 2017年 Allen. All rights reserved.
//

import UIKit

/// alertView 样式
public enum AEBaseAlertViewStyle {
    case apple,
    custom
}

/// 按钮排列方式 只有两个按钮时生效
public enum AEButtonArrangementMode {
    case horizontal,
    vertical
}

// open Func
extension AEBaseAlertView {
    // FUNC 推荐宽小于等于 UIScreen.main.bounds.size.width - (24 * 2)
    /// 设置自定义view 1
    public func setContent(view: UIView, width: CGFloat, height: CGFloat) {
        setView(content: view, width, height)
    }
    /// 设置自定义view 2
    public func setCustom(view: UIView, width: CGFloat, height: CGFloat) {
        setView(custom: view, width, height)
    }
    /// 通过路径Path设置背景图 支持GIF  通过路径设置 Bundle.main.path(forResource name: String?, ofType ext: String?)
    public func setBackgroundImage(contentsOf file: String?) {
        setImage(contentsOf: file)
    }
}

open class AEBaseAlertView: UIView {
    
    /// 最大宽度 请在init中赋值 为了适配iPad 默认值改为320
    private(set) var maximumWidth: CGFloat = 320
    

    public func dismiss() {
        for item in self.subviews {
            item.removeFromSuperview()
        }
    }
    
    /// Apple style same as system. custom style The buttons are more visual
    public var alertStyle: AEBaseAlertViewStyle = .apple
    
    // 基础控件 不能改变值 只能修改属性 如颜色 圆角等
    // You cannot change the value. You can only modify the property
    public var backgroundView: UIView!
    public var backgroundImage: UIImageView!
    public var titleLabel: UILabel!
    public var messageTextView: AEAlertTextView!
    public var actionContainerView: UIView!
    // 自定义view 最多只能设置两个自定义View Must use func setCustom setContent set view
    private(set) var contentView: UIView?
    private(set) var customView: UIView?
    
    // 按钮属性
    /// 如果不设置 会自动计算按钮文字 根据设置的numberOfLines来计算最高高度
    public var actionHeight: CGFloat = -1
    public var actionPadding: CGFloat = 8
    public var actionTitleSize: CGFloat = 14
    /// customStyle 按钮上下的间距, 在appleStyle中设置无效 / The space between the top and bottom of the customstyle button, invalid in applestyle
    public var actionMargin: CGFloat = 8
    /// 按钮排列方式 只有2个按钮时生效  1个按钮或多个按钮都为垂直排列 /Only two buttons are effective. One or more buttons are arranged vertically.  默认2两个按钮 horizontal
    public var actionArrangementMode: AEButtonArrangementMode = .horizontal
    public var actionSplitLine: UIColor = UIColor(white: 0.88, alpha: 1.0)
    public var actionList: [UIButton]? {
        didSet { setActionButtons(actionList) }
    }
    
    // 距离大小设置
    /// backgroundImageBottomMargin  注 (如果你的内容高过了图片的高度, 图片会被拉伸 除非你设置了backgroundImageHeight)  设置0 = (使用backgroundImage的高度)
    public var backgroundImageBottomMargin: CGFloat = 0 {
        didSet { setBackgroundImageBottomMargin(margin: backgroundImageBottomMargin) }
    }
    /// 手动设置图片高度 注：可能会导致图片拉伸 需要设置contentMode
    public var backgroundImageHeight: CGFloat = 0 {
        didSet { setBackgroundImageHeight(height: backgroundImageHeight) }
    }
    /// 标题距离背景顶部的间距  /The distance between the title and the top of the background
    public var titleTopMargin: CGFloat = 0 {
        didSet { setTitleTopMargin(margin: titleTopMargin) }
    }
    /// 标题左右的间距 /Space left and right of title
    public var titlePadding: CGFloat = 0  {
        didSet { setTitlePadding(padding: titlePadding) }
    }
    /// message距离标题的间距  /Distance between content and title
    public var messageTopMargin: CGFloat = 0 {
        didSet { setMessageTopMargin(margin: messageTopMargin) }
    }
    /// message左右的间距 /Space left and right of title
    public var messagePadding: CGFloat = 0  {
        didSet { setMessagePadding(padding: messagePadding) }
    }
    /// message最大的高度，如果内容过多 设置此属性后，内容可以滑动 /Maximum height of message. If there are too many contents, the content can slide after this property is set.
    public var messageHeight: CGFloat = 0 {
        didSet { setMessageHeight(height: messageHeight) }
    }
    /// 自定义view1 距离动画view的间距 /Custom view2 distance custom view distance
    public var contentViewTopMargin: CGFloat = 0 {
        didSet { setContentViewTopMargin(margin: contentViewTopMargin) }
    }
    /// 自定义view2 距离内容间距 /custom view2 distance message spacing
    public var customViewTopMargin: CGFloat = 0 {
        didSet { setCustomViewTopMargin(margin: customViewTopMargin) }
    }
    /// actionView距离自定义view的间距 /Distance between actionview and custom view
    public var actionViewTopMargin: CGFloat = 0 {
        didSet { setActionViewTopMargin(margin: actionViewTopMargin) }
    }
    /// actionView距离弹窗底部的间距 默认为0 /Distance between actionview and the bottom of the pop-up window
    public var actionViewBottomMargin: CGFloat = 0 {
        didSet { setActionViewBottomMargin(margin: actionViewBottomMargin) }
    }
    
    
    public override convenience init(frame: CGRect) {
        if UIScreen.main.bounds.size.width-48 > 320 {
            self.init(frame: frame, maximumWidth: 320)
        } else {
            self.init(frame: frame, maximumWidth: UIScreen.main.bounds.size.width-48)
        }
    }
    public init(frame: CGRect, maximumWidth: CGFloat) {
        super.init(frame: frame)
        self.maximumWidth = maximumWidth
        config()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        debugPrint("AEBaseAlertView-deinit")
    }
    
    private var backgroundWidthConstraint: NSLayoutConstraint!
    private var backgroundViewVerticalCentering: NSLayoutConstraint!
    private var backgroundImageVerticalCentering: [NSLayoutConstraint]!
    private var contentContainerView: UIView!
    private var customContainerView: UIView!
}

extension AEBaseAlertView {
    private func config() {
        if !Thread.isMainThread {
            debugPrint("warning----Is not currently the main thread---⚠️⚠️⚠️⚠️")
        }
        backgroundView = UIView(frame: CGRect.zero)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = UIColor.white
        backgroundView.layer.cornerRadius = 8
        backgroundView.layer.masksToBounds = true
        addSubview(backgroundView)
        
        // 设置backgroundView 约束
        addConstraint(NSLayoutConstraint(item: backgroundView!, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        backgroundWidthConstraint = NSLayoutConstraint(item: backgroundView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: maximumWidth)
        addConstraint(backgroundWidthConstraint)
        backgroundViewVerticalCentering = NSLayoutConstraint(item: backgroundView!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        addConstraint(backgroundViewVerticalCentering)
        addConstraint(NSLayoutConstraint(item: backgroundView!, attribute: .height, relatedBy: .lessThanOrEqual, toItem: self, attribute: .height, multiplier: 0.9, constant: 0))
        
        initBackgroundImage()
        initSubviews()
    }
    
    /// 设置图片
    private func initBackgroundImage() {
        backgroundImage = UIImageView()
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.isUserInteractionEnabled = true
        
        backgroundView.addSubview(backgroundImage)
        let imgCons = NSLayoutConstraint.constraints(withVisualFormat: "H:|[backgroundImage]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["backgroundImage": backgroundImage!])
        backgroundView.addConstraints(imgCons)
    }
    
    private func initSubviews() {
        let option = NSLayoutConstraint.FormatOptions(rawValue: 0)
        titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        backgroundView.addSubview(titleLabel)
        // 设置控件约束 默认750
        let titleCons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel]-|", options: option, metrics: nil, views: ["titleLabel": titleLabel!])
        backgroundView.addConstraints(titleCons)
        
        messageTextView = AEAlertTextView(frame: CGRect.zero)
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
        messageTextView.textAlignment = .center
        messageTextView.font = UIFont.preferredFont(forTextStyle: .subheadline)
        messageTextView.setContentHuggingPriority(.required, for: .vertical)
        messageTextView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        messageTextView.allowsEditingTextAttributes = false
        messageTextView.isScrollEnabled = false
        messageTextView.isEditable = false
        messageTextView.textColor = UIColor.darkGray
        messageTextView.backgroundColor = UIColor.clear
        backgroundView.addSubview(messageTextView)
        let messageCons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[messageTextView]-|", options: option, metrics: nil, views: ["messageTextView": messageTextView!])
        backgroundView.addConstraints(messageCons)
        
        contentContainerView = UIView(frame: CGRect.zero)
        contentContainerView.translatesAutoresizingMaskIntoConstraints = false
        contentContainerView.setContentCompressionResistancePriority(.required, for: .vertical)
        backgroundView.addSubview(contentContainerView)
        let contentCons = NSLayoutConstraint.constraints(withVisualFormat: "H:|[contentContainerView]|", options: option, metrics: nil, views: ["contentContainerView": contentContainerView!])
        backgroundView.addConstraints(contentCons)
        
        customContainerView = UIView(frame: CGRect.zero)
        customContainerView.translatesAutoresizingMaskIntoConstraints = false
        customContainerView.setContentCompressionResistancePriority(.required, for: .vertical)
        backgroundView.addSubview(customContainerView)
        let customCons = NSLayoutConstraint.constraints(withVisualFormat: "H:|[customContainerView]|", options: option, metrics: nil, views: ["customContainerView": customContainerView!])
        backgroundView.addConstraints(customCons)
        
        actionContainerView = UIView(frame: CGRect.zero)
        actionContainerView.translatesAutoresizingMaskIntoConstraints = false
        actionContainerView.setContentCompressionResistancePriority(.required, for: .vertical)
        backgroundView.addSubview(actionContainerView)
        
        let actionCons = NSLayoutConstraint.constraints(withVisualFormat: "H:|[actionContainerView]|", options: option, metrics: nil, views: ["actionContainerView": actionContainerView!])
        backgroundView.addConstraints(actionCons)
        
        let verticalCons = NSLayoutConstraint.constraints(withVisualFormat: "V:|-20@750-[titleLabel]-10@750-[messageTextView]-5@750-[contentContainerView]-5@750-[customContainerView]-20@750-[actionContainerView]|", options: option, metrics: nil, views: ["titleLabel": titleLabel!, "messageTextView": messageTextView!, "contentContainerView": contentContainerView!, "customContainerView": customContainerView!,"actionContainerView": actionContainerView!])
        backgroundView.addConstraints(verticalCons)
    }
}

// MARK: - 设置两个自定义view
extension AEBaseAlertView {
    private func setView(content: UIView, _ w: CGFloat, _ h: CGFloat) {
        self.contentView?.removeFromSuperview()
        self.contentView = content
        let metrics = ["height": NSNumber(floatLiteral: Double(h)),
                       "width": NSNumber(floatLiteral: Double(w))]
        self.contentView?.translatesAutoresizingMaskIntoConstraints = false
        contentContainerView.addSubview(contentView!)
        
        contentContainerView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "H:[content(width)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["content":contentView!]))
        contentContainerView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "V:|[content(height)]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["content":contentView!]))
        
        contentContainerView.addConstraint(NSLayoutConstraint(item: contentView!, attribute: .centerX, relatedBy: .equal, toItem: contentContainerView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        contentContainerView.addConstraint(NSLayoutConstraint(item: contentView!, attribute: .centerY, relatedBy: .equal, toItem: contentContainerView, attribute: .centerY, multiplier: 1.0, constant: 0.0))
    }
    
    private func setView(custom: UIView, _ w: CGFloat, _ h: CGFloat) {
        self.customView?.removeFromSuperview()
        self.customView = custom
        let metrics = ["height": NSNumber(floatLiteral: Double(h)),
                       "width": NSNumber(floatLiteral: Double(w))]
        self.customView?.translatesAutoresizingMaskIntoConstraints = false
        customContainerView.addSubview(customView!)
        
        customContainerView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "H:[custom(width)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["custom":customView!]))
        customContainerView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "V:|[custom(height)]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["custom":customView!]))
        
        customContainerView.addConstraint(NSLayoutConstraint(item: customView!, attribute: .centerX, relatedBy: .equal, toItem: customContainerView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        customContainerView.addConstraint(NSLayoutConstraint(item: customView!, attribute: .centerY, relatedBy: .equal, toItem: customContainerView, attribute: .centerY, multiplier: 1.0, constant: 0.0))
    }
}

// MARK: - 距离设置
extension AEBaseAlertView {
    private func setBackgroundImageBottomMargin(margin: CGFloat) {
        if backgroundImage.image != nil {
            if backgroundImageVerticalCentering != nil {
                backgroundView.removeConstraints(backgroundImageVerticalCentering)
            }
            // 图片过大时 只按照当前屏幕的最高值显示图片 最大高度 弹窗高 * 0.9
            var height: CGFloat = backgroundImageHeight == 0 ? backgroundImage.image!.size.height : backgroundImageHeight
            if height > (self.frame.size.height * 0.9) - margin {
                height = self.frame.size.height * 0.9 - margin
            }
            let metrics = ["margin":  NSNumber(floatLiteral: Double(margin)),
                           "height": NSNumber(floatLiteral: Double(height))]
            backgroundImageVerticalCentering = NSLayoutConstraint.constraints(withVisualFormat: "V:|[backgroundImage(height)]-margin-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["backgroundImage": backgroundImage!])
            backgroundView.addConstraints(backgroundImageVerticalCentering)
        }
    }
    private func setBackgroundImageHeight(height: CGFloat) {
        if backgroundImage.image != nil {
            if backgroundImageVerticalCentering != nil {
                backgroundView.removeConstraints(backgroundImageVerticalCentering)
            }
            let metrics = ["margin":  NSNumber(floatLiteral: Double(backgroundImageBottomMargin)),
                           "height": NSNumber(floatLiteral: Double(height))]
            backgroundImageVerticalCentering = NSLayoutConstraint.constraints(withVisualFormat: "V:|[backgroundImage(height)]-margin-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["backgroundImage": backgroundImage!])
            backgroundView.addConstraints(backgroundImageVerticalCentering)
        }
    }
    
    private func setTitleTopMargin(margin: CGFloat) {
        let metrics = ["margin":  NSNumber(floatLiteral: Double(margin))]
        let format = "V:|-margin-[titleLabel]-10@750-[messageTextView]-5@750-[contentContainerView]-5@750-[customContainerView]-20@750-[actionContainerView]|"
        let cons = NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel": titleLabel!, "messageTextView": messageTextView!,"contentContainerView": contentContainerView!,  "customContainerView": customContainerView!, "actionContainerView": actionContainerView!])
        backgroundView.addConstraints(cons)
    }
    private func setTitlePadding(padding: CGFloat) {
        let metrics = ["padding": NSNumber(floatLiteral: Double(padding))]
        let cons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-padding-[titleLabel]-padding-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel": titleLabel!])
        backgroundView.addConstraints(cons)
    }
    private func setMessageTopMargin(margin: CGFloat) {
        let metrics = ["margin":  NSNumber(floatLiteral: Double(margin))]
        let format = "V:|-20@750-[titleLabel]-margin-[messageTextView]-5@750-[contentContainerView]-5@750-[customContainerView]-20@750-[actionContainerView]|"
        let cons = NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel": titleLabel!, "messageTextView": messageTextView!,"contentContainerView": contentContainerView!,  "customContainerView": customContainerView!, "actionContainerView": actionContainerView!])
        backgroundView.addConstraints(cons)
    }
    private func setMessagePadding(padding: CGFloat) {
        let metrics = ["padding": NSNumber(floatLiteral: Double(padding))]
        let cons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-padding-[messageTextView]-padding-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["messageTextView": messageTextView!])
        backgroundView.addConstraints(cons)
    }
    private func setMessageHeight(height: CGFloat) {
        messageTextView.isScrollEnabled = true
        let metrics = ["height": NSNumber(floatLiteral: Double(height))]
        let cons = NSLayoutConstraint.constraints(withVisualFormat: "V:|-20@750-[titleLabel]-10@750-[messageTextView(height)]-5@750-[contentContainerView]-5@750-[customContainerView]-20@750-[actionContainerView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel": titleLabel!, "messageTextView": messageTextView!, "contentContainerView": contentContainerView!, "customContainerView": customContainerView!, "actionContainerView": actionContainerView!])
        backgroundView.addConstraints(cons)
    }
    private func setContentViewTopMargin(margin: CGFloat) {
        let metrics = ["margin":  NSNumber(floatLiteral: Double(margin))]
        let format = "V:|-20@750-[titleLabel]-10@750-[messageTextView]-margin-[contentContainerView]-5@750-[customContainerView]-20@750-[actionContainerView]|"
        let cons = NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel": titleLabel!, "messageTextView": messageTextView!, "contentContainerView": contentContainerView!, "customContainerView": customContainerView!, "actionContainerView": actionContainerView!])
        backgroundView.addConstraints(cons)
    }
    private func setCustomViewTopMargin(margin: CGFloat) {
        let metrics = ["margin":  NSNumber(floatLiteral: Double(margin))]
        let format = "V:|-20@750-[titleLabel]-10@750-[messageTextView]-5@750-[contentContainerView]-margin-[customContainerView]-20@750-[actionContainerView]|"
        let cons = NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel": titleLabel!, "messageTextView": messageTextView!,"contentContainerView": contentContainerView!,  "customContainerView": customContainerView!, "actionContainerView": actionContainerView!])
        backgroundView.addConstraints(cons)
    }
    private func setActionViewTopMargin(margin: CGFloat) {
        let metrics = ["margin":  NSNumber(floatLiteral: Double(margin))]
        let format = "V:|-20@750-[titleLabel]-10@750-[messageTextView]-5@750-[contentContainerView]-5@750-[customContainerView]-margin-[actionContainerView]|"
        let cons = NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel": titleLabel!, "messageTextView": messageTextView!, "contentContainerView": contentContainerView!, "customContainerView": customContainerView!, "actionContainerView": actionContainerView!])
        backgroundView.addConstraints(cons)
    }
    private func setActionViewBottomMargin(margin: CGFloat) {
        let metrics = ["margin":  NSNumber(floatLiteral: Double(margin))]
        let format = "V:|-20@750-[titleLabel]-10@750-[messageTextView]-5@750-[contentContainerView]-5@750-[customContainerView]-20@750-[actionContainerView]-margin-|"
        let cons = NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel": titleLabel!, "messageTextView": messageTextView!, "contentContainerView": contentContainerView!, "customContainerView": customContainerView!,"actionContainerView": actionContainerView!])
        backgroundView.addConstraints(cons)
    }
}

// MARK: 按钮设置
extension AEBaseAlertView {
    private func setActionButtons(_ actions: [UIButton]?) {
        guard let btns = actions else { return }
        for btn in btns {
            btn.removeFromSuperview()
        }
        if btns.count == 0 {
            for item in actionContainerView.subviews {
                item.removeFromSuperview()
            }
            let option = NSLayoutConstraint.FormatOptions(rawValue: 0)
            let actionCons = NSLayoutConstraint.constraints(withVisualFormat: "H:|[actionContainerView]|", options: option, metrics: nil, views: ["actionContainerView": actionContainerView!])
            backgroundView.addConstraints(actionCons)
            
            let verticalCons = NSLayoutConstraint.constraints(withVisualFormat: "V:|-20@750-[titleLabel]-10@750-[messageTextView]-5@750-[contentContainerView]-5@750-[customContainerView]-20@750-|", options: option, metrics: nil, views: ["titleLabel": titleLabel!, "messageTextView": messageTextView!, "contentContainerView": contentContainerView!, "customContainerView": customContainerView!])
            backgroundView.addConstraints(verticalCons)
        } else {
            let option = NSLayoutConstraint.FormatOptions(rawValue: 0)
            let verticalCons = NSLayoutConstraint.constraints(withVisualFormat: "V:|-20@750-[titleLabel]-10@750-[messageTextView]-5@750-[contentContainerView]-5@750-[customContainerView]-20@750-[actionContainerView]|", options: option, metrics: nil, views: ["titleLabel": titleLabel!, "messageTextView": messageTextView!, "contentContainerView": contentContainerView!, "customContainerView": customContainerView!, "actionContainerView": actionContainerView!])
            backgroundView.addConstraints(verticalCons)
            if alertStyle == .apple {
                setAppleStyleActions(btns)
            } else {
                setCustomStyleActions(btns)
            }
        }
    }
    
    private func setAppleStyleActions(_ actions: [UIButton]) {
        var width = maximumWidth - 2
        if actions.count == 2 && actionArrangementMode == .horizontal {
            width = (maximumWidth-2)/2-actionPadding*2
        }
        var height = actionHeight
        if height == -1 {
            let maxH = actionHeight == -1 ? getMaxTextHeight(actions: actions, width: width) : actionHeight
            height = maxH <= 40 ? 40 : maxH
        }

        let metrics = ["height": NSNumber(floatLiteral: Double(height))]
        
        if actions.count == 2 && actionArrangementMode == .horizontal {
            let first = actions[0]
            let last = actions[1]
            first.translatesAutoresizingMaskIntoConstraints = false
            last.translatesAutoresizingMaskIntoConstraints = false

            let horizontalLine = UIView(frame: CGRect.zero)
            horizontalLine.translatesAutoresizingMaskIntoConstraints = false
            horizontalLine.backgroundColor = actionSplitLine
            
            actionContainerView.addSubview(horizontalLine)
            actionContainerView.addConstraint(NSLayoutConstraint(item: horizontalLine, attribute: .top, relatedBy: .equal, toItem: actionContainerView, attribute: .top, multiplier: 1, constant: 0))
            actionContainerView.addConstraint(NSLayoutConstraint(item: horizontalLine, attribute: .left, relatedBy: .equal, toItem: actionContainerView, attribute: .left, multiplier: 1, constant: 0))
            actionContainerView.addConstraint(NSLayoutConstraint(item: horizontalLine, attribute: .width, relatedBy: .equal, toItem: actionContainerView, attribute: .width, multiplier: 1, constant: 0))

            actionContainerView.addSubview(first)
            actionContainerView.addSubview(last)
            actionContainerView.addConstraint(NSLayoutConstraint(item: first, attribute: .width, relatedBy: .equal, toItem: last, attribute: .width, multiplier: 1, constant: 0))
            
            let verticalLine = UIView(frame: CGRect.zero)
            verticalLine.translatesAutoresizingMaskIntoConstraints = false
            verticalLine.backgroundColor = actionSplitLine
            actionContainerView.addSubview(verticalLine)
            actionContainerView.addConstraint(NSLayoutConstraint(item: verticalLine, attribute: .centerX, relatedBy: .equal, toItem: actionContainerView, attribute: .centerX, multiplier: 1, constant: 0))
            
            let btnsHCons = NSLayoutConstraint.constraints(withVisualFormat: "H:|[first][verticalLine(1)][last]|", options: NSLayoutConstraint.FormatOptions.alignAllCenterY, metrics: nil, views: ["first": first, "verticalLine": verticalLine, "last": last])
            actionContainerView.addConstraints(btnsHCons)
            let firstCons = NSLayoutConstraint.constraints(withVisualFormat: "V:|[horizontalLine(1)][first(height)]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["horizontalLine": horizontalLine, "first": first])
            actionContainerView.addConstraints(firstCons)
            let vLineCons = NSLayoutConstraint.constraints(withVisualFormat: "V:|[horizontalLine(1)][verticalLine(height)]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["horizontalLine": horizontalLine, "verticalLine": verticalLine])
            actionContainerView.addConstraints(vLineCons)
            let lastCons = NSLayoutConstraint.constraints(withVisualFormat: "V:|[horizontalLine(1)][last(height)]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["horizontalLine": horizontalLine, "last": last])
            actionContainerView.addConstraints(lastCons)
            
        } else if actions.count == 1 {
            let the = actions[0]
            the.translatesAutoresizingMaskIntoConstraints = false
            
            let horizontalLine = UIView(frame: CGRect.zero)
            horizontalLine.translatesAutoresizingMaskIntoConstraints = false
            horizontalLine.backgroundColor = actionSplitLine
            
            actionContainerView.addSubview(horizontalLine)
            actionContainerView.addConstraint(NSLayoutConstraint(item: horizontalLine, attribute: .top, relatedBy: .equal, toItem: actionContainerView, attribute: .top, multiplier: 1, constant: 0))
            actionContainerView.addConstraint(NSLayoutConstraint(item: horizontalLine, attribute: .left, relatedBy: .equal, toItem: actionContainerView, attribute: .left, multiplier: 1, constant: 0))
            actionContainerView.addConstraint(NSLayoutConstraint(item: horizontalLine, attribute: .width, relatedBy: .equal, toItem: actionContainerView, attribute: .width, multiplier: 1, constant: 0))
            
            actionContainerView.addSubview(the)
            let theHorizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:|[the]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["the":the])
            actionContainerView.addConstraints(theHorizontal)
            let theVertical = NSLayoutConstraint.constraints(withVisualFormat: "V:|[horizontalLine(1)][the(height)]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["horizontalLine": horizontalLine, "the": the])
            actionContainerView.addConstraints(theVertical)
            
        } else {
            for i in 0..<actions.count {
                let actionButton = actions[i]
                actionButton.translatesAutoresizingMaskIntoConstraints = false
                actionContainerView.addSubview(actionButton)
                let actionHorizontal = NSLayoutConstraint.constraints(withVisualFormat:
                "H:|[actionButton]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["actionButton":actionButton])
                actionContainerView.addConstraints(actionHorizontal)
                
                let actionVertical = NSLayoutConstraint.constraints(withVisualFormat:
                "V:[actionButton(height)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["actionButton":actionButton])
                actionContainerView.addConstraints(actionVertical)
                
                if i == 0 {
                    let line = UIView(frame: CGRect.zero)
                    line.translatesAutoresizingMaskIntoConstraints = false
                    line.backgroundColor = actionSplitLine
                    actionContainerView.addSubview(line)
                    let lineCons = NSLayoutConstraint.constraints(withVisualFormat: "H:|[line]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["line": line])
                    actionContainerView.addConstraints(lineCons)
                    
                    let verticalCons = NSLayoutConstraint.constraints(withVisualFormat: "V:|[line(1)][actionButton]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["contentContainerView":contentContainerView!, "line": line, "actionButton":actionButton])
                    actionContainerView.addConstraints(verticalCons)
                }else {
                    let previousButton = actions[i - 1]
                    let line = UIView(frame: CGRect.zero)
                    line.translatesAutoresizingMaskIntoConstraints = false
                    line.backgroundColor = actionSplitLine
                    actionContainerView.addSubview(line)
                    
                    let lineCons = NSLayoutConstraint.constraints(withVisualFormat: "H:|[line]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["line":line])
                    actionContainerView.addConstraints(lineCons)
                    
                    let verticalCons = NSLayoutConstraint.constraints(withVisualFormat: "V:[previousButton][line(1)][actionButton]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["previousButton":previousButton, "line": line, "actionButton":actionButton])
                    actionContainerView.addConstraints(verticalCons)
                }
                if i == actions.count - 1 {
                    let lastCons = NSLayoutConstraint.constraints(withVisualFormat: "V:[actionButton]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["actionButton":actionButton])
                    actionContainerView.addConstraints(lastCons)
                }
            }
        }
        for item in actions {
            if let btn = item as? AEAlertViewButton {
                btn.setButtonEdgeInsets()
            }
        }
    }
    
    private func setCustomStyleActions(_ actions: [UIButton]) {
        var width = maximumWidth - 2
        if actions.count == 2 && actionArrangementMode == .horizontal {
            width = maximumWidth/2-actionPadding*2
        }
        var height = actionHeight
        if height == -1 {
            let maxH = actionHeight == -1 ? getMaxTextHeight(actions: actions, width: width) : actionHeight
            height = maxH <= 40.0 ? 40.0 : maxH
        }
        
        
        let metrics = ["height": NSNumber(floatLiteral: Double(height)), "padding": NSNumber(floatLiteral: Double(actionPadding)), "margin": NSNumber(floatLiteral: Double(actionMargin))]
            
        if actions.count == 2 && actionArrangementMode == .horizontal {
            let first = actions[0]
            let last = actions[1]
            first.translatesAutoresizingMaskIntoConstraints = false
            last.translatesAutoresizingMaskIntoConstraints = false

            actionContainerView.addSubview(first)
            actionContainerView.addSubview(last)
            actionContainerView.addConstraint(NSLayoutConstraint(item: first, attribute: .width, relatedBy: .equal, toItem: last, attribute: .width, multiplier: 1.0, constant: 0.0))
            
            let actionCons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(padding)-[first]-[last]-(padding)-|", options: NSLayoutConstraint.FormatOptions.alignAllCenterY, metrics: metrics, views: ["first": first, "last": last])
            actionContainerView.addConstraints(actionCons)
            let firstCons = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(margin)-[first(height)]-(margin)-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["actionContainerView": actionContainerView!, "first": first])
            actionContainerView.addConstraints(firstCons)
            let lastCons = NSLayoutConstraint.constraints(withVisualFormat: "V:[last(height)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["last":last])
            actionContainerView.addConstraints(lastCons)
        } else if actions.count == 1 {
            let the = actions[0]
            the.translatesAutoresizingMaskIntoConstraints = false
            
            actionContainerView.addSubview(the)
            actionContainerView.addConstraint(NSLayoutConstraint(item: the, attribute: .centerY, relatedBy: .equal, toItem: actionContainerView, attribute: .centerY, multiplier: 1.0, constant: 0.0))
            actionContainerView.addConstraint(NSLayoutConstraint(item: the, attribute: .centerX, relatedBy: .equal, toItem: actionContainerView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
            
            actionContainerView.addConstraints(NSLayoutConstraint.constraints( withVisualFormat: "H:|-(padding)-[the]-(padding)-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["the":the]))
            actionContainerView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "V:|-(margin)-[the(height)]-(margin)-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["actionContainerView": actionContainerView!, "the": the]))
        } else {
            for i in 0..<actions.count {
                let actionButton = actions[i]
                actionButton.translatesAutoresizingMaskIntoConstraints = false
                actionContainerView.addSubview(actionButton)
                
                actionContainerView.addConstraints(NSLayoutConstraint.constraints( withVisualFormat: "H:|-(padding)-[actionButton]-(padding)-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["actionButton": actionButton]))
                
                actionContainerView.addConstraints(NSLayoutConstraint.constraints( withVisualFormat: "V:[actionButton(height)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["actionButton":actionButton]))
                
                if i == 0 {
                    actionContainerView.addConstraints(NSLayoutConstraint.constraints( withVisualFormat: "V:|-(margin)-[actionButton]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["actionContainerView":actionContainerView!, "actionButton":actionButton]))
                }else {
                    let previousButton = actions[i - 1]
                    actionContainerView.addConstraints(NSLayoutConstraint.constraints( withVisualFormat: "V:[previousButton]-(margin)-[actionButton]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["previousButton":previousButton, "actionButton":actionButton]))
                }
                if i == actions.count - 1 {
                    actionContainerView.addConstraints(NSLayoutConstraint.constraints( withVisualFormat: "V:[actionButton]-(margin)-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["actionButton": actionButton]))
                }
            }
        }
        for item in actions {
            if let btn = item as? AEAlertViewButton {
                btn.setButtonEdgeInsets()
            }
        }
    }
    
    private func getMaxTextHeight(actions: [UIButton], width: CGFloat) -> CGFloat {
        let maxBtn = actions.max{ ($0.currentTitle ?? "").count < ($1.currentTitle ?? "").count }
        let maxLines = maxBtn?.titleLabel?.numberOfLines ?? 1
        if maxLines == 1 {
            return 40
        }
        let maxTitle = maxBtn?.currentTitle ?? ""
        let maxFont = maxBtn?.titleLabel?.font ?? UIFont.systemFont(ofSize: 14)
        let height = maxTitle.boundingRect(with:CGSize(width: width, height:CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [.font: maxFont], context:nil).size.height
        let labelTextLines = Int(ceil(CGFloat(height) / maxFont.lineHeight))
        let intHeight = maxLines == 0 ? Int(height) : (Int(height) / labelTextLines * maxLines)
        return CGFloat(intHeight) + 6
    }
    
}

// 添加gif图片
extension AEBaseAlertView {
    private func setImage(contentsOf path: String?) {
        // 判断图片是否存在
        let url = URL(fileURLWithPath: path ?? "")
        guard let data = try? Data.init(contentsOf: url) else { return }
        if data.getImageFormat() == ImageFormat.Unknow { return }
        // 判断是否为GIF 图片
        if data.getImageFormat() == ImageFormat.GIF {
            guard let source = CGImageSourceCreateWithData(data as CFData, nil) else { return }
            let count = CGImageSourceGetCount(source)
            var images: [UIImage] = []
            var total: Double = 0
            for i in 0..<count {
                guard let pro = CGImageSourceCopyPropertiesAtIndex(source, i, nil) as? [String: Any],
                    let gifDict = pro[kCGImagePropertyGIFDictionary as String] as? [String: Any],
                    let duration = gifDict[kCGImagePropertyGIFDelayTime as String] as? Double,
                    let imgRef = CGImageSourceCreateImageAtIndex(source, i, nil) else { return }
                
                let img = UIImage(cgImage: imgRef, scale: UIScreen.main.scale, orientation: UIImage.Orientation.up) // 默认gif图片没有旋转过
                total += duration
                images.append(img)
            }
            let anImg = UIImage.animatedImage(with: images, duration: total)
            backgroundImage.image = anImg
        } else if data.getImageFormat() == ImageFormat.WebP {
            debugPrint("当前不支持显示 WebP图片")
        } else {
            backgroundImage.image = UIImage(data: data)
        }
    }
}

private enum ImageFormat {
    case Unknow
    case JPEG
    case PNG
    case GIF
    case TIFF
    case WebP
    case HEIC
    case HEIF
}
private extension Data {
    func getImageFormat() -> ImageFormat  {
        var buffer = [UInt8](repeating: 0, count: 1)
        self.copyBytes(to: &buffer, count: 1)
        
        switch buffer {
        case [0xFF]: return .JPEG
        case [0x89]: return .PNG
        case [0x47]: return .GIF
        case [0x49],[0x4D]: return .TIFF
        case [0x52] where self.count >= 12:
            if let str = String(data: self[0...11], encoding: .ascii), str.hasPrefix("RIFF"), str.hasSuffix("WEBP") {
                return .WebP
            }
        case [0x00] where self.count >= 12:
            if let str = String(data: self[8...11], encoding: .ascii) {
                let HEICBitMaps = Set(["heic", "heis", "heix", "hevc", "hevx"])
                if HEICBitMaps.contains(str) {
                    return .HEIC
                }
                let HEIFBitMaps = Set(["mif1", "msf1"])
                if HEIFBitMaps.contains(str) {
                    return .HEIF
                }
            }
        default: break;
        }
        return .Unknow
    }
}


// MARK: - AEAlertTextView
public class AEAlertTextView: UITextView {
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        textContainerInset = UIEdgeInsets.zero
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override open func layoutSubviews() {
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


extension UIApplication {
    var alertWindow: UIWindow? {
        return currentWindow()
    }
    func currentWindow() -> UIWindow? {
        if Thread.isMainThread {
            if #available(iOS 13, *) {
                let connectedScenes = UIApplication.shared.connectedScenes
                    .filter({ $0.activationState == .foregroundActive })
                    .compactMap({$0 as? UIWindowScene})
                if connectedScenes.count == 0 {
                    return UIApplication.shared.windows.first
                }
                let window = connectedScenes.first?
                    .windows
                    .first { $0.isKeyWindow }
                return window
            } else if #available(iOS 8.0, *) {
                return UIApplication.shared.delegate?.window ?? UIApplication.shared.keyWindow
            } else {
                return UIApplication.shared.windows.first { $0.isKeyWindow }
            }
        }
        return nil
    }
}
