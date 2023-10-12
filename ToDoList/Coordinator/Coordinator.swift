//
//  Coordinator.swift
//  ToDoList
//
//  Created by Лаборатория on 12.10.2023.
//

import SwiftUI

@MainActor
final class Coordinator: ObservableObject {

    @Published var path = NavigationPath()
    @Published var page: MyPage = .home
    @Published var tab: MyTab = MyTab.home

    func goHome() {
        path.removeLast(path.count)
    }

    @ViewBuilder
    func getPage(_ page: MyPage) -> some View {
        switch page {
            case .home:
                HomeView()
            case .todo:
                TodoView()
            case .settings:
                SettingsView()
        }
    }

}
