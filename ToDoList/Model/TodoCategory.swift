//
//  TodoCategory.swift
//  ToDoList
//
//  Created by Лаборатория on 13.10.2023.
//

import Foundation

enum TodoCategory: String, CaseIterable {
    case urgentImp = "Important urgent"
    case urgentNotImp = "Important non-urgent"
    case notUrgentImp = "Unimportant urgent"
    case notUrgentNotImp = "Unimportant non-urgent"
}
