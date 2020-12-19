//
//  Activity+Extensions.swift
//  better
//
//  Created by Dennis Collinson on 12/16/20.
//

import Foundation

extension Activity {
    var name: String {
        get { name_ ?? "New Activity" }
        set {
            name_ = newValue
        }
    }

    var completions: [ActivityCompletion] {
        completions_?.sortedArray(
            using: [NSSortDescriptor(key: "done_at_", ascending: false)]
        ) as? [ActivityCompletion] ?? []
    }

    var last_done_at: Date {
        completions.first?.done_at ?? Date(timeIntervalSince1970: 0)
    }
}
