//
//  SettingsView.swift
//  ToDoList
//
//  Created by Лаборатория on 12.10.2023.
//

import SwiftUI

struct SettingsView: View {

    @EnvironmentObject var coordinator: Coordinator
    @AppStorage(PersistedKey.showArchive.rawValue) var showArchive: Bool = true

    var body: some View {
        HStack {
            Text("Show archive?")
            Spacer()
            Toggle("", isOn: $showArchive)
        }.padding()
    }
}

#Preview {
    SettingsView()
}
