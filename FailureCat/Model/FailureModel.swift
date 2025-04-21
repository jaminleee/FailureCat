//
//  FailureModel.swift
//  FailureCat
//
//  Created by jamin on 4/14/25.
//

import SwiftUI

struct FailureModel: Hashable, Identifiable {
    let id = UUID()
    let content: String
    let date: String
    let category: String
}
