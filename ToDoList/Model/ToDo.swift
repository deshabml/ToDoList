//
//  ToDo.swift
//  ToDoList
//
//  Created by Лаборатория on 12.10.2023.
//

import Foundation
import RealmSwift

class ToDo: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var title: String
    @Persisted var taskDescription: String
    @Persisted var deadline: Date
    @Persisted var createDate = Date()
    @Persisted var category: String
    @Persisted var completed: Bool = false

    convenience init(title: String, descrioption: String, deadline: Date, category: TodoCategory) {
        self.init()
        self.id = UUID().uuidString //Universal Unique IDentifier
        self.title = title
        self.taskDescription = descrioption
        self.deadline = deadline
        self.category = category.rawValue
    }
}

extension ToDo {
    override var description: String { "\(self.title). C дедлайном: \(self.deadline)" }
}

enum TodoCategory: String, CaseIterable {
    case urgentImp = "Важное срочное"
    case urgentNotImp = "Важное несрочное"
    case notUrgentImp = "Неважное срочное"
    case notUrgentNotImp = "Неважное несрочное"
}
