//
//  ViewController.swift
//  AEAlertViewDemo
//
//  Created by Allen on 2018/9/10.
//  Copyright © 2018年 Allen. All rights reserved.
//

import UIKit
import AEAlertView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var btnY: CGFloat = 80.0
        
        for i in 0..<6 {
            let btn = UIButton()
            btn.setTitle("style\(i)", for: .normal)
            btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
            btn.backgroundColor = UIColor.blue
            btn.tag = i
            btn.frame = CGRect(x: 100, y: btnY, width: 100, height: 30)
            
            view.addSubview(btn)
            btnY += 40
        }
        
    }
    
    @objc private func btnClick(btn: UIButton) {
        
        
    }

    

}

