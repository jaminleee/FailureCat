//
//  FirestoreManager.swift
//  FailureCat
//
//  Created by jamin on 4/18/25.
//

import FirebaseCore
import FirebaseFirestore
import FirebaseFirestore

final class FirestoreManager {
    private let db = Firestore.firestore()
    static let shared = FirestoreManager()
    init() {}
    
    func fetchFailures(completion: @escaping ([Failure]) -> Void) {
        db.collection("failures")
            .order(by: "date", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("에러: \(error.localizedDescription)")
                    completion([])
                    return
                }
                
                let failures: [Failure] = snapshot?.documents.compactMap { doc in
                    try? doc.data(as: Failure.self)
                } ?? []
                
                completion(failures)
            }
    }
    
    func deleteFailure(_ failure: Failure, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let id = failure.id else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
            return
        }
        
        db.collection("failures").document(id).delete { error in
            if let error = error {
                completion(.failure(error))
                return
            }
        }
    }
    
    func updateFailure(_ failure: Failure, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let id = failure.id else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
            return
        }
        
        do {
            try db.collection("failures").document(id).setData(from: failure) {error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(()))
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func addFailure(_ failure: Failure, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            _ = try db.collection("failures").addDocument(from: failure) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }

}
