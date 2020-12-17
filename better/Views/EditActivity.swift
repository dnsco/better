//
//  EditActivity.swift
//  better
//
//  Created by Dennis Collinson on 12/15/20.
//

import SwiftUI

struct EditActivity: View {
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.presentationMode) var presentationMode
    @Binding var activity: Activity
    @Binding var isShowingEdit: Bool

    var body: some View {
        return VStack {
            Form {
                TextField("Name", text: $activity.name)
            }
            Button(action: {
                do {
                    try moc.save()
                } catch {
                    fatalError("Can't update")
                }
                self.isShowingEdit = false
            }) { Text("Save") }
        }.navigationBarTitle("Edit Activity", displayMode: .inline)
    }
}

struct EditActivity_Previews: PreviewProvider {
    static var previews: some View {
        let activity = Activity(context: PersistenceController.preview.container.viewContext)
        activity.name = "Meditate"
        return NavigationView {
            EditActivity(activity: .constant(activity), isShowingEdit: .constant(true)).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
