//
//  signupForm.swift
//  kycSingup
//
//  Created by michael CHANG on 2021/11/10.
//

import SwiftUI

struct signupForm: View {
@StateObject var saveSignupForm = DoApi()
@EnvironmentObject var kycCommData1: KycCommData
@State var action_id: String
@State var actionDetail: ActionList1
@State var isNavigationBarHidden: Bool = true
@State var isLoading = false
@State var isLink = false
@Environment(\.presentationMode) var presentationMode
@State var kycFontSize: CGFloat  = 20

@State var kycName = ""
@State var kycTransPort = ""
@State var kycFood = ""
@State var kycActionDate = ""
@State var kycSession = ""
var body: some View {
    ZStack {
      VStack() { // 01
        VStack(alignment: .leading, spacing: 25) { // 02
            HStack{ // 01
                VStack{ // 01
                  Text("活動名稱：\(actionDetail.title)")
                  .font(.system(size: kycFontSize))
                  .frame(alignment: .leading)
                  .foregroundColor(Color.purple)
                } // VStack 01
            } // end of HStack 01
            
            nameField(kycName: $kycName)
            foodField(kycFood: $kycFood)
            dateField(kycActionDate: $kycActionDate)
            transPortField(kycTransPort: $kycTransPort)
            Checkbox(kycSession: $kycSession)
            
        } // end of VStack 02
      
        saveButton(kycName: $kycName , kycFood: $kycFood , kycActionDate: $kycActionDate , kycTransPort: $kycTransPort , kycSession: $kycSession , action_id: self.$action_id , isLoading: self.$isLoading)
      } // end of VStack 01
    } // end of ZStack
    .opacity(isLoading ? 0 : 1)
    .onAppear() {
        self.kycActionDate = actionDetail.action_date
    }
    LoadingView(isLoading: $isLoading).offset(y: 50)
    Spacer()
} // end body: some View


}

struct nameField: View {
    @Binding var kycName: String
    var body: some View {
        HStack{
            HStack{
                Text("姓名")
                    .font(.system(size: 20))
                    .foregroundColor(Color.red)
                
                TextField("", text: self.$kycName)
                    .frame(width: 300,height: 30).border(Color.black)
            }
         }
        .padding(.top , 20)
    }
}

/*
struct foodField_bk: View {
    @Binding var kycFood: String
    @State var mapChoioce = 0
    var settings = ["葷食", "素食", "不用餐"]
    var body: some View {
        HStack{
            Text("飲食")
                .font(.system(size: 20))
            Picker("Options", selection: $mapChoioce) {
                ForEach(0 ..< settings.count) { index in
                    Text(self.settings[index])
                        .tag(index)
                }
            } // end of Picker
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: mapChoioce) { _ in
                print(settings[mapChoioce])
                kycFood = settings[mapChoioce]
            } // end of onChange
        } // end of HStack
    }
}
*/

struct foodField: View {
    @Binding var kycFood: String
    @State var isOn1: Bool = true
    @State var isOn2: Bool = false
    @State var isOn3: Bool = false
    var body: some View {
        HStack{ // 01
            Text("飲食")
                .font(.system(size: 20))
                .foregroundColor(Color.red)
            HStack(spacing: 10){ // 02
                Toggle("葷食", isOn: self.$isOn1)
                  .toggleStyle(CheckboxToggleStyle(style: .circle))
                    .font(.system(size: 18))
                  .foregroundColor(.blue)
                  .onChange(of: isOn1) { value in
                        if value == true {
                           self.kycFood = "葷食"
                           self.isOn1 = true
                           self.isOn2 = false
                           self.isOn3 = false
                        }
                   }

                Toggle("素食", isOn: self.$isOn2)
                  .toggleStyle(CheckboxToggleStyle(style: .circle))
                    .font(.system(size: 18))
                  .foregroundColor(.blue)
                  .onChange(of: isOn2) { value in
                        if value == true {
                           self.kycFood = "素食"
                           self.isOn1 = false
                           self.isOn2 = true
                           self.isOn3 = false
                        }
                   }
                    .padding(.leading, 20)
                
                Toggle("不用餐", isOn: self.$isOn3)
                  .toggleStyle(CheckboxToggleStyle(style: .circle))
                    .font(.system(size: 18))
                  .foregroundColor(.blue)
                  .onChange(of: isOn3) { value in
                        if value == true {
                           self.kycFood = "不用餐"
                           self.isOn1 = false
                           self.isOn2 = false
                           self.isOn3 = true
                        }
                   }
                    .padding(.leading, 20)

            } // end of HStack 02
        } // end of HStack 01
        .onAppear() {
            self.kycFood = "葷食"
        }
    }
}

struct dateField: View {
    @Binding var kycActionDate: String
    
    var body: some View {
        HStack{
            Text("日期")
                .font(.system(size: 20))
                .foregroundColor(Color.red)
            Text(kycActionDate)
                .font(.system(size: 20))
                .foregroundColor(Color.blue)

        } // end of HStack
    }
}
/*
struct transPortField_bk: View {
    @Binding var kycTransPort: String
    @State var mapChoioce = 0
    var settings = ["自行前往", "公車", "火車", "高鐵", "飛機"]
    var body: some View {
        HStack{
            Text("交通")
                .font(.system(size: 20))
                .foregroundColor(Color.red)
            Picker("Options", selection: $mapChoioce) {
                ForEach(0 ..< settings.count) { index in
                    Text(self.settings[index])
                        .font(.system(size: 20))
                        .tag(index)
                }
            } // end of Picker
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: mapChoioce) { _ in
                print(settings[mapChoioce])
                kycTransPort = settings[mapChoioce]
            } // end of onChange
        } // end of HStack
    }
}
*/

struct transPortField: View {
    @Binding var kycTransPort: String
    @State var isOn1: Bool = true
    @State var isOn2: Bool = false
    @State var isOn3: Bool = false
    @State var isOn4: Bool = false
    @State var isOn5: Bool = false
    var body: some View {
        HStack{ // 01
            Text("交通")
                .font(.system(size: 20))
                .foregroundColor(Color.red)
            VStack(alignment: .leading , spacing:10){ // VStack 00
            HStack(spacing: 10){ // 02
                Toggle("自行前往", isOn: self.$isOn1)
                  .toggleStyle(CheckboxToggleStyle(style: .circle))
                    .font(.system(size: 18))
                  .foregroundColor(.blue)
                  .onChange(of: isOn1) { value in
                        if value == true {
                           self.kycTransPort = "自行前往"
                           self.isOn1 = true
                           self.isOn2 = false
                           self.isOn3 = false
                           self.isOn4 = false
                           self.isOn5 = false
                        }
                   }

                Toggle("公車", isOn: self.$isOn2)
                  .toggleStyle(CheckboxToggleStyle(style: .circle))
                    .font(.system(size: 18))
                  .foregroundColor(.blue)
                  .onChange(of: isOn2) { value in
                        if value == true {
                           self.kycTransPort = "公車"
                           self.isOn1 = false
                           self.isOn2 = true
                           self.isOn3 = false
                           self.isOn4 = false
                           self.isOn5 = false
                        }
                   }
                    .padding(.leading, 20)
                
                Toggle("火車", isOn: self.$isOn3)
                  .toggleStyle(CheckboxToggleStyle(style: .circle))
                    .font(.system(size: 18))
                  .foregroundColor(.blue)
                  .onChange(of: isOn3) { value in
                        if value == true {
                           self.kycTransPort = "火車"
                           self.isOn1 = false
                           self.isOn2 = false
                           self.isOn3 = true
                           self.isOn4 = false
                           self.isOn5 = false
                        }
                   }
                    .padding(.leading, 20)
            } // end of HStack 02
            
            HStack(spacing: 10){ // 03
                Toggle("高鐵", isOn: self.$isOn4)
                  .toggleStyle(CheckboxToggleStyle(style: .circle))
                    .font(.system(size: 18))
                  .foregroundColor(.blue)
                  .onChange(of: isOn4) { value in
                        if value == true {
                           self.kycTransPort = "高鐵"
                           self.isOn1 = false
                           self.isOn2 = false
                           self.isOn3 = false
                           self.isOn4 = true
                           self.isOn5 = false
                        }
                   }
                
                Toggle("飛機", isOn: self.$isOn5)
                  .toggleStyle(CheckboxToggleStyle(style: .circle))
                    .font(.system(size: 18))
                  .foregroundColor(.blue)
                  .onChange(of: isOn5) { value in
                        if value == true {
                           self.kycTransPort = "飛機"
                           self.isOn1 = false
                           self.isOn2 = false
                           self.isOn3 = false
                           self.isOn4 = false
                           self.isOn5 = true
                        }
                   }
                    .padding(.leading, 54)
            } // end of HStack 03
            } // VStack 00
        } // end of HStack 01
        .onAppear() {
            self.kycTransPort = "自行前往"
        }
    }
}

struct Checkbox: View {
    @Binding var kycSession: String
    @State var isOn1: Bool = false
    @State var isOn2: Bool = false
    @State var isOn3: Bool = false
    var body: some View {

        HStack{ // 01
            Text("場次")
                .font(.system(size: 20))
                .foregroundColor(Color.red)
            HStack(spacing: 10){ // 02
                Toggle("上午場", isOn: $isOn1)
                  .toggleStyle(CheckboxToggleStyle(style: .square))
                    .font(.system(size: 18))
                  .foregroundColor(.blue)
                  .onChange(of: isOn1) { value in
                        self.kycSession = ""
                        if isOn1 == true {
                           self.kycSession += "上午場,"
                        }
                        if isOn2 == true {
                           self.kycSession += "下午場,"
                        }
                        if isOn3 == true {
                           self.kycSession += "午夜場,"
                        }
                   }

                Toggle("下午場", isOn: $isOn2)
                  .toggleStyle(CheckboxToggleStyle(style: .square))
                  .foregroundColor(.blue)
                    .font(.system(size: 18))
                  .onChange(of: isOn2) { value in
                        self.kycSession = ""
                        if isOn1 == true {
                           self.kycSession += "上午場,"
                        }
                        if isOn2 == true {
                           self.kycSession += "下午場,"
                        }
                        if isOn3 == true {
                           self.kycSession += "午夜場,"
                        }
                   }.padding(.leading, 20)
                
                Toggle("午夜場", isOn: $isOn3)
                  .toggleStyle(CheckboxToggleStyle(style: .square))
                  .foregroundColor(.blue)
                    .font(.system(size: 18))
                  .onChange(of: isOn3) { value in
                        self.kycSession = ""
                        if isOn1 == true {
                           self.kycSession += "上午場,"
                        }
                        if isOn2 == true {
                           self.kycSession += "下午場,"
                        }
                        if isOn3 == true {
                           self.kycSession += "午夜場,"
                        }
                   }.padding(.leading, 20)
            } // end of HStack 02
        } // end of HStack 01
    }
}

struct CheckboxToggleStyle: ToggleStyle {
  @Environment(\.isEnabled) var isEnabled
  let style: Style // custom param

  func makeBody(configuration: Configuration) -> some View {
    Button(action: {
      configuration.isOn.toggle() // toggle the state binding
    }, label: {
      HStack {
        Image(systemName: configuration.isOn ? "checkmark.\(style.sfSymbolName).fill" : style.sfSymbolName)
          .imageScale(.large)
        configuration.label
      }
    })
    .buttonStyle(PlainButtonStyle()) // remove any implicit styling from the button
    .disabled(!isEnabled)
  }

  enum Style {
    case square, circle

    var sfSymbolName: String {
      switch self {
      case .square:
        return "square"
      case .circle:
        return "circle"
      }
    }
  }
}

struct saveButton: View {
    @Binding var kycName: String
    @Binding var kycFood: String
    @Binding var kycActionDate: String
    @Binding var kycTransPort: String
    @Binding var kycSession: String
    @Binding var action_id: String
    @Binding var isLoading: Bool
    
    @State var isSaveOk = false
    @State var isSaveError = false
    @State var alertMsg = ""
   
    @EnvironmentObject var kycCommData1: KycCommData
    @EnvironmentObject var kycSetting1: KycSetting
    @StateObject var saveSignupForm = DoApi()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack{
            NavigationLink(destination: actionList(), isActive: $isSaveOk) {
            Button(action: {
                if(self.kycName == ""){
                    self.isSaveError = true
                    self.alertMsg = "姓名不能空白"
                    return
                }
                if(self.kycSession == ""){
                    self.isSaveError = true
                    self.alertMsg = "請挑選要參加的場次"
                    return
                }
                /*
                print("kycName=\(kycName)")
                print("kycFood=\(kycFood)")
                print("kycActionDate=\(kycActionDate)")
                print("kycTransPort=\(kycTransPort)")
                print("kycSession=\(kycSession)")
               
                let json: [[String: String]] = [
                    ["姓名": kycName],
                    ["飲食": kycFood],
                    ["日期場次": kycActionDate],
                    ["產加場次": kycSession],
                    ["交通方式": kycTransPort]
                ]
                 */
                
                var jsonArray: [[String: String]] = [[String: String]]()
    
                jsonArray.append(["姓名": kycName])
                jsonArray.append(["飲食": kycFood])
                jsonArray.append(["日期場次": kycActionDate])
                jsonArray.append(["參加場次": kycSession])
                jsonArray.append(["交通方式": kycTransPort])
                let encoder = JSONEncoder()
                let data = try? encoder.encode(jsonArray)
                let jsonData = String(data: data!, encoding: .utf8)!
                // let jsonData = try? JSONSerialization.data(withJSONObject: jsonArray)
                
                self.isLoading = true
                var postString = "op=kyc_signup_data_insert&"
                postString += "userId=" + kycCommData1.KycLoginUid + "&"
                postString += "action_id=" + self.action_id + "&"
                postString += "jsonData=" + jsonData
                saveSignupForm.GetData(kycCommData1: self.kycCommData1, postString: postString){(value) in
                    let dataString = String(decoding: value, as: UTF8.self)
                    // print(dataString)
                    let stringResult = dataString.contains("\"responseStatus\":\"SUCCESS\"")
                    if stringResult == true {
                        self.alertMsg = "報名成功"
                        self.isSaveError = true
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        self.isSaveError = true
                    }
                    self.isLoading = false
                }
                
            }) {
                Text("確定報名")
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
            }
            .background(Color(UIColor(hex: "#03608cff")!))
            .cornerRadius(10)
            .padding(.top, 25)
            } // end of NavigationLink
            .isDetailLink(false)
            .alert(isPresented:$isSaveError) {
                Alert(
                    title: Text(""),
                    message: Text(self.alertMsg),
                    dismissButton: .default(Text("確定"))
                )
            } // end of .alert
            
        } // end of HStack
        LoadingView(isLoading: $isLoading).offset(y: 50)
    }
}
