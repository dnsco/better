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
        sortDescriptors: [NSSortDescriptor(keyPath: \Activity.name_, ascending: true)],
        animation: .default
    )
    private var activities: FetchedResults<Activity>

    @State var isPresented = false

    var body: some View {
        NavigationView {
            List {
                ForEach(activities) { activity in
                    NavigationLink(destination: ActivityDetail(activity: activity)) {
                        Text("\(activity.name)")
                    }
                }
                .onDelete(perform: deleteItems)
            }.sheet(isPresented: $isPresented) {
                AddActivity { title in
                    self.addActivity(name: title)
                    self.isPresented.toggle()
                }
            }.navigationBarItems(
                trailing:
                Button(action: { self.isPresented.toggle() }) {
                    Label("Add Activity", systemImage: "plus")
                }
            )
        }
    }

    private func addActivity(name: String) {
        let newActivity = Activity(context: moc)
        newActivity.name = name

        do {
            try moc.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map {
                activities[$0]
            }.forEach(moc.delete)

            do {
                try moc.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
