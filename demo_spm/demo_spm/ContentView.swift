//
//  ContentView.swift
//  demo_spm
//
//  Created by allen on 2023/9/24.
//

import SwiftUI
import AEAlertView

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
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
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
