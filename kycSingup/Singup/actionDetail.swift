//
//  actionDetail.swift
//  kycSingup
//
//  Created by michael CHANG on 2021/11/10.
//

import SwiftUI

struct actionDetail: View {
    @EnvironmentObject var kycCommData1: KycCommData
    @State var actionDetail: ActionList1

    @Environment(\.presentationMode) var presentationMode
    @State var kycFontSize: CGFloat  = 20
    
    @State var k_candidate = ""
    @State var k_signup_candidate = ""
    @State var k_can_signup = 0

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 20){
                HStack{
                    Text("活動名稱：")
                            .font(.system(size: kycFontSize))
                            .frame(alignment: .topLeading)
                            .foregroundColor(Color.red)
                    Text(actionDetail.title)
                            .font(.system(size: kycFontSize))
                            .frame(alignment: .topLeading)
                            .foregroundColor(Color.blue)
                }
                HStack{
                    Text("活動說明：")
                            .font(.system(size: kycFontSize))
                            .frame(alignment: .topLeading)
                            .foregroundColor(Color.red)
                    Text(actionDetail.detail)
                            .font(.system(size: kycFontSize))
                            .frame(alignment: .topLeading)
                            .foregroundColor(Color.blue)
                }
                
                HStack{
                    Text("報名截止：")
                            .font(.system(size: kycFontSize))
                            .frame(alignment: .topLeading)
                            .foregroundColor(Color.red)
                    Text(actionDetail.end_date)
                            .font(.system(size: kycFontSize))
                            .frame(alignment: .topLeading)
                            .foregroundColor(Color.blue)
                }
                HStack{
                    Text("活動日期：")
                            .font(.system(size: kycFontSize))
                            .frame(alignment: .topLeading)
                            .foregroundColor(Color.red)
                    Text(actionDetail.action_date)
                            .font(.system(size: kycFontSize))
                            .frame(alignment: .topLeading)
                            .foregroundColor(Color.blue)
                }
                HStack{
                    Text("可報人數：")
                            .font(.system(size: kycFontSize))
                            .frame(alignment: .topLeading)
                            .foregroundColor(Color.red)
                    Text(actionDetail.number+self.k_candidate)
                            .font(.system(size: kycFontSize))
                            .frame(alignment: .topLeading)
                            .foregroundColor(Color.blue)
                }
                HStack{
                    Text("已報人數：")
                            .font(.system(size: kycFontSize))
                            .frame(alignment: .topLeading)
                            .foregroundColor(Color.red)
                    Text(String(actionDetail.signup_people-actionDetail.signup_candidate)+self.k_signup_candidate)
                            .font(.system(size: kycFontSize))
                            .frame(alignment: .topLeading)
                            .foregroundColor(Color.blue)
                }
                HStack{
                    Text("尚可報名：")
                            .font(.system(size: kycFontSize))
                            .frame(alignment: .topLeading)
                            .foregroundColor(Color.red)
                    Text(String(self.k_can_signup))
                            .font(.system(size: kycFontSize))
                            .frame(alignment: .topLeading)
                            .foregroundColor(Color.blue)
                }
            } // VStack
        
        } // end of ZStack
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
        }
        Spacer()
        Spacer()
    } // end body: some View
  
}

