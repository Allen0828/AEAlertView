//
//  TestViewController.swift
//  dev-alert
//
//  Created by gw_pro on 2021/11/18.
//

import UIKit

class TestViewController: UIViewController {

    
    var tag: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let v = AEAlertView(style: .defaulted, title: "11111", message: "11")
//        v.actionHeight = 100
//        let a = AEAlertAction(title: "all", style: .cancel) { action in
//
//        }
        let b = AEAlertAction(title: "all in ", style: .defaulted) { action in
            
        }
//        let c = AEAlertAction(title: "all in ", style: .defaulted) { action in
//
//        }
        let d = AEAlertAction(title: "123123", style: .cancel) { action in
            
        }

        if #available(iOS 15.0, *) {
            d.subtitle = "123"
            
        } else {
            // Fallback on earlier versions
        }
        d.textColor = UIColor.orange
        d.textFont = UIFont.systemFont(ofSize: 11)
        
        v.addAction(action: b)
        v.addAction(action: d)
//        v.addAction(action: c)
        
        v.show()
        
        
//        AEAlertView.show(title: "11", message: "11111", actions: ["all in test long very longer", "123123"]) { action in
//            self.tag = 10
//            self.testFunc()
//            self.navigationController?.popViewController(animated: true)
//        }
//
    }
    
    private func testFunc() {
        
    }

    deinit {
        print("TestViewController----deinit")
    }

}
