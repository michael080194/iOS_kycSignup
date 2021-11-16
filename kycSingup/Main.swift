//
//  ContentView.swift
//  kycSingup
//
//  Created by michael CHANG on 2021/11/8.
//

import SwiftUI


struct Main: View {
    @State private var tabSelection = 1
    var body: some View {
        NavigationView {
            TabView(selection: $tabSelection){
                LoginView()
                .tabItem({
                 Image(systemName: "house")
                 Text("登入")
                }).tag(1)
                
                SettingsView(tabSelection: $tabSelection)
                  .tabItem({
                   Image(systemName: "gear")
                   Text("設定")
                  }).tag(2)
                
                
                 AboutView()
                 .tabItem({
                  Image(systemName: "info.circle")
                  Text("關於")
                 }).tag(3)
                
            }.padding(.top  , 0)
        } // end of NavigationView
     }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
