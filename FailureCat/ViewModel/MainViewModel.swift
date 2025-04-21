//
//  MainViewModel.swift
//  FailureCat
//
//  Created by jamin on 4/17/25.
//

import Foundation
import SwiftData

@MainActor
class MainViewModel: ObservableObject {
    @Published var failures: [Failure] = []
    
    private let firestore = FirestoreManager()
    
    func loadFailures() {
        firestore.fetchFailures { [weak self] failures in
            DispatchQueue.main.async {
                self?.failures = failures
            }
        }
    }

}
