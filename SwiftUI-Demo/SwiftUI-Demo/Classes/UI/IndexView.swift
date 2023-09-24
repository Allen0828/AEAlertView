//
//  IndexView.swift
//  SwiftUI-Demo
//
//  Created by 锋 on 2021/2/23.
//

import SwiftUI
import AEAlertView
import SnapKit


struct AEIndexView: View {
    
    
    @State private var showSheet: Bool = false

    @State private var subviewOffset: CGFloat = 50

    var body: some View {
        ZStack {
            Rectangle().foregroundColor(.white)
            VStack {
                Button("alert") {
                    AEAlertView.show(title: "test", message: nil, actions: ["cancel", "submit"]) { (action) in
                        print("1111")
                    }
                }
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .top)
                .background(Color.red)
                .shadow(radius: 25)
                .padding(.bottom, 4)
                .hidden()
                
                

                .actionSheet(isPresented: $showSheet, content: {sheet})
            }
        }
    }

    let alertBtn = Button("11145676786") {

    }

    var subView: SubView {
        let v = SubView()

        return v
    }

    private var alert: AEAlertView {
        let view = AEAlertView(style: .defaulted, title: "title", message: "message")

        return view
    }

    private var sheet: ActionSheet {
        let v = ActionSheet(title: Text("title"), message: Text("msg"), buttons: [.destructive(Text("def"), action: {
            print("Default")
            self.showSheet = false
        })])

        return v
    }
    
}

struct SubView: View {
    var body: some View {
        Text("subView")
            
    }
}


