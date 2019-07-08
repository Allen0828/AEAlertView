//
//  AEAlertAction.swift
//  AEAlertView
//
//  代码地址: https://github.com/Allen0828/AEAlertView
//  Copyright © 2017年 Allen. All rights reserved.
//

import UIKit

public enum AEAlertActionStyle {
    case Default,
    Cancel,
    Destructive
}

/// 自定义Action
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
