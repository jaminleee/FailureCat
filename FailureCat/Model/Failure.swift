//
//  Failure.swift
//  FailureCat
//
//  Created by jamin on 4/15/25.
//

import Foundation
import SwiftData

import FirebaseFirestore

//@Model
//class Failure1 {
//    var content: String
//    var date: Date
//    var categoryString: String
//
//    var category: FailureCategory {
//        get {
//            FailureCategory(rawValue: categoryString) ?? .etc
//        }
//        set {
//            categoryString = newValue.rawValue
//        }
//    }
//    
//    init(content: String, date: Date, category: FailureCategory) {
//        self.content = content
//        self.date = date
//        self.categoryString = category.rawValue
//    }
//}



struct Failure: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    let content: String
    let date: Date
    let category: String
    
    var categoryEnum: FailureCategory {
            return FailureCategory(rawValue: category) ?? .etc
        }
}
