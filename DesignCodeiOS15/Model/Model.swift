//
//  Model.swift
//  DesignCodeiOS15
//
//  Created by Rahmonali on 28/10/23.
//

import SwiftUI
import Combine

class Model: ObservableObject {
    @Published var showDetail: Bool = false
    @Published var selectedModal: Modal = .signIn
}

enum Modal: String {
    case signUp
    case signIn
}
