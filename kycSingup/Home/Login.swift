//
//  Login.swift
//  kycele
//
//  Created by michael CHANG on 2021/2/26.
//

import SwiftUI
import Combine

struct LoginView: View {
         @EnvironmentObject var kycSetting1: KycSetting
         @EnvironmentObject var kycCommData1: KycCommData
         @State var color = Color.black.opacity(0.7)
         @State var comp_id = ""
         @State var username = ""
         @State var password = ""
         @State var visible = false
         @State var alert = false
         @State var error = ""
         @State var isLoading = false
         var body: some View{
             ZStack{
                 LoadingView(isLoading: $isLoading).offset(y: 20)
                 VStack{
                    Image("logo2")
                        .resizable()
                        .frame(width: 250, height: 150)
                    Spacer()
                    usernameField(username: $username )
                    PasswordField(visible : $visible , password: $password , color: $color)
                    LoginButton(username: $username , password: $password, error: $error , alert: $alert, isLoading: $isLoading)
                    Spacer()
                    Spacer()
                 }
                 .opacity(isLoading ? 0 : 1)
                 .padding(.horizontal, 25)
             } // end of ZStack
             .onAppear() {
                self.isLoading = false
                self.username = kycSetting1.UserName
                self.password = kycSetting1.PassWord
             }

         }
         
     }

struct usernameField: View {
    @Binding var username: String
    var body: some View {
        HStack{
            HStack{
                Text("帳號")
                    .font(.system(size: 20))
                
                TextField("", text: self.$username)
                    .frame(height: 40).border(Color.black)
            }
            
            
            // This button just for layout beautiful
            // I don't want this button show
            Button(action: {
            }) {
                Image(systemName: "eye.slash.fill" )
                    .opacity(0)
                  
            }
         }
        .padding(.top , 20)
    }
}

struct PasswordField: View {
    @Binding var visible: Bool
    @Binding var password: String
    @Binding var color: Color
    var body: some View {
        HStack{
            HStack{
                Text("密碼")
                    .font(.system(size: 20))
                    
                if self.visible{
                    TextField("", text: self.$password)
                        .frame(height: 40).border(Color.black)
                }else{
                    SecureField("", text: self.$password)
                        .frame(height: 40).border(Color.black)
                }
            }
            
            Button(action: {
                self.visible.toggle()
            }) {
                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                    .foregroundColor(self.color)
            }
            
        }
      
    }
}


struct LoginButton: View {
    @EnvironmentObject var appState: AppState
    @Binding var username: String
    @Binding var password: String
    @Binding var error: String
    @Binding var alert: Bool
    @Binding var isLoading: Bool
    @State private var appExit = false
    @State var isLoginOk = false
    @State var isLoginError = false
    @State var alertMsg = ""
    var doApi = DoApi()
    @EnvironmentObject var kycCommData1: KycCommData
    @EnvironmentObject var kycSetting1: KycSetting
    @State private var showJson: CheckLoginReturn?
    
    var body: some View {
        HStack{
            NavigationLink(destination: actionList(), isActive: $isLoginOk) {
            Button(action: {
                if(kycSetting1.IpAddress == ""){
                    self.isLoginError = true
                    self.alertMsg = "請先設定IP 位址"
                    return
                }
                if(self.username == ""){
                    self.isLoginError = true
                    self.alertMsg = "帳號不能空白"
                    return
                }
                if(self.password == ""){
                    self.isLoginError = true
                    self.alertMsg = "密碼不能空白"
                    return
                }
                kycCommData1.KycApiUrl = kycSetting1.IpAddress
                kycCommData1.KycLoginUserName = self.username
                kycCommData1.KycLoginPassWord = self.password
                kycCommData1.KycLoginUid = ""
                kycCommData1.KycLoginisAdmin = ""
                var postString = "op=kyc_signup_login_check&"
                postString += "username=" + self.username + "&"
                postString += "password=" + self.password
                self.isLoading = true
                doApi.GetData(kycCommData1: self.kycCommData1 , postString: postString ){(value) in
                    let dataString = String(decoding: value, as: UTF8.self)
                     // print("bb=\(dataString)")
                    let stringResult = dataString.contains("\"responseStatus\":\"SUCCESS\"")
                    let stringTimeOut = dataString.contains("KYC TIMEOUT")
                   
                    if stringResult == true {
                        self.showJson = try! JSONDecoder().decode(CheckLoginReturn.self , from: value)
                        if self.showJson?.responseStatus == "SUCCESS" {
                            // print("aaaaaa=\(self.showJson!.responseArray.isAdmin)")
                            kycCommData1.KycLoginUid = self.showJson!.responseArray.userId
                            kycCommData1.KycLoginisAdmin = self.showJson!.responseArray.isAdmin
                            kycCommData1.KycLoginToken = self.showJson!.responseArray.token
                            // print("bb=\(kycCommData1.KycLoginUid)")
                            self.isLoginOk = true
                        } else {
                            isLoginError = true
                        }
                    } else {
                        if stringTimeOut == true {
                            self.alertMsg = "連線逾時(或網站故障)"
                        } else {
                            self.alertMsg = "帳號密碼輸入錯誤"
                        }
                        self.isLoginError = true
                    }

                    self.isLoading = false
                }
            }) {
                Text("會員登入")
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
            }
            .background(Color(UIColor(hex: "#03608cff")!))
            // .foregroundColor(Color(.init(red: 90, green: 46, blue: 18, alpha: 0)))
            .cornerRadius(10)
            .padding(.top, 25)
            } // end of NavigationLink
            .isDetailLink(false)
            .alert(isPresented:$isLoginError) {
                Alert(
                    title: Text(""),
                    message: Text(self.alertMsg),
                    dismissButton: .default(Text("確定"))
                )
            } // end of .alert
            
            NavigationLink(destination: actionList(), isActive: $isLoginOk) {
            Button(action: {
                if(kycSetting1.IpAddress == ""){
                    self.isLoginError = true
                    self.alertMsg = "請先設定IP 位址"
                    return
                }
                kycCommData1.KycApiUrl = kycSetting1.IpAddress
                kycCommData1.KycLoginUserName = ""
                kycCommData1.KycLoginPassWord = ""
                kycCommData1.KycLoginUid = ""
                kycCommData1.KycLoginisAdmin = ""
                let xxusername = ""
                let xxpassword = ""
                var postString = "op=kyc_signup_login_check&"
                postString += "username=" + xxusername + "&"
                postString += "password=" + xxpassword
                self.isLoading = true
                doApi.GetData(kycCommData1: self.kycCommData1 , postString: postString ){(value) in
                    let dataString = String(decoding: value, as: UTF8.self)
                    print("aaaaaa=\(dataString)")
                    let stringResult = dataString.contains("\"responseStatus\":\"GUEST\"")
                    let stringTimeOut = dataString.contains("KYC TIMEOUT")
                   
                    if stringResult == true {
                        self.showJson = try! JSONDecoder().decode(CheckLoginReturn.self , from: value)
                        if self.showJson?.responseStatus == "GUEST" {
                            self.isLoginOk = true
                        } else {
                            isLoginError = true
                        }
                    } else {
                        if stringTimeOut == true {
                            self.alertMsg = "連線逾時(或網站故障)"
                        }
                        self.isLoginError = true
                    }

                    self.isLoading = false
                }
            }) {
                Text("訪客登入")
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
            }
            .background(Color(UIColor(hex: "#03608cff")!))
            // .foregroundColor(Color(.init(red: 90, green: 46, blue: 18, alpha: 0)))
            .cornerRadius(10)
            .padding(.top, 25)
            } // end of NavigationLink
            .isDetailLink(false)
            .alert(isPresented:$isLoginError) {
                Alert(
                    title: Text(""),
                    message: Text(self.alertMsg),
                    dismissButton: .default(Text("確定"))
                )
            } // end of .alert
            
            Button(action: {
                appExit = true
            }) {
                Text("結束App")
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
            } // end of button  "結束"
            .background(Color(UIColor(hex: "#03608cff")!))
            .cornerRadius(10)
            .padding(.top, 25 )
            .padding(.leading, 25 )
            .alert(isPresented:$appExit) {
                Alert(
                    title: Text("您要結束APP ?"),
                    message: Text(""),
                    primaryButton: .destructive(Text("確定")) {
                        exit(1)
                    },
                    secondaryButton: .cancel(Text("取消"))
                )
            } // end of .alert
        } // end of HStack
     
    }
}

struct CheckLoginReturn: Codable{
    let responseStatus:  String
    let responseArray: loginUserData
}
struct loginUserData : Codable{
    let userId: String
    let isAdmin: String
    let token: String
}
