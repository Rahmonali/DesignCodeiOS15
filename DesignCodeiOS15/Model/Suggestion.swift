//
//  Suggestion.swift
//  DesignCodeiOS15
//
//  Created by Rahmonali on 29/10/23.
//

import SwiftUI

struct Suggestion: Identifiable {
    let id = UUID()
    var text: String
}

var suggestions = [
    Suggestion(text: "SwiftUI"),
    Suggestion(text: "React"),
    Suggestion(text: "Design")
]
