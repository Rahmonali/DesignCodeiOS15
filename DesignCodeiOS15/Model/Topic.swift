//
//  Topic.swift
//  DesignCodeiOS15
//
//  Created by Rahmonali on 05/11/23.
//

import SwiftUI

struct Topic: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
}

var topics = [
    Topic(title: "iOS Development", icon: "iphone"),
    Topic(title: "UI Design", icon: "eyedropper"),
    Topic(title: "Web Development", icon: "laptopcomputer")
]
