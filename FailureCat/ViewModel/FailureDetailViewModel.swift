//
//  FailureDetailViewModel.swift
//  FailureCat
//
//  Created by jamin on 4/22/25.
//

import Foundation

@MainActor
class FailureDetailViewModel: ObservableObject {
    @Published var failure: Failure?
    
    func loadFailure(by id: String) {
        FirestoreManager.shared.fetchFailure(id: id) { [weak self] result in
            switch result {
            case .success(let fetchedFailure):
                self?.failure = fetchedFailure
            case .failure(let error):
                print("실패 항목 로딩 실패: \(error.localizedDescription)")
            }
        }
    }
}
