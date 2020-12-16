//
//  ActivityDetail.swift
//  better
//
//  Created by Dennis Collinson on 12/16/20.
//

import SwiftUI

struct ActivityDetail: View {
    let activity: Activity
    var body: some View {
        Text("\(activity.name!)").navigationBarTitle(activity.name!, displayMode: .inline)
    }
}

struct ActivityDetail_Previews: PreviewProvider {
    static var previews: some View {
        let activity = Activity(context: PersistenceController.preview.container.viewContext)
        activity.name = "Meditate"
        return NavigationView {
            ActivityDetail(activity: activity)
            Spacer()
        }
    }
}
