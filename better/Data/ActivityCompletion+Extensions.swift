//
//  ActivityCompletion+Extensions.swift
//  better
//
//  Created by Dennis Collinson on 12/18/20.
//

import Foundation

extension ActivityCompletion {
    var done_at: Date {
        get { done_at_ ?? Date() }
        set {
            done_at_ = newValue
        }
    }
}
