//
//  HomeView.swift
//  ToDoList
//
//  Created by Лаборатория on 12.10.2023.
//

import SwiftUI

struct HomeView: View {

    @StateObject var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                TodoTable()
                    .environmentObject(viewModel)
                if viewModel.todos.isEmpty {
                    Text("There are no tasks yet! Add the first one!")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.white)
                }
                if viewModel.showSetTodoView {
                    Rectangle()
                        .ignoresSafeArea()
                        .opacity(0.3)
                        .onTapGesture {
                            withAnimation {
                                viewModel.showSetTodoView.toggle()
                            }
                        }
                    SetTodoView(viewModel: SetTodoViewModel())
                        .environmentObject(viewModel)
                        .background {
                            Image(.bg)
                        }
                        .transition(.move(edge: .bottom))
                        .cornerRadius(18)
                        .shadow(radius: 2)
                        .padding()
                }
            }
            .overlay(alignment: .bottomTrailing) {
                buttonPlus()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background{
            Image("bgHome")
                .ignoresSafeArea()
                .scaledToFill()
        }
        .onAppear {
            viewModel.getAllTodos()
        }
    }
}

#Preview {
    HomeView()
}

extension HomeView {

    private func buttonPlus() -> some View {
        Button {
            withAnimation {
                viewModel.showSetTodoView.toggle()
            }
        } label: {
            Image(systemName: "plus")
                .font(.title2)
                .bold()
                .padding()
                .foregroundColor(.white)
                .background(.mint)
                .cornerRadius(40)
                .padding(8)
        }
    }
}
