//
//  AppState.swift
//  kyctire
//
//  Created by michael CHANG on 2021/8/27.
//

import SwiftUI
import Combine

class AppState: ObservableObject {
    func reloadDashboard() {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.reloadDashboard()
    }
}
