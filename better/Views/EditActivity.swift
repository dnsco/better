//
//  EditActivity.swift
//  better
//
//  Created by Dennis Collinson on 12/15/20.
//

import SwiftUI

struct EditActivity: View {
    @Environment(\.managedObjectContext) private var moc
    @Binding var activity: Activity
    @Binding var showEditSheet: Bool
    @Binding var focusedActivity: Activity?

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Name", text: $activity.name)
                }
                Spacer()
                Button(action: {
                    self.showEditSheet = false
                    self.focusedActivity = nil
                    moc.delete(self.activity)
                    try? moc.save()
                }) { Text("Deletelol") }
            }.navigationBarTitle("Edit Activity", displayMode: .inline)
                .navigationBarItems(
                    leading: Button("Cancel") {
                        moc.rollback()
                        showEditSheet = false
                    },
                    trailing: Button("Save") {
                        do {
                            try moc.save()
                        } catch {
                            fatalError("Can't update")
                        }
                        self.showEditSheet = false
                    }
                )
        }
    }
}

struct EditActivity_Previews: PreviewProvider {
    static var previews: some View {
        let activity = Activity(context: PersistenceController.preview.container.viewContext)
        activity.name = "Meditate"

        return NavigationView {
            EditActivity(
                activity: .constant(activity),
                showEditSheet: .constant(true),
                focusedActivity: .constant(activity)
            )
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
