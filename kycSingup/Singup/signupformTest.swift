//
//  signupformTest.swift
//  kycSingup
//
//  Created by michael CHANG on 2021/11/10.
//

import SwiftUI
/*
struct signupformTest: View {
    @StateObject var fetchSignupForm = DoApi()
    @EnvironmentObject var kycCommData1: KycCommData
    @State var action_id: String
    @State private var showJson: SignForm00?
    @State var actionDetail: ActionList1
    @State var isNavigationBarHidden: Bool = true
    @State private var isLoading = false
    @State var isLink = false
    @Environment(\.presentationMode) var presentationMode
    @State var kycFontSize: CGFloat  = 18

    @State var inputField = ""
    let elements = ["input", "select", "option"]
    var body: some View {

        ForEach(0..<elements.count) { index in
            if self.elements[index] == "input" {
                input(inputField: $inputField)
            }
            if self.elements[index] == "select" {
                AMZ2()
            }
            if self.elements[index] == "option" {
                AMZ3()
            }
        }

            
        ZStack {
            VStack {
                /*
                HStack{ // 01
                    VStack{ // 01
                      Text("活動：\(actionDetail.title) / (\(self.action_id))")
                      .font(.system(size: kycFontSize))
                      .frame(alignment: .leading)
                      .foregroundColor(Color.purple)
                      if self.showJson == nil {
                         Text("查無填報資料")
                         .font(.system(size: kycFontSize))
                         .padding(.leading, 10)
                         .frame(alignment: .leading)
                         .foregroundColor(Color.red)
                      } // end if
                    } // VStack 01
                } // end of HStack 01
                
                if self.showJson != nil {
                } // end of if
                */
            } // end of VStack
            .onAppear() {
                self.isLoading = true
                let uid =  kycCommData1.KycLoginUid
                let isAdmin =  kycCommData1.KycLoginisAdmin
                var postString = "op=get_signup_form&"
                postString += "userId=" + uid + "&"
                postString += "isAdmin=" + isAdmin + "&"
                postString += "action_id=" + self.action_id
                fetchSignupForm.GetData(kycCommData1: self.kycCommData1, postString: postString){(value) in
                    let dataString = String(decoding: value, as: UTF8.self)
                    // print("aaaaaa=\(dataString)")
                    let stringResult = dataString.contains("\"responseStatus\":\"SUCCESS\"")
                    if stringResult == true {
                        self.showJson = try! JSONDecoder().decode(SignForm00.self , from: value)
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



struct SignForm00: Codable,Identifiable {
    let id = UUID()
    var responseArray: [SignForm01]
}

struct SignForm01: Codable,Identifiable,Hashable{
    let id = UUID()
    let label: String
    let type: String
    let val: String
    let default1: String
    let require: Int
}


struct input: View {
    @Binding var inputField: String
    var body: some View {
        HStack{
            Text("帳號")
                .font(.system(size: 20))
            
            TextField("", text: self.$inputField)
                .frame(height: 40).border(Color.black)
        }
    }
 }

struct AMZ2: View {
    var body: some View {
       Text("Text 02")
    }
 }

struct AMZ3: View {
    var body: some View {
       Text("Text 03")
    }
 }
 */

