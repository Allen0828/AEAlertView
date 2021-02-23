//
//  IndexView.swift
//  SwiftUI-Demo
//
//  Created by 锋 on 2021/2/23.
//

import SwiftUI
import AEAlertView


struct AEIndexView: View {
    
    var body: some View {
        ZStack {
            Rectangle().foregroundColor(.white)
            VStack {
                Button("alert") {
                    AEAlertView.show(title: "test", actions: ["cancel", "submit"], message: nil) { (action) in
                        print("1111")
                    }
                }
                
            }
        }
    }
    
}

