//
//  AEWebAlertView.swift
//  dev-alert
//
//  Created by Allen0828 on 2023/7/23.
//

import UIKit
import WebKit

// 此弹窗会将baseAlert中的 contentView 设置为WKWebView 所以使用此弹窗 无法设置 contentView.
// 如果你有自定义View需要添加 请使用 set(custom: UIView, width: CGFloat, height: CGFloat)


public enum AEWebAlertViewStyle {
    case defaulted,
    custom
}

// custom =
//   ----------------------
//  |        title         |
//  |       message        |
//  |       WebView        |
//  |      contentView     |
//  |                      |
//  | ┌──────┐   ┌──────┐  |
//  | └──────┙   └──────┙  |
//   ----------------------
// defaulted =
//  ┌──────────────────────┐
//  |        title         |
//  |       message        |
//  |       WebView        |
//  |      contentView     |
//  |                      |
//  |──────────┯───────────|
//  └──────────┷───────────┙


extension AEWebAlertView {
    public func show() {
        showAlert()
    }
    public func dismiss() {
        dismissAlert()
    }
    public func addAction(action: AEAlertAction) {
        actions.append(action)
    }
}

class AEWebAlertView: UIView {

    /// show动画时间 默认 0.5 如果为0 取消动画
    public var showDuration: CGFloat = 0.5
    /// dismiss动画时间 默认 0.25 如果为0 取消动画
    public var dismissDuration: CGFloat = 0.25
    public var webView: WKWebView!
    /// baseAlert 不能改变值
    public var alertView: AEBaseAlertView!
    
    
    public override convenience init(frame: CGRect) {
        self.init(style: .defaulted, title: nil, message: nil)
    }
    public convenience init(style: AEAlertViewStyle) {
        self.init(style: style, title: nil, message: nil)
    }
    public convenience init(style: AEAlertViewStyle, maximumWidth: CGFloat = 320) {
        self.init(style: style, title: nil, message: nil, maximumWidth: maximumWidth)
    }
    public convenience init(style: AEAlertViewStyle, title: String?, message: String?) {
        if UIScreen.main.bounds.size.width-48 > 320 {
            self.init(style: style, title: title, message: message, maximumWidth: 320)
        } else {
            self.init(style: style, title: title, message: message, maximumWidth: UIScreen.main.bounds.size.width-48)
        }
    }
    
    public init(style: AEAlertViewStyle, title: String?, message: String?, maximumWidth: CGFloat = 320) {
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        alertStyle = style
        alertView = AEBaseAlertView(frame: frame, maximumWidth: maximumWidth)
        alertView.titleLabel.text = title
        alertView.messageTextView.text = message ?? ""
        if style == .custom {
            alertView.alertStyle = .custom
        } else {
            alertView.alertStyle = .apple
        }
        addSubview(alertView)

        webView = WKWebView()
        let url = URLRequest(url: URL(string: "https://www.baidu.com")!)
        webView.load(url)
        
        
        alertView.setContent(view: webView, width: -1, height: 100)
        alertView.actionViewTopMargin = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint("AEWebAlertView-deinit")
    }
    
    
    private var actions: [AEAlertAction] = []
    private var alertStyle: AEAlertViewStyle = .defaulted
    
}

extension AEWebAlertView {
    private func showAlert() {
        createActions()
        DispatchQueue.main.async {
            UIApplication.shared.alertGetCurrentWindow()?.addSubview(self)
            if self.showDuration == 0.0 {
                self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
                return
            }
            self.alertView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.alertView.alpha = 0
            self.alertView.messageTextView.isScrollEnabled = true
            
            UIView.animate(withDuration: TimeInterval(self.showDuration),
                           delay: 0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 0.5,
                           options: .curveEaseInOut,
                           animations: {
                        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
                        self.alertView.transform = CGAffineTransform(scaleX: 1, y: 1)
                        self.alertView.alpha = 1
            }) { finish in
//                if finish {
//                    self.alertView.messageTextView.isScrollEnabled = true
//                }
            }
        }
    }
    private func dismissAlert() {
        DispatchQueue.main.async {
            self.actions = []
            if self.dismissDuration == 0.0 {
                for view in self.subviews {
                    view.removeFromSuperview()
                }
                self.removeFromSuperview()
                return
            }
            UIView.animate(withDuration: self.dismissDuration, delay: 0.0, options: .curveEaseIn, animations: {
                self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
                self.alertView.alpha = 0
                self.alpha = 0
            }) { (finished) in
                self.removeFromSuperview()
            }
        }
    }
    
    private func createActions() {
        DispatchQueue.main.async {
            if self.actions.count == 0 {
                self.alertView.actionList = []
                return
            }
            var list: [AEAlertViewButton] = []
            for (idx, action) in self.actions.enumerated() {
                let btn = AEAlertViewButton(type: .custom)
                btn.tag = idx
                btn.action = action
                btn.addTarget(self, action: #selector(self.actionPressed), for: .touchUpInside)
                if action.tag == -1 { action.tag = idx }
                action.actionButton = btn
                list.append(btn)
            }
            self.alertView.actionList = list
        }
    }
    
    @objc private func actionPressed(button: AEAlertViewButton) {
        if button.tag < actions.count {
            if !(actions[button.tag].enabled ?? false) {
                return
            }
            actions[button.tag].handler?(actions[button.tag])
        }
    }
    
}
