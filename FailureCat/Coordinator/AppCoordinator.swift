//
//  AppCoordinator.swift
//  FailureCat
//
//  Created by jamin on 4/21/25.
//

import Foundation
import SwiftUI

@MainActor
class AppCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    func push(_ route: Route) {
        path.append(route)
    }
    
    func goToCreate(failure: Failure? = nil) {
        push(.create(failure: failure))
    }
    
    func goToDetail(failure: Failure) {
        guard let id = failure.id else { return }
            push(.detail(id: id))
    }
    
    func goToList(category: FailureCategoryFilter? = nil) {
        push(.list(category: category))
    }
    
    func goBack() {
        path.removeLast()
    }
    
    func resetNavigation() {
        path.removeLast(path.count)
    }
    

}
