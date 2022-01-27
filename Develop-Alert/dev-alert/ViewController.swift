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
        
//        let globalQueue = DispatchQueue.global()
//        globalQueue.async {
//            AEAlertView.show(title: "111", message: "21323", actions: ["123","213"]) { action in
//
//            }
//        }
        
        navigationController?.pushViewController(TestViewController(), animated: true)
    }
    


}

