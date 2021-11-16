//
//  signupMyRecord.swift
//  kycSingup
//
//  Created by michael CHANG on 2021/11/15.
//

import SwiftUI

struct signupMyRecord: View {
    @StateObject var fetchMyRecord = DoApi()
    @EnvironmentObject var kycCommData1: KycCommData
    @State private var showJson: myRecord00?
    @State var kycFontSize: CGFloat  = 20
    @State var isNavigationBarHidden: Bool = true
    @State private var isLoading = false
    @State var username = ""
    @Environment(\.presentationMode) var presentationMode


    var body: some View {
        ZStack {
            VStack {
                
                HStack{
                    Text("\(self.username)  的所有報名資料")
                      .font(.system(size: kycFontSize))
                      .frame(alignment: .leading)
                      .foregroundColor(Color.purple)
                  Spacer()
                }

                
                if self.showJson != nil {
                    KycNoSepratorList {
                        ForEach(self.showJson!.responseArray, id: \.self) { result in
                            VStack{
                                ListDataLimit(title:"活動名稱",field:result.title)
                                ListDataLimit(title:"活動日期",field:result.action_date)
                                ListDataLimit(title:"報名日期",field:result.signup_date)
                                ListDataLimit(title:"錄取狀況",field:result.accept_name)
                            } // end of VStack
                            Divider().frame(maxWidth: .infinity).frame(height: 2).background(Color.blue).padding(.bottom , 10)
                        } // end of ForEach
                        .padding(.top , 10)
                    } // end of KycNoSepratorList
                } // end of if
            } // end of VStack
            .onAppear() {
                self.isLoading = true
                self.username = kycCommData1.KycLoginUserName
                let uid =  kycCommData1.KycLoginUid
                let isAdmin =  kycCommData1.KycLoginisAdmin
                let token =  kycCommData1.KycLoginToken
                var postString = "op=kyc_signup_my_record&"
                postString += "token=" + token + "&"
                postString += "userId=" + uid + "&"
                postString += "isAdmin=" + isAdmin
                fetchMyRecord.GetData(kycCommData1: self.kycCommData1, postString: postString){(value) in
                    let dataString = String(decoding: value, as: UTF8.self)
                    let stringResult = dataString.contains("\"responseStatus\":\"SUCCESS\"")
                    if stringResult == true {
                        self.showJson = try! JSONDecoder().decode(myRecord00.self , from: value)
                         
                    } else {
                        self.isNavigationBarHidden = false
                    }
                    self.isLoading = false
                }
            } // end of VStack onAppear
            LoadingView(isLoading: $isLoading)
        } // end of ZStack
    } // end body: some View
  
}

struct myRecord00: Codable,Identifiable {
    let id = UUID()
    var responseArray: [myRecord01]
}

struct myRecord01: Codable,Identifiable,Hashable{
 let id = UUID()
 let title: String
 let action_date: String
 let signup_date: String
 let accept_name: String
}
