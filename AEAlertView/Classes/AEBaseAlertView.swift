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

open class AEBaseAlertView: UIView {
    
    /// 标题 /Tilte
    public var titleLabel: UILabel!
    /// 内容 可以设置字体颜色 大小 对齐方式 /Messsage
    public var messageTextView: AEAlertTextView!
    /// 展示动画的View /show animation view
    public var animationView: UIView?
    /// 自定义内容View /custom content view
    public var contentView: UIView?
    
    /// alert样式 apple样式下按钮有分割线 按钮高度为40  /Apple style buttons have split lines Button height is 40
    public var alertStyle: AEBaseAlertViewStyle = .apple
    
    /// appleStyle action分割线颜色   /Split line color default:0.88 white
    public var actionSplitLine: UIColor = UIColor(white: 0.88, alpha: 1.0)
    /// 按钮排列方式 只有2个按钮时生效  1个按钮或多个按钮都为垂直排列 /Only two buttons are effective. One or more buttons are arranged vertically.  默认2两个按钮 horizontal
    public var actionArrangementMode: AEButtonArrangementMode = .horizontal
    /// 按钮高度 默认40 Button height default 40
    public var actionHeight: CGFloat = 40
    /// customStyle 按钮左右的间距, 在appleStyle中设置无效  /Spacing between left and right of customstyle button, invalid in applestyle
    public var actionPadding: CGFloat = 8
    /// customStyle 按钮上下的间距, 在appleStyle中设置无效 / The space between the top and bottom of the customstyle button, invalid in applestyle
    public var actionMargin: CGFloat = 8
    /// 按钮
    public var actionList: [UIButton]? {
        didSet {
            setActionButtons(actionList)
        }
    }

    /// 背景 可以设置颜色圆角等 默认圆角8px  /alertBackgroundView Default fillet 8
    private(set) var alertBackgroundView: UIView!
    /// 背景裁剪 默认ture /Background clipping default ture
    public var backgroundViewMasksToBounds: Bool = true {
        didSet {
            alertBackgroundView.layer.masksToBounds = backgroundViewMasksToBounds
        }
    }
    /// 背景的最大宽度 默认为屏幕宽度 - 两边间距(38 * 2) /Maximum width of bullet window. Default is Screen Width-Side Spacing(38 * 2)
    public var maximumWidth: CGFloat = UIScreen.main.bounds.size.width - (24 * 2) {
        didSet { setMaximumWidth(maximumWidth: maximumWidth) }
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
    
    /// 动画view距离内容间距 /Animation view distance message spacing
    public var animationViewTopMargin: CGFloat = 0 {
        didSet { setAnimationViewTopMargin(margin: animationViewTopMargin) }
    }
    /// 自定义view距离动画view的间距 /Custom view distance animation view distance
    public var contentViewTopMargin: CGFloat = 0 {
        didSet { setContentViewTopMargin(margin: contentViewTopMargin) }
    }
    /// actionView距离自定义view的间距 /Distance between actionview and custom view
    public var actionViewTopMargin: CGFloat = 0 {
        didSet { setActionViewTopMargin(margin: actionViewTopMargin) }
    }
    /// actionView距离弹窗底部的间距 默认为0 /Distance between actionview and the bottom of the pop-up window
    public var actionViewBottomMargin: CGFloat = 0 {
        didSet { setActionViewBottomMargin(margin: actionViewBottomMargin) }
    }

    // FUNC
    public func setAnimation(view: UIView, width: CGFloat, height: CGFloat) {
        setView(animation: view, width, height)
    }
    public func setContent(view: UIView, width: CGFloat, height: CGFloat) {
        setView(content: view, width, height)
    }
    
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var backgroundWidthConstraint: NSLayoutConstraint!
    private var backgroundViewVerticalCentering: NSLayoutConstraint!
    private var animationContainerView: UIView!
    private var contentContainerView: UIView!
    private var actionContainerView: UIView!
}

// MARK: config
extension AEBaseAlertView {
    private func commonInit() {
        alertBackgroundView = UIView(frame: CGRect.zero)
        alertBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        alertBackgroundView.backgroundColor = UIColor(white: 0.97, alpha: 1.0)
        alertBackgroundView.layer.cornerRadius = 8
        alertBackgroundView.layer.masksToBounds = backgroundViewMasksToBounds
        addSubview(alertBackgroundView)
        
        // 设置alertBackgroundView 约束
        addConstraint(NSLayoutConstraint(item: alertBackgroundView!, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
        backgroundWidthConstraint = NSLayoutConstraint(item: alertBackgroundView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: maximumWidth)
        addConstraint(backgroundWidthConstraint)
        
        backgroundViewVerticalCentering = NSLayoutConstraint(item: alertBackgroundView!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        addConstraint(backgroundViewVerticalCentering)
        
        addConstraint(NSLayoutConstraint(item: alertBackgroundView!, attribute: .height, relatedBy: .lessThanOrEqual, toItem: self, attribute: .height, multiplier: 0.9, constant: 0))
        
        initSubviews()
    }
    // 设置控件 title message等...
    private func initSubviews() {
        // options: .alignAllLeft != NSLayoutConstraint.FormatOptions(rawValue: 0)
        let option = NSLayoutConstraint.FormatOptions(rawValue: 0)
        
        titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        alertBackgroundView.addSubview(titleLabel)
        
        // 设置控件约束 默认750
        let titleCons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-51@750-[titleLabel]-51@750-|", options: option, metrics: nil, views: ["titleLabel": titleLabel!])
        alertBackgroundView.addConstraints(titleCons)
        
        messageTextView = AEAlertTextView(frame: CGRect.zero)
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
        messageTextView.textAlignment = .center
        messageTextView.font = UIFont.preferredFont(forTextStyle: .subheadline)
        messageTextView.setContentHuggingPriority(.required, for: .vertical)
        messageTextView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        messageTextView.allowsEditingTextAttributes = false
        messageTextView.isScrollEnabled = false
        messageTextView.isEditable = false
        messageTextView.textColor = UIColor.lightGray
        messageTextView.backgroundColor = UIColor.clear
        alertBackgroundView.addSubview(messageTextView)
        
        let messageCons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-24@750-[messageTextView]-24@750-|", options: option, metrics: nil, views: ["messageTextView": messageTextView!])
        alertBackgroundView.addConstraints(messageCons)
        
        animationContainerView = UIView(frame: CGRect.zero)
        animationContainerView.translatesAutoresizingMaskIntoConstraints = false
        animationContainerView.setContentCompressionResistancePriority(.required, for: .vertical)
        alertBackgroundView.addSubview(animationContainerView)
        
        let animationCons = NSLayoutConstraint.constraints(withVisualFormat: "H:|[animationContainerView]|", options: option, metrics: nil, views: ["animationContainerView": animationContainerView!])
        alertBackgroundView.addConstraints(animationCons)
        
        contentContainerView = UIView(frame: CGRect.zero)
        contentContainerView.translatesAutoresizingMaskIntoConstraints = false
        contentContainerView.setContentCompressionResistancePriority(.required, for: .vertical)
        alertBackgroundView.addSubview(contentContainerView)

        let contentCons = NSLayoutConstraint.constraints(withVisualFormat: "H:|[contentContainerView]|", options: option, metrics: nil, views: ["contentContainerView": contentContainerView!])
        alertBackgroundView.addConstraints(contentCons)

        actionContainerView = UIView(frame: CGRect.zero)
        actionContainerView.translatesAutoresizingMaskIntoConstraints = false
        actionContainerView.setContentCompressionResistancePriority(.required, for: .vertical)
        alertBackgroundView.addSubview(actionContainerView)
        
        let actionCons = NSLayoutConstraint.constraints(withVisualFormat: "H:|[actionContainerView]|", options: option, metrics: nil, views: ["actionContainerView": actionContainerView!])
        alertBackgroundView.addConstraints(actionCons)
        
        let verticalCons = NSLayoutConstraint.constraints(withVisualFormat: "V:|-20@750-[titleLabel]-10@750-[messageTextView]-5@750-[animationContainerView]-5@750-[contentContainerView]-20@750-[actionContainerView]|", options: option, metrics: nil, views: ["titleLabel": titleLabel!, "messageTextView": messageTextView!, "animationContainerView": animationContainerView!, "contentContainerView": contentContainerView!, "actionContainerView": actionContainerView!])
        alertBackgroundView.addConstraints(verticalCons)
    }
}

// MARK: 按钮设置
extension AEBaseAlertView {
    private func setActionButtons(_ buttons: [UIButton]?) {
        guard let btns = buttons else { return }
        for btn in btns {
            btn.removeFromSuperview()
        }
        if btns.count == 0 {
            for item in actionContainerView.subviews {
                item.removeFromSuperview()
            }
            let option = NSLayoutConstraint.FormatOptions(rawValue: 0)
            let actionCons = NSLayoutConstraint.constraints(withVisualFormat: "H:|[actionContainerView]|", options: option, metrics: nil, views: ["actionContainerView": actionContainerView!])
            alertBackgroundView.addConstraints(actionCons)
            
            let verticalCons = NSLayoutConstraint.constraints(withVisualFormat: "V:|-20@750-[titleLabel]-10@750-[messageTextView]-5@750-[animationContainerView]-5@750-[contentContainerView]-20@750-[actionContainerView]|", options: option, metrics: nil, views: ["titleLabel": titleLabel!, "messageTextView": messageTextView!, "animationContainerView": animationContainerView!, "contentContainerView": contentContainerView!, "actionContainerView": actionContainerView!])
            alertBackgroundView.addConstraints(verticalCons)
        }
        if alertStyle == .apple {
            setAppleStyleActions(btns)
        } else {
            setCustomStyleActions(btns)
        }
    }
    
    private func setAppleStyleActions(_ actions: [UIButton]) {
        let metrics = ["height": NSNumber(floatLiteral: Double(actionHeight))]
        
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
            let theHorizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:|[the]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["the":the])
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
    }
    
    private func setCustomStyleActions(_ actions: [UIButton]) {

        let metrics = ["height": NSNumber(floatLiteral: Double(actionHeight)), "padding": NSNumber(floatLiteral: Double(actionPadding)), "margin": NSNumber(floatLiteral: Double(actionMargin))]
            
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
    }
}

extension AEBaseAlertView {
    // 最大宽度
    private func setMaximumWidth(maximumWidth: CGFloat) {
        if maximumWidth == 0 { return }
        if backgroundWidthConstraint != nil {
            backgroundWidthConstraint.constant = maximumWidth
        }
    }
    // 标题距离上方顶部间距
    private func setTitleTopMargin(margin: CGFloat) {
        let metrics = ["margin":  NSNumber(floatLiteral: Double(margin))]
        let format = "V:|-margin-[titleLabel]-10@750-[messageTextView]-5@750-[animationContainerView]-5@750-[contentContainerView]-20@750-[actionContainerView]|"
        let cons = NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel": titleLabel!, "messageTextView": messageTextView!, "animationContainerView": animationContainerView!, "contentContainerView": contentContainerView!, "actionContainerView": actionContainerView!])
        alertBackgroundView.addConstraints(cons)
    }
    // 标题左右间距
    private func setTitlePadding(padding: CGFloat) {
        let metrics = ["padding": NSNumber(floatLiteral: Double(padding))]
        let cons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-padding-[titleLabel]-padding-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel": titleLabel!])
        alertBackgroundView.addConstraints(cons)
    }
    // 内容距离标题的间距
    private func setMessageTopMargin(margin: CGFloat) {
        let metrics = ["margin":  NSNumber(floatLiteral: Double(margin))]
        let format = "V:|-20@750-[titleLabel]-margin-[messageTextView]-5@750-[animationContainerView]-5@750-[contentContainerView]-20@750-[actionContainerView]|"
        let cons = NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel": titleLabel!, "messageTextView": messageTextView!, "animationContainerView": animationContainerView!, "contentContainerView": contentContainerView!, "actionContainerView": actionContainerView!])
        alertBackgroundView.addConstraints(cons)
    }
    // 内容左右间距
    private func setMessagePadding(padding: CGFloat) {
        let metrics = ["padding": NSNumber(floatLiteral: Double(padding))]
        let cons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-padding-[messageTextView]-padding-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["messageTextView": messageTextView!])
        alertBackgroundView.addConstraints(cons)
    }
    // message最大的高度
    private func setMessageHeight(height: CGFloat) {
        messageTextView.isScrollEnabled = true
        let metrics = ["height": NSNumber(floatLiteral: Double(height))]
        let cons = NSLayoutConstraint.constraints(withVisualFormat: "V:|-20@750-[titleLabel]-10@750-[messageTextView(height)]-5@750-[animationContainerView]-5@750-[contentContainerView]-20@750-[actionContainerView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel": titleLabel!, "messageTextView": messageTextView!, "animationContainerView": animationContainerView!, "contentContainerView": contentContainerView!, "actionContainerView": actionContainerView!])
        alertBackgroundView.addConstraints(cons)
    }
    // 动画ViewTopMargin
    private func setAnimationViewTopMargin(margin: CGFloat) {
        let metrics = ["margin":  NSNumber(floatLiteral: Double(margin))]
        let format = "V:|-20@750-[titleLabel]-10@750-[messageTextView]-margin-[animationContainerView]-5@750-[contentContainerView]-20@750-[actionContainerView]|"
        let cons = NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel": titleLabel!, "messageTextView": messageTextView!, "animationContainerView": animationContainerView!, "contentContainerView": contentContainerView!, "actionContainerView": actionContainerView!])
        alertBackgroundView.addConstraints(cons)
    }
    // 自定义viewTopMargin
    private func setContentViewTopMargin(margin: CGFloat) {
        let metrics = ["margin":  NSNumber(floatLiteral: Double(margin))]
        let format = "V:|-20@750-[titleLabel]-10@750-[messageTextView]-5@750-[animationContainerView]-margin-[contentContainerView]-20@750-[actionContainerView]|"
        let cons = NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel": titleLabel!, "messageTextView": messageTextView!, "animationContainerView": animationContainerView!, "contentContainerView": contentContainerView!, "actionContainerView": actionContainerView!])
        alertBackgroundView.addConstraints(cons)
    }
    // actionViewTopMargin
    private func setActionViewTopMargin(margin: CGFloat) {
        let metrics = ["margin":  NSNumber(floatLiteral: Double(margin))]
        let format = "V:|-20@750-[titleLabel]-10@750-[messageTextView]-5@750-[animationContainerView]-5@750-[contentContainerView]-margin-[actionContainerView]|"
        let cons = NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel": titleLabel!, "messageTextView": messageTextView!, "animationContainerView": animationContainerView!, "contentContainerView": contentContainerView!, "actionContainerView": actionContainerView!])
        alertBackgroundView.addConstraints(cons)
    }
    // actionViewBottomMargin
    private func setActionViewBottomMargin(margin: CGFloat) {
        let metrics = ["margin":  NSNumber(floatLiteral: Double(margin))]
        let format = "V:|-20@750-[titleLabel]-10@750-[messageTextView]-5@750-[animationContainerView]-5@750-[contentContainerView]-20@750-[actionContainerView]-margin-|"
        let cons = NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["titleLabel": titleLabel!, "messageTextView": messageTextView!, "animationContainerView": animationContainerView!, "contentContainerView": contentContainerView!, "actionContainerView": actionContainerView!])
        alertBackgroundView.addConstraints(cons)
    }
    // animation
    private func setView(animation: UIView, _ w: CGFloat, _ h: CGFloat) {
        self.animationView?.removeFromSuperview()
        self.animationView = animation
        let metrics = ["height": NSNumber(floatLiteral: Double(h)),
                       "width": NSNumber(floatLiteral: Double(w))]
        self.animationView?.translatesAutoresizingMaskIntoConstraints = false
        animationContainerView.addSubview(animationView!)
        
        animationContainerView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "H:[animation(width)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["animation":animationView!]))
        animationContainerView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat:
                "V:|[animation(height)]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: metrics, views: ["animation":animationView!]))
        
        animationContainerView.addConstraint(NSLayoutConstraint(item: animationView!, attribute: .centerX, relatedBy: .equal, toItem: animationContainerView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        animationContainerView.addConstraint(NSLayoutConstraint(item: animationView!, attribute: .centerY, relatedBy: .equal, toItem: animationContainerView, attribute: .centerY, multiplier: 1.0, constant: 0.0))
    }
    // content
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
}



// MARK: - AEAlertTextView
open class AEAlertTextView: UITextView {
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
