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
    @Binding var focusedActivity: Activity?

    @State var showEditSheet: Bool = false

    var body: some View {
        self.focusedActivity.map { _ in
            VStack {
                Button("DO IT", action: {
                    let completion = ActivityCompletion(context: moc)
                    completion.done_at = Date()
                    completion.activity = activity
                    try? moc.save()
                })

                ForEach(activity.completions, id: \.self) { completion in
                    Text("\(completion.done_at)")
                }
            }
            .sheet(isPresented: $showEditSheet, content: {
                EditActivity(
                    activity: .constant(activity),
                    showEditSheet: $showEditSheet,
                    focusedActivity: $focusedActivity
                )
            })
            .navigationBarTitle(activity.name, displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: { self.showEditSheet.toggle() }) {
                    Text("Edit")
                })
        }
    }
}

struct ActivityDetail_Previews: PreviewProvider {
    static var previews: some View {
        let activity = Activity(context: PersistenceController.preview.container.viewContext)
        activity.name = "Meditate"
        return NavigationView {
            ActivityDetail(
                activity: activity,
                focusedActivity: .constant(activity)
            )
            Spacer()
        }.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
