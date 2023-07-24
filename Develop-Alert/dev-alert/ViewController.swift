//
//  ViewController.swift
//  dev-alert
//
//  Created by gw_pro on 2021/11/18.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        
        
        
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let alert = AEAlertView()
//        alert.title = "title"
//        alert.message = "message\rmessage"
//        alert.actionViewTopMargin = 0
////        alert.messageHeight = 30
//        let cancel = AEAlertAction(title: "cancel") { action in
//            alert.dismiss()
//        }
//        alert.addAction(action: cancel)
//        alert.show()
        
        
        let alert = AEWebAlertView(style: .defaulted, title: "title", message: "message")
        
//        alert.actionViewTopMargin = 0
//        alert.messageHeight = 30
        let cancel = AEAlertAction(title: "cancel") { action in
            alert.dismiss()
        }
        alert.addAction(action: cancel)
        alert.show()
        
        
//        AEAlertView.show(title: "TITLE", message: "message", actions: ["qqqq"]) { action in
//            print(action)
//        }
        
        
//        let globalQueue = DispatchQueue.global()
//        globalQueue.async {
//            AEAlertView.show(title: "111", message: "21323", actions: ["123","213"]) { action in
//
//            }
//        }
        
//        navigationController?.pushViewController(TestViewController(), animated: true)
    }
    


}

