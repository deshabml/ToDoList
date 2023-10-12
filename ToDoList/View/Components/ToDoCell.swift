//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Лаборатория on 12.10.2023.
//

import SwiftUI

struct ToDoCell: View {

    var todo: ToDo

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Circle()
                        .frame(width: 12)
                        .foregroundColor(
                            getColor()
                        )
                    Text(todo.title).bold()
                    Spacer()

                }
                Text(todo.taskDescription)

            }
            VStack(alignment: .trailing) {
                Text(getDate())
                    .frame(width: 110, height: 30)
                    .background(getColor())
                Text(getTime())
                    .frame(width: 80, height: 30)
                    .background(getColor())
            }
        }.padding()
            .background(.white)
            .cornerRadius(12)
            .shadow(radius: 1)

    }

    func getDate() -> String {
        let deadline = todo.deadline
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let str = formatter.string(from: deadline)
        return str
    }

    func getTime() -> String {
        let deadline = todo.deadline
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let str = formatter.string(from: deadline)
        return str
    }


    func getColor() -> Color {
        switch todo.category {
        case TodoCategory.urgentImp.rawValue:
            return .green
        case TodoCategory.urgentNotImp.rawValue:
            return .blue
        case TodoCategory.notUrgentImp.rawValue:
            return .yellow
        case TodoCategory.notUrgentNotImp.rawValue:
            return .gray
        default: return .blue
        }
    }
}

#Preview {
    ToDoCell(todo: ToDo(title: "Task title",
                        descrioption: "Task descrioption",
                        deadline: Date(),
                        category: .notUrgentImp))
}
