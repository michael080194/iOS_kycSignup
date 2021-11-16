//
//  setting.swift
//  kycele
//
//  Created by michael CHANG on 2021/11/07.
//

    import SwiftUI

    struct SettingsView: View {
         @Binding var tabSelection: Int
         @EnvironmentObject var kycSetting: KycSetting
         @State var color = Color.black.opacity(0.7)
         @State var SettingIpAddress = ""
         @State var SettingCompId = ""
         @State var SettingUser = ""
         @State var SettingPass = ""
         @State var visible = false
         @State var alert = false
         @State var error = ""
         var body: some View{
             
             ZStack{
                 VStack{
                    Text("歡迎使用 XOOPS 報名系統")
                    Text("請預先設定您的  登錄資訊")
                    SettingIpAddressField(SettingIpAddress: $SettingIpAddress)
                    SettingUserField(SettingUser: $SettingUser)
                    SettingPassField(visible : $visible , SettingPass: $SettingPass , color: $color)
                    SaveButton(tabSelection: $tabSelection , SettingIpAddress: $SettingIpAddress , SettingUser: $SettingUser , SettingPass: $SettingPass, error: $error , alert: $alert)
                    Spacer()
                 }
                 .padding(.horizontal, 25)
                 .onAppear() {
                    self.SettingIpAddress = kycSetting.IpAddress
                    if self.SettingIpAddress == "" {
                        SettingIpAddress = "http://192.168.0.105/modules/kyc_signup/app_api.php"
                    }
                    self.SettingUser = kycSetting.UserName
                    self.SettingPass = kycSetting.PassWord
                 }
                 
                 if self.alert{
                    ErrorView(alert: self.$alert, error: self.$error)
                 }
             } // end of ZStack
         }
    }
struct SettingIpAddressField: View {
    @Binding var SettingIpAddress: String
    var body: some View {
        HStack{
            HStack{
                Text("網站位址")
                    .font(.system(size: 20))
                
                TextEditor(text: self.$SettingIpAddress)
                    .frame(height: 150).border(Color.black)
            }
            
            // This button just for layout beautiful
            // I don't want this button show
            Button(action: {
            }) {
                Image(systemName: "eye.slash.fill" )
                    .opacity(0)
                  
            }
         }
        .padding(.top , 10)
    }
}


    struct SettingUserField: View {
        @Binding var SettingUser: String
        var body: some View {
            HStack{
                HStack{
                    Text("預設帳號")
                        .font(.system(size: 20))
                    
                    TextField("", text: self.$SettingUser)
                        .frame(height: 30).border(Color.black)
                }
                
                // This button just for layout beautiful
                // I don't want this button show
                Button(action: {
                }) {
                    Image(systemName: "eye.slash.fill" )
                        .opacity(0)
                      
                }
             }
            .padding(.top , 10)
        }
    }

    struct SettingPassField: View {
        @Binding var visible: Bool
        @Binding var SettingPass: String
        @Binding var color: Color
        var body: some View {
            HStack{ // 01
                HStack{ // 02
                    Text("預設密碼")
                        .font(.system(size: 20))
                        
                    if self.visible{
                        TextField("", text: self.$SettingPass)
                            .frame(height: 30).border(Color.black)
                    }else{
                        SecureField("", text: self.$SettingPass)
                            .frame(height: 30).border(Color.black)
                    }
                } // end of HStack02
                
                Button(action: {
                    self.visible.toggle()
                }) {
                    Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(self.color)
                }
                
            } // end of HStack01
            .padding(.top , 10)
          
        }
    }

    struct SaveButton: View {
        @Binding var tabSelection: Int
        @Binding var SettingIpAddress: String
        @Binding var SettingUser: String
        @Binding var SettingPass: String
        @Binding var error: String
        @Binding var alert: Bool
        @State private var loginAlert = false
        @EnvironmentObject var appState: AppState
        @EnvironmentObject var kycSetting: KycSetting
        var body: some View {
            HStack{
                Button(action: {
//                    let defaults = UserDefaults.standard
//                    defaults.set(self.SettingCompId , forKey: "CompId")
//                    defaults.set(self.SettingUser, forKey: "UserName")
//                    defaults.set(self.SettingPass, forKey: "PassWord")
                      kycSetting.IpAddress   = self.SettingIpAddress
                      kycSetting.UserName = self.SettingUser
                      kycSetting.PassWord = self.SettingPass
                      self.tabSelection = 1
                }) {
                    Text("儲存")
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                }
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.top, 25)
          
                
                Button(action: {
//                    loginAlert = true
                    self.tabSelection = 1
                }) {
                    Text("放棄")
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                } // end of button  "結束"
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.top, 25 )
                .padding(.leading, 25 )

            } // end of HStack
         
        }
        
        func verify(){
            if self.SettingUser != "" && self.SettingPass != ""{
                print("AAA-01")
                self.alert = false
            }else{
                print("BBB-01")
                self.error = "Please fill all the contents properly"
                self.alert = true
            } // end else if
        } // end of verify
        
        func GetUserDefaults(){
            let defaults = UserDefaults.standard
            if let stringOne = defaults.string(forKey: "User") {
                print(stringOne)
            }
            if let stringTwo = defaults.string(forKey: "Pass") {
                print(stringTwo)
            }
        } // end of GetUserDefaults
    }

