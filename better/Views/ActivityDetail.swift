//
//  ActivityDetail.swift
//  better
//
//  Created by Dennis Collinson on 12/16/20.
//

import SwiftUI

struct ActivityDetail: View {
    @Environment(\.managedObjectContext) private var moc

    @ObservedObject var activity: Activity
    @State var isShowingEdit: Bool = false
    var body: some View {
        Text("Activities go here lol")
            .sheet(isPresented: $isShowingEdit, content: {
                NavigationView {
                    EditActivity(activity: .constant(activity), isShowingEdit: $isShowingEdit)
                        .navigationBarItems(
                            leading: Button("Cancel") {
                                moc.rollback()
                                isShowingEdit = false
                            })
                }

            })
            .navigationBarTitle(activity.name, displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: { self.isShowingEdit.toggle() }) {
                    Text("Edit")
                })
    }
}

struct ActivityDetail_Previews: PreviewProvider {
    static var previews: some View {
        let activity = Activity(context: PersistenceController.preview.container.viewContext)
        activity.name = "Meditate"
        return NavigationView {
            ActivityDetail(activity: activity)
            Spacer()
        }.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
