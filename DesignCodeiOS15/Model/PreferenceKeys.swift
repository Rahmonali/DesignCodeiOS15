//
//  PreferenceKeys.swift
//  DesignCodeiOS15
//
//  Created by Rahmonali on 24/10/23.
//

import SwiftUI

struct ScrollPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
