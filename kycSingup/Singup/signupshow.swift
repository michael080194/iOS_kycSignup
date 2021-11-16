//
//  signupshow.swift
//  kycSingup
//
//  Created by michael CHANG on 2021/11/8.
//

import SwiftUI

    struct signupshow: View {
        @StateObject var fetchRepairPartno = DoApi()
        @EnvironmentObject var kycCommData1: KycCommData
        @State var action_id: String
        @State private var showJson: ActionShow00?
        
        @State var kycFontSize: CGFloat  = 20
        
        @State var k_candidate = ""
        @State var k_signup_candidate = ""
        @State var k_can_signup = 0
        // @State private var PassResultDetail: ActionShow01?
        // @State var PassResult = ""
        @State var actionDetail: ActionList1
        @State var isNavigationBarHidden: Bool = true
        @State private var isLoading = false
        @State var isLink = false
        @Environment(\.presentationMode) var presentationMode


        var body: some View {
            ZStack {
                VStack {
                    
                    HStack{
                        VStack(alignment: .leading){
                          Text("活動名稱：\(actionDetail.title)")
                          .font(.system(size: kycFontSize))
                          .frame(alignment: .leading)
                          .foregroundColor(Color.purple)
                            
                            HStack(){
                                Text("可報人數：")
                                        .font(.system(size: kycFontSize))
                                        .frame(alignment: .topLeading)
                                        .foregroundColor(Color.blue)
                                Text(actionDetail.number+self.k_candidate)
                                        .font(.system(size: kycFontSize))
                                        .frame(alignment: .topLeading)
                                        .foregroundColor(Color.blue)
                            }
                            HStack{
                                Text("已報人數：")
                                        .font(.system(size: kycFontSize))
                                        .frame(alignment: .topLeading)
                                        .foregroundColor(Color.blue)
                                Text(String(actionDetail.signup_people-actionDetail.signup_candidate)+self.k_signup_candidate)
                                        .font(.system(size: kycFontSize))
                                        .frame(alignment: .topLeading)
                                        .foregroundColor(Color.blue)
                            }
                            HStack{
                                Text("尚可報名：")
                                        .font(.system(size: kycFontSize))
                                        .frame(alignment: .topLeading)
                                        .foregroundColor(Color.blue)
                                Text(String(self.k_can_signup))
                                        .font(.system(size: kycFontSize))
                                        .frame(alignment: .topLeading)
                                        .foregroundColor(Color.blue)
                            }
                            
                        } // VStack
                      Spacer()
                    }

                    
                    if self.showJson != nil {
                        KycNoSepratorList {
                            ForEach(self.showJson!.responseArray, id: \.self) { result in
                                VStack{
                                ForEach(result, id: \.self) { result2 in
                                    if result2.title == "姓名" || result2.title == "飲食" {
                                        ListDataLimit(title: ("        " + result2.title), field:result2.val)
                                    } else {
                                        ListDataLimit(title:result2.title, field:result2.val)
                                    }
                                   
                                }
                                Divider().frame(maxWidth: .infinity).frame(height: 2).background(Color.blue).padding(.bottom , 10)
                                } // end of VStack
                            } // end of ForEach
                            .padding(.top , 10)
                        } // end of KycNoSepratorList
                    } // end of if
                } // end of VStack
                .onAppear() {
                    if Int(actionDetail.candidate)! > 0 {
                       self.k_candidate = "/ 候補 " + actionDetail.candidate
                    }
                    if actionDetail.signup_candidate > 0 {
                       self.k_signup_candidate = "/ 候補 " + String(actionDetail.signup_candidate)
                    }
                    let goalOne1 = Int(actionDetail.number) ?? 0
                    let goalOne2 = Int(actionDetail.candidate) ?? 0
                
                    self.k_can_signup = goalOne1 + goalOne2 - (actionDetail.signup_people - actionDetail.signup_candidate) - actionDetail.signup_candidate
                    
                    self.isLoading = true
                    let uid =  kycCommData1.KycLoginUid
                    let isAdmin =  kycCommData1.KycLoginisAdmin
                    let token =  kycCommData1.KycLoginToken
                    var postString = "op=kyc_signup_data_get_people&"
                    postString += "token=" + token + "&"
                    postString += "userId=" + uid + "&"
                    postString += "isAdmin=" + isAdmin + "&"
                    postString += "action_id="+action_id
                    fetchRepairPartno.GetData(kycCommData1: self.kycCommData1, postString: postString){(value) in
                        let dataString = String(decoding: value, as: UTF8.self)
                        // print("aaaaaa=\(dataString)")
                        let stringResult = dataString.contains("\"responseStatus\":\"SUCCESS\"")
                        if stringResult == true {
                            self.showJson = try! JSONDecoder().decode(ActionShow00.self , from: value)
                            // print("www=\(self.showJson?.responseArray)")
                             /*
                             for index in 0...(self.showJson?.responseArray.count)!-1 {
                                 let aa1 = self.showJson?.responseArray[index]
                                print(aa1!)
                                 for index1 in 0...(aa1!.count)-1 {
                                    // print("aa=\(aa1![index1].title) bb=\(aa1![index1].val)\r\n")
                                    print(aa1![index1])
                                 }
                                 print("---------------------------------")
                             }
                             */
                             
                        } else {
                            self.isNavigationBarHidden = false
                        }
                        self.isLoading = false
                    }
                } // end of VStack onAppear

    //            LoadingView(isLoading: $isLoading).offset(y: 50)
                LoadingView(isLoading: $isLoading)
            } // end of ZStack
        } // end body: some View
      
    }

    struct ActionShow00: Codable,Identifiable {
        let id = UUID()
        var responseArray: [[ActionShow01]]
    }


//struct ActionShow01: Codable,Identifiable{
//    let id = UUID()
//    let title: [ActionShow02]
//}

struct ActionShow01: Codable,Identifiable,Hashable{
    let id = UUID()
    let title: String
    let val: String
}
