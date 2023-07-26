//
//  ViewController.swift
//  AlertViewDemo
//
//  Created by allen0828 on 2019/8/14.
//  Copyright © 2019 张其锋. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let past = UIButton(frame: CGRect(x: 32, y: 100, width: view.bounds.size.width-64, height: 50))
        past.setTitle("2.3版本测试代码", for: .normal)
        past.backgroundColor = UIColor.red
        past.addTarget(self, action: #selector(pastClicked), for: .touchUpInside)
        view.addSubview(past)
        
        let new = UIButton(frame: CGRect(x: 32, y: 160, width: view.bounds.size.width-64, height: 50))
        new.setTitle("最新版本测试代码", for: .normal)
        new.backgroundColor = UIColor.green
        new.addTarget(self, action: #selector(newClicked), for: .touchUpInside)
        view.addSubview(new)
    }
    
    @objc func pastClicked() {
        navigationController?.pushViewController(PastController(), animated: true)
    }
    @objc func newClicked() {
        navigationController?.pushViewController(NewTestController(), animated: true)
    }
    
}

