//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Лаборатория on 12.10.2023.
//

import SwiftUI

@main
struct ToDoListApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(Coordinator())
        }
    }
}
