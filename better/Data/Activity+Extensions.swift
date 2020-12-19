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
        let set = completions_?.sortedArray(using: [NSSortDescriptor(key: "done_at_", ascending: true)]) as? [ActivityCompletion] ?? []
        return set.sorted {
            $0.done_at < $1.done_at
        }
    }
}
