//
//  FailureCategory.swift
//  FailureCat
//
//  Created by jamin on 4/17/25.
//

import Foundation
import SwiftUI

enum FailureCategory: String, CaseIterable, Codable {
    case challenge = "챌린지"
    case habit = "습관"
    case etc = "기타"
    
    var color: Color {
        switch self {
        case .challenge:
            return Color("color_challenge")
        case .habit:
            return Color("color_habit")
        case .etc:
            return Color("color_etc")
        }
    }
    
    var soundFileName: String {
        switch self {
        case .challenge: return "meow1"
        case .habit: return "meow2"
        case .etc: return "meow3"
        }
    }
}

extension FailureCategory {
    func imageName(isSelected: Bool) -> String {
        switch self {
        case .challenge: return isSelected ? "standing1" : "sleeping1"
        case .habit:     return isSelected ? "standing2" : "sleeping2"
        case .etc:       return isSelected ? "standing3" : "sleeping3"
        }
    }
}

extension FailureCategory {
    var standingImage: String {
        switch self {
        case .challenge: return "standing1"
        case .habit:     return "standing2"
        case .etc: return "standing3"
        }
    }
    
    var sleepingImage: String {
        switch self {
        case .challenge: return "sleeping1"
        case .habit: return "sleeping2"
        case .etc: return "sleeping3"
        }
    }
}
