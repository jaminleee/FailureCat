//
//  FailureDetailView.swift
//  FailureCat
//
//  Created by jamin on 4/10/25.
//

import SwiftUI
import FirebaseFirestore

struct FailureDetailView: View {
    //    var failure: Failure
    
    @Environment(\.dismiss) private var dismiss
    //    @State private var text = ""
    @State private var showingOptions = false
    //    @State private var showingEditView = false
    @EnvironmentObject var coordinator: AppCoordinator
    @StateObject private var viewModel = FailureDetailViewModel()
    let failureID: String
    
    
    var body: some View {
        Group{
            if let failure = viewModel.failure {
                VStack(alignment: .leading, spacing: 0) {
                    HStack (alignment: .bottom) {
                        Image(failure.categoryEnum.imageName(isSelected: true))
                            .resizable()
                            .frame(width: 50, height: 50)
                        
                        Text(dateString(from: failure.date))
                            .font(.callout)
                        
                        Text(failure.category)
                            .font(.caption2)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 8)
                            .background(failure.categoryEnum.color)
                            .clipShape(Capsule())
                    }
                    
                    Text(failure.content)
                        .padding(.top, 20)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            showingOptions = true
                        }) {
                            Image(systemName: "ellipsis")
                        }
                    }
                }
                .confirmationDialog("옵션", isPresented: $showingOptions) {
                    Button("수정하기") {
                        coordinator.goToCreate(failure: failure)
                    }
                    Button("삭제하기", role: .destructive) {
                        FirestoreManager.shared.deleteFailure(failure) { result in
                            switch result {
                            case .success:
                                coordinator.goBack()
                                print("삭제 성공")
                            case .failure(let error):
                                print("삭제 실패: \(error.localizedDescription)")
                            }
                        }
                    }
                    Button("취소", role: .cancel) {
                        
                    }
                }
            } else {
                ProgressView("불러오는 중...")
            }
        }
        .onAppear {
            viewModel.loadFailure(by: failureID)
        }
    }
    
    private func dateString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy/MM/dd"
        return formatter.string(from: date)
    }
}


