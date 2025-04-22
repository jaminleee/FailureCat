//
//  MainViewModel.swift
//  FailureCat
//
//  Created by jamin on 4/17/25.
//

import Foundation
import FirebaseFirestore

@MainActor
class MainViewModel: ObservableObject {
    @Published var failures: [Failure] = []
    
    private let firestore = FirestoreManager()
    private var listener: ListenerRegistration?
    
    func loadFailures() {
        firestore.fetchFailures { [weak self] failures in
            DispatchQueue.main.async {
                self?.failures = failures
            }
        }
    }
    
    func listenToFailures() {
        listener = firestore.listenToFailures { [weak self] failures in
            self?.failures = failures
        }
    }

    func stopListening() {
        listener?.remove()
    }
}
