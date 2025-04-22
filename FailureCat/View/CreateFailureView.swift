//
//  CreateFailureView.swift
//  FailureCat
//
//  Created by jamin on 4/10/25.
//

import SwiftUI
import SwiftData

struct CreateFailureView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var coordinator: AppCoordinator
    @State private var text: String = ""
    @State private var selectedCategory: FailureCategory = .challenge
    
    let existingFailure: Failure?
    
    init(failure: Failure? = nil) {
        self.existingFailure = failure
        _text = State(initialValue: failure?.content ?? "")
        _selectedCategory = State(initialValue: failure?.categoryEnum ?? .challenge)
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("오늘의 실패는 무엇이냐옹?")
                .font(.title2)
            
            HStack (spacing: 12) {
                ForEach(FailureCategory.allCases, id: \.self) { category in
                    VStack(spacing: 0) {
                        Image(category.imageName(isSelected: selectedCategory == category ))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                            
                        Text(category.rawValue)
                            .foregroundStyle(.black.opacity(0.6))
                    }
                    .onTapGesture {
                        selectedCategory = category
                    }
                }
            }
            
            
            TextEditor(text: $text)
                .frame(minHeight: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
                )
        }
        .padding(.horizontal, 20)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if !text.isEmpty {
                    Button("완료") {
                        if let failure = existingFailure {
                            let updated = Failure(id: failure.id, content: text, date: Date(), category: selectedCategory.rawValue)
                            
                            FirestoreManager.shared.updateFailure(updated) { result in
                                switch result {
                                case .success:
                                    coordinator.goBack()
                                case .failure(let error):
                                    print("업데이트 실패: \(error.localizedDescription)")
                                }
                            }
                        } else {
                            let newFailure = Failure(content: text, date: Date(), category: selectedCategory.rawValue)
                            
                            FirestoreManager.shared.addFailure(newFailure) { result in
                                switch result {
                                case .success:
                                    coordinator.goBack()
                                case .failure(let error):
                                    print("저장 실패: \(error.localizedDescription)")
                                }
                            }
                        }
                    }
                } else {
                    Button("완료") {}
                        .disabled(true)
                }
            }
        }
    }
}


#Preview {
    CreateFailureView()
}
