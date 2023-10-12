//
//  MainView.swift
//  ToDoList
//
//  Created by Лаборатория on 12.10.2023.
//

import SwiftUI

struct MainView: View {

    @EnvironmentObject var coordinator: Coordinator

    var body: some View {
            mainView
    }

}

#Preview {
    MainView()
        .environmentObject(Coordinator())
}

extension MainView {

    private var mainView: some View {
        VStack {
            TabView(selection: $coordinator.tab) {
                tabItem(myPage: .home,
                        imageName: "checkmark.seal",
                        myTab: .home)
                .navigationTitle("Home")
                tabItem(myPage: .settings,
                        imageName: "gamecontroller",
                        myTab: .settings)
                .navigationTitle("Home")
            }
        }
        .preferredColorScheme(.light)
    }

    private func tabItem(myPage: MyPage,imageName: String, myTab: MyTab) -> some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.getPage(myPage)
                .navigationDestination(for: MyPage.self) { page in
                    coordinator.getPage(page)
                }
        }
        .tabItem {
            Image(systemName: imageName)
                .frame(width: 30, height: 30)
            Text(myTab.rawValue)
        }
        .tag(myTab)
    }
}
