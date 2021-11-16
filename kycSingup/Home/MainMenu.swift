//
//  MainMenu.swift
//  kycele
//
//  Created by michael CHANG on 2021/2/25.
//

import SwiftUI
struct MainMenuView: View {
    @State var isActive01 = false
    @State var isActive02 = false
    @State var isActive03 = false
    @State var isActive04 = false
    @State var isActive05 = false
    @State var isActive06 = false
    @State var isActive07 = false
    @State var isActive08 = false
    var body: some View {
        Spacer()
        VStack {
            Text("歡迎使用 點二下 報名系統")
            Text("請先預先設定您的登錄資訊")
            /*
            HStack{ // 01
                VStack{
                    NavigationLink(destination: inqProd(), isActive: $isActive01) {
                        Image("07")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                    }
                    .isDetailLink(false)
                    Text("產品查詢")
                }
//                .padding(.top , 20)
                .onTapGesture {
                    isActive01 = true
                }

                VStack{
                    NavigationLink(destination: InqCust(), isActive: $isActive02) {
                        Image("02")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                    }
                    .isDetailLink(false)
                    Text("客戶查詢")
                }
//                .padding(.top , 20)
                .padding(.leading , 50)
                .onTapGesture {
                    isActive02 = true
                }
            }// end of HStack 01
            */
            /*
            HStack{ // 02
                VStack{
                    NavigationLink(destination: Develop(), isActive: $isActive03) {
                        Image("03")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                    }
                    .isDetailLink(false)
                    Text("保留使用")
                }
                .padding(.top , 20)
                .onTapGesture {
                    isActive03 = true
                }
                
                VStack{
                    NavigationLink(destination: Develop(), isActive: $isActive04) {
                        Image("04")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                    }
                    .isDetailLink(false)
                    Text("保留使用")
                }
                .padding(.top , 20)
                .padding(.leading , 50)
                .onTapGesture {
                    isActive04 = true
                }
            } // end of HStack 02
            */
          
        } // end of VStack
        Spacer()
    }
    
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
