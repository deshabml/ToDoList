//
//  ToDoCellViewModel.swift
//  ToDoList
//
//  Created by Лаборатория on 13.10.2023.
//

import Foundation

class ToDoCellViewModel: ObservableObject {

    @Published var todo: ToDo

    init(todo: ToDo) {
        self.todo = todo
    }
}
