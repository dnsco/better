//
//  ContentView.swift
//  better
//
//  Created by Dennis Collinson on 12/15/20.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc

    @FetchRequest(
        sortDescriptors: [],
        animation: .default
    )
    private var activities: FetchedResults<Activity>

    @State var focusedActivity: Activity?
    @State var showAddSheet = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(activities.sorted {
                        $0.last_done_at < $1.last_done_at
                    }) { activity in
                        Button(action: { self.focusedActivity = activity }) { Text(activity.name) }
                    }.onDelete(perform: deleteItems)
                }

                ForEach(activities) { activity in
                    NavigationLink(
                        destination: ActivityDetail(
                            activity: activity,
                            focusedActivity: $focusedActivity
                        ),
                        tag: activity,
                        selection: $focusedActivity

                    ) { EmptyView() }.isDetailLink(false)
                }

            }.sheet(isPresented: $showAddSheet) {
                AddActivity { title in
                    self.addActivity(name: title)
                    self.showAddSheet.toggle()
                }
            }.navigationBarItems(
                trailing:
                Button(action: { self.showAddSheet.toggle() }) {
                    Label("Add Activity", systemImage: "plus")
                }
            ).navigationViewStyle(StackNavigationViewStyle())
        }

        .environment(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Key Path@*/ \.sizeCategory/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/ .extraExtraLarge/*@END_MENU_TOKEN@*/)
    }

    private func addActivity(name: String) {
        let newActivity = Activity(context: moc)
        newActivity.name = name

        try? moc.save()
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map {
                activities[$0]
            }.forEach(moc.delete)

            try? moc.save()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
