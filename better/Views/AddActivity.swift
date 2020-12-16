//
//  AddItem.swift
//  better
//
//  Created by Dennis Collinson on 12/15/20.
//

import SwiftUI

struct AddActivity: View {
    static let DefaultName = "New Activity"

    @State var name = ""
    let onComplete: (String) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")) {
                    TextField("Title", text: $name)
                }

                Section {
                    Button(action: addMoveAction) {
                        Text("New Activity")
                    }
                }
            }
            .navigationBarTitle(Text("Add Activity"), displayMode: .inline)
        }
    }

    private func addMoveAction() {
        onComplete(name.isEmpty ? AddActivity.DefaultName : name)
    }
}

struct AddActivity_Previews: PreviewProvider {
    static var previews: some View {
        AddActivity { _ in }
    }
}
