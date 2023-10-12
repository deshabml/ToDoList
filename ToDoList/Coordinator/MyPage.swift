//
//  MyPage.swift
//  ToDoList
//
//  Created by Лаборатория on 12.10.2023.
//

import Foundation

enum MyPage: Hashable, Identifiable {

    case home
    case todo
    case settings

    var id: String {
        String(describing: self)
    }

    static func == (lhs: MyPage, rhs: MyPage) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    func hash(into hasher: inout Hasher) {
        switch self {
        case .home:
            hasher.combine("home")
        case .todo:
            hasher.combine("todo")
        case .settings:
            hasher.combine("settings")
        }
    }
}
