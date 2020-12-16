//
//  EditActivity.swift
//  better
//
//  Created by Dennis Collinson on 12/15/20.
//

import SwiftUI

struct EditActivity: View {
    @Environment(\.presentationMode) var presentationMode

//
//    struct ActivityProps {
//        var name: String
//
//        init(name: String?) {
//            self.name = name ?? "New Activity"
//        }
//
//    }
    @Binding var activity: Activity
    @Binding var isShowingEdit: Bool
    @State var name: String = ""

    init(activity: Binding<Activity>, isShowingEdit: Binding<Bool>) {
        _activity = activity
        _isShowingEdit = isShowingEdit
        _name = State(wrappedValue: self.activity.name)
    }

    var body: some View {
        return VStack {
            TextField("Name", text: $name, onEditingChanged: { _ in self.activity.name = self.name })
            Button(action: {
                self.isShowingEdit = false
//                    self.presentationMode.wrappedValue.dismiss()
            }
            ) { Text("Save") }
        }
    }
}

struct EditActivity_Previews: PreviewProvider {
    static var previews: some View {
        let activity = Activity(context: PersistenceController.preview.container.viewContext)
        activity.name = "Meditate"
        return EditActivity(activity: .constant(activity), isShowingEdit: .constant(true))
    }
}
