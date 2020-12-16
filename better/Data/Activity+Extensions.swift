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
}
