//
//  AETabbarView.swift
//  SwiftUI-Demo
//
//  Created by 锋 on 2021/2/23.
//

import SwiftUI



struct AETabbarView: View {
    @State private var idx: Int = 0
    private let imgs = ["index", "222", "333", "444"]
    
    var body: some View {
        TabView(selection: $idx) {
            
            ForEach(0..<imgs.count) { item in
                TabbarItemView(idx: item).tabItem {
                    Image(systemName: "2.circle")
                    Text(imgs[item]
                            
                    )
                }.tag(item)
    
            }
        }
    }
}

struct TabbarItemView: View {
    public var idx: Int
    
    var body: some View {
        NavigationView {
            if idx == 0 {
                AEIndexView()
                    .navigationBarTitle("TEST",displayMode: .inline)
            } else {
                Text("\(idx)")
                    .navigationBarTitle("OTHER",displayMode: .inline)
            }
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    
}
