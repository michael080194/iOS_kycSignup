//
//  about.swift
//  kycele
//
//  Created by michael CHANG on 2021/2/25.
//

import SwiftUI
struct AboutView: View {
    @State var selection:Set<UUID> = []
    @State var AboutInfos:[AboutInfo] = [
        AboutInfo(id:UUID(),c_item:"程式版本：",c_title:"V2021-11-15"),
        AboutInfo(id:UUID(),c_item:"開發工具：",c_title:"SwiftUI"),
        AboutInfo(id:UUID(),c_item:"程式開發：",c_title:"XXXX 社大")
    ]
    var body: some View {
        VStack{
            List (selection: $selection ){
                ForEach(AboutInfos){data in
                    HStack{
                    Text(data.c_item)
                        .foregroundColor(Color.pink)
                    Text(data.c_title)
                        .foregroundColor(Color.primary)
                    }
                }

            }
        }
    }
 
    struct AboutInfo:Identifiable{
        var id = UUID()
        var c_item:String = ""
        var c_title:String = ""
    }
}
