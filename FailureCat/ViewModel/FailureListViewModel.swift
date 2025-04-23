//
//  FailureListViewModel.swift
//  FailureCat
//
//  Created by jamin on 4/23/25.
//

import Foundation

@MainActor
final class FailureListViewModel: ObservableObject {
    @Published var failures: [Failure] = []
    
    func loadFailures() {
        FirestoreManager().fetchFailures { [weak self] fetched in
            self?.failures = fetched
        }
    }
}
