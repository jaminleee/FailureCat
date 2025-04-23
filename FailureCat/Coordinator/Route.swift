//
//  Route.swift
//  FailureCat
//
//  Created by jamin on 4/21/25.
//

import Foundation

enum Route: Hashable {
    case create(failure: Failure? = nil)
    case detail(id: String)
    case list(category: FailureCategoryFilter? = nil)
}
    


