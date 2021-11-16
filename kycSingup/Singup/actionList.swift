//
//  signuplist.swift
//  kycSingup
//
//  Created by michael CHANG on 2021/11/8.
//

import SwiftUI

struct actionList: View {
        @StateObject var fetchAllAction = DoApi()
        @EnvironmentObject var kycCommData1: KycCommData
        @Environment(\.presentationMode) var presentationMode
       
        @State private var showJson: ActionList0?
        @State private var PassResultDetail: ActionList1?
        @State var PassResult = ""
        @State var action_id = ""
        @State var isActive1 = false
        @State var isActive2 = false
        @State var isNavigationBarHidden: Bool = true
        @State private var isLoading = false
        @State var isLink1 = false
        @State var isLink2 = false
        @State var isLink3 = false
        @State var isLink4 = false
        @State var id = ""
        @State private var disabled = true
        var body: some View {
            ZStack{
    //        NavigationView {
          
                VStack {
                    HStack{
                        
                        Text("所有活動清單")
                        .font(.system(size: 24))
                        .frame(alignment: .leading)
                        .foregroundColor(Color.purple)
                        
                        Spacer()
                        
                        Button(action: {
                            if !self.disabled {
                               self.isLink4 = true
                               self.isNavigationBarHidden = true
                            }
                        }) {
                            Text("我的報名記錄")
                                .frame(width: 120, height: 40, alignment: .center)
                                .foregroundColor(.white)
                        }
                        .opacity(self.disabled ? 0 : 1)
                        .background(self.disabled ? Color.white : Color.green)
                        .cornerRadius(10)
                        .padding(.trailing , 15)
                    }
                    
                    if self.showJson != nil {
                        KycNoSepratorList {
                            ForEach(self.showJson!.responseArray ,  id: \.id) { result in
                                VStack{
                                    let signuount = result.number + "/" + result.candidate

                                    ListDataLimit(title:"活動名稱",field:result.title)
                                    ListDataLimit(title:"詳細內容",field:result.detail)
                                    ListDataLimit(title:"活動日期",field:result.action_date)
                                    ListDataLimit(title:"報名截止日",field:result.end_date)
                                    ListDataLimit(title:"可報名/候補數",field: signuount)

                                    HStack(spacing: 20){
                                        Button(action: {
                                            self.PassResultDetail = result
                                            self.action_id = result.id
                                            self.isLink1 = true
                                            self.isNavigationBarHidden = true
                                        }) {
                                            Text("活動詳情")
                                                .frame(width: 100, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                                .foregroundColor(.white)
                                        }
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                      
                                   
                                        Button(action: {
                                            self.PassResultDetail = result
                                            self.action_id = result.id
                                            self.isLink2 = true
                                            self.isNavigationBarHidden = true
                                        }) {
                                            Text("報名統計")
                                                .frame(width: 100, height: 25, alignment: .center)
                                                .foregroundColor(.white)
                                        }
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                        
                                        Button(action: {
                                            if !self.disabled {
                                               self.PassResultDetail = result
                                               self.action_id = result.id
                                               self.isLink3 = true
                                               self.isNavigationBarHidden = true
                                            }
                                        }) {
                                            Text("立即報名")
                                                .frame(width: 100, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                                .foregroundColor(.white)
                                        }
                                        .opacity(self.disabled ? 0 : 1)
                                        .background(self.disabled ? Color.white : Color.blue)
                                        .cornerRadius(10)

                                      
                                        
                                        Spacer()
                                    } .padding(.leading , 20)
                                    .padding(.top , 1)
                                    Divider().frame(maxWidth: .infinity).frame(height: 2).background(Color.blue).padding(.bottom , 10)
                               
                                } // end of VStack
                                .padding(.top , 10)
                            } // end of ForEach
                        } // end of KycNoSepratorList
                    } // end of if
                } // end of VStack
                
            .opacity(isLoading ? 0 : 1)
            .onAppear() {
                self.isLoading = true
                if kycCommData1.KycLoginUid == "" {
                    self.disabled = true
                }else{
                    self.disabled = false
                }
                // print("kycCommData1.KycLoginUid=\(kycCommData1.KycLoginUid)")
                let uid =  kycCommData1.KycLoginUid
                let isAdmin =  kycCommData1.KycLoginisAdmin
                let token =  kycCommData1.KycLoginToken
                var postString = "op=kyc_signup_actions_get_all&"
                postString += "token=" + token + "&"
                postString += "userId=" + uid + "&"
                postString += "isAdmin="+isAdmin
                fetchAllAction.GetData(kycCommData1: self.kycCommData1, postString: postString){(value) in
                    let dataString = String(decoding: value, as: UTF8.self)
                    let stringResult = dataString.contains("\"responseStatus\":\"SUCCESS\"")
                    if stringResult == true {
                        self.showJson = try! JSONDecoder().decode(ActionList0.self , from: value)
                        // print("ccc=\(self.showJson?.responseArray)")
                    } else {
                        self.isNavigationBarHidden = false
                    }
                    self.isLoading = false
                }
            } // end of VStack onAppear
            LoadingView(isLoading: $isLoading).offset(y: 50)
            } // end of ZStack
            if self.PassResultDetail != nil {
                NavigationLink(destination: actionDetail(actionDetail: self.PassResultDetail!),
                     isActive: $isLink1) {
                     EmptyView() }
                
               NavigationLink(destination: signupshow(action_id: self.action_id,actionDetail: self.PassResultDetail!),
                    isActive: $isLink2) {
                    EmptyView() }
                
                
                NavigationLink(destination: signupForm(action_id: self.action_id,actionDetail: self.PassResultDetail!),
                     isActive: $isLink3) {
                     EmptyView() }
                
            }
            NavigationLink(destination: signupMyRecord(),
                 isActive: $isLink4) {
                 EmptyView() }
                                                
        } // end body: some View
      
    }

    struct ActionList0: Codable  , Identifiable{
        let id = UUID()
        var responseArray: [ActionList1]
    }

    struct ActionList1 : Codable{
        let id: String
        let title: String
        let detail: String
        let action_date: String
        let end_date: String
        let number: String
        let candidate: String
        let signup_people: Int
        let signup_candidate: Int
    }
