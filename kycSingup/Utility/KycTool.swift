//
//  KycTool.swift
//  kycele
//
//  Created by michael CHANG on 2021/3/4.
//
import SwiftUI
import UIKit
import Foundation
//class KycTool: ObservableObject {
//    @Published var KycApiUrl = "http://michael1.cp35.secserverpros.com/modules/kyc_signup/api.php"
//}

class KycCommData: ObservableObject {
      @Published var KycApiUrl: String = ""   // "http://192.168.0.105/modules/kyc_signup/app_api.php"
      @Published var KycLogin: String = ""
      @Published var KycLoginUid: String = ""
      @Published var KycLoginisAdmin: String = ""
      @Published var KycLoginToken: String = ""
      @Published var KycLoginUserName: String = ""
      @Published var KycLoginPassWord: String = ""
      @Published var KycFontSize: CGFloat  = 20
}

class KycSetting: ObservableObject {
    init() {
        UserDefaults.standard.register(defaults: [
            "view.preferences.IpAddress" : "",
            "view.preferences.UserName" : "1",
            "view.preferences.PassWord" : "1",
        ])
    }
    
    @Published var IpAddress: String = UserDefaults.standard.object(forKey: "view.preferences.IpAddress")  as? String ?? "" {
        didSet {
            UserDefaults.standard.set(IpAddress, forKey: "view.preferences.IpAddress")
        }
    }
    
    
    @Published var UserName: String = UserDefaults.standard.object(forKey: "view.preferences.UserName")  as? String ?? ""{
        didSet {
            UserDefaults.standard.set(UserName, forKey: "view.preferences.UserName")
        }
    }
    
    @Published var PassWord: String = UserDefaults.standard.object(forKey: "view.preferences.PassWord")  as? String ?? ""{
        didSet {
            UserDefaults.standard.set(PassWord, forKey: "view.preferences.PassWord")
        }
    }
    
}

struct KycNoSepratorList<Content>: View where Content: View {

    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
        
    }
        
    var body: some View {
        if #available(iOS 14.0, *) {
           ScrollView {
               LazyVStack(spacing: 0) {
                self.content()
             }
           }
        } else {
            List {
                self.content()
            }
            .onAppear {
               UITableView.appearance().separatorStyle = .none
            }.onDisappear {
               UITableView.appearance().separatorStyle = .singleLine
            }
        }
    }
}

struct Wrap: ViewModifier {
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content.frame(width: geometry.size.width , alignment: .leading)
        }
    }
}

class DoApi: ObservableObject{
    func GetData(kycCommData1: KycCommData , postString: String , completion: @escaping  (_ result: Data) -> ()) {
        // print("BBB=\(kycCommData1.KycApiUrl)")
        guard let url = URL(string: kycCommData1.KycApiUrl)
        else { return }
        // print("url = \(url)")
        let data0 = loginUserData(userId: "", isAdmin: "", token: "")
        let data1 = CheckLoginReturn(responseStatus: "KYC TIMEOUT" , responseArray: data0) // For Dedfalut Error Message
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data2 = try? encoder.encode(data1) else { return  }
        // print("url=\(url)")
        var request = URLRequest(url: url, timeoutInterval: 15)
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: String.Encoding.utf8);
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request, completionHandler:{ (data, response, error) -> Void in
           DispatchQueue.main.async {
               if let error = error {
//                  print("連線逾時")
                  print (error)
                  completion(data2)
                  return
               }
               completion(data!)
           } // end of DispatchQueue.main.async

        })
        task.resume()
    }
}


struct LoadingView_1100901: View {
    @Binding var isLoading: Bool
    var body: some View {
          ZStack {
              Circle()
                  .stroke(Color(.systemGray5), lineWidth: 7)
                  .frame(width: 50, height: 50)
              
              Circle()
                  .trim(from: 0, to: 0.2)
                  .stroke(Color.green, lineWidth: 3)
                  .frame(width: 50, height: 50)
                  .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .animation(Animation.linear(duration: 0.5).repeatForever(autoreverses: false))
          } // end of ZStack
          .opacity(isLoading ? 1 : 0)
      }
}

struct LoadingView: View {
    @Binding var isLoading: Bool
    var body: some View {
        ZStack{
            Color(.systemBackground)
                .ignoresSafeArea()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .black))
                .scaleEffect(3)
        } .opacity(isLoading ? 1 : 0)
    }
}

struct LoadingViewProgress: View {
    @Binding var isLoading: Bool
    var body: some View {
        ZStack {
            Text("Loading")
                .font(.system(.body, design: .rounded))
                .bold()
                .offset(x: 0, y: -25)
 
            RoundedRectangle(cornerRadius: 3)
                .stroke(Color(.systemGray5), lineWidth: 3)
                .frame(width: 250, height: 3)
 
            RoundedRectangle(cornerRadius: 3)
                .stroke(Color.green, lineWidth: 3)
                .frame(width: 30, height: 3)
                .offset(x: isLoading ? 110 : -110, y: 0)
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
        }
    }
}

struct ListDataNormal: View {
    var title: String
    var field: String
    @EnvironmentObject var kycCommData1: KycCommData
    @State var kycFontSize: CGFloat  = 18
    var body: some View {
        HStack(alignment: .top , spacing: 1) {
            Text("\(title)：")
                .font(.system(size: kycFontSize))
                .font(.body)
                .foregroundColor(Color.pink)
            Text(field)
                .font(.system(size: kycFontSize))
                .frame(minWidth: 20, maxWidth: .infinity , alignment: .leading)
                .font(.headline)
        } // end of HStack
        .onAppear(){
            self.kycFontSize =  kycCommData1.KycFontSize
        }
    }
}

struct ListDataLimit: View {
    @EnvironmentObject var kycCommData1: KycCommData
    var title: String
    var field: String
    @State var kycFontSize: CGFloat  = 18
    var body: some View {
        HStack(alignment: .lastTextBaseline, spacing: 1) {
            if(title != ""){
            Text("\(title)：")
                .font(.system(size: kycFontSize))
                .font(.body)
                .foregroundColor(Color.pink)
            }
            Text(field)
                .font(.system(size: kycFontSize))
                .frame(minWidth: 20, maxWidth: .infinity , alignment: .leading)
                .font(.headline)
                .lineLimit(1)
        } // end of HStack
        .onAppear(){
            self.kycFontSize =  kycCommData1.KycFontSize
        }

    }
}

struct DatePickerWithButtons: View {
        @Binding var showDatePicker: Bool
        @Binding var close_date: String
        @Binding var close_time: String
        @State var selectedDate: Date = Date()
        var body: some View {
            ZStack {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.bottom)
                VStack {
                    DatePicker("Test", selection: $selectedDate, displayedComponents: [.date])
                        .datePickerStyle(GraphicalDatePickerStyle())
                    
                    
                    Divider()
                    HStack {
                        
                        Button(action: {
                            showDatePicker = false
                        }, label: {
                            Text("放棄").font(.title)
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            let savedDate = selectedDate
                            let fixdate = Calendar.current.date(byAdding: .hour, value: 0, to: savedDate)
                            let dateFormatter = DateFormatter()
                            let _ = dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                            let dateString = dateFormatter.string(from: fixdate!) // 2021-04-30 09:33
                            let arrStr = Array(dateString) // 2021-04-29 23:26:00 +0000
                            close_date = String(arrStr[0..<10])
                            close_time = String(arrStr[11...])
                            showDatePicker = false
                        }, label: {
                            Text("取回".uppercased())
                                .font(.title)
                                .bold()
                        })
                        
                    }
                    .padding(.horizontal)

                } // end of VStack
                .background(
                    Color.yellow.cornerRadius(30)
                )
            }
//            .background(Color.yellow)

        } // end of some view
    }


class NumbersOnly: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter { $0.isNumber }
            
            if value != filtered {
                value = filtered
            }
        }
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
