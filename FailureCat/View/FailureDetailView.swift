//
//  FailureDetailView.swift
//  FailureCat
//
//  Created by jamin on 4/10/25.
//

import SwiftUI
import FirebaseFirestore

struct FailureDetailView: View {
//    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
//    @State private var text = ""
    @State private var showingOptions = false
    @State private var showingEditView = false
    let failure: Failure
    
    var body: some View {
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
                showingEditView = true
            }
            Button("삭제하기", role: .destructive) {
                FirestoreManager.shared.deleteFailure(failure) { result in
                    switch result {
                    case .success:
                        dismiss()
                    case .failure(let error):
                        print("삭제 실패: \(error.localizedDescription)")
                    }
                }
            }
            Button("취소", role: .cancel) {
                
            }
        }
        .navigationDestination(isPresented: $showingEditView) {
            CreateFailureView(failure: failure)
        }
    }
    
    private func dateString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy/MM/dd"
        return formatter.string(from: date)
    }
}

#Preview {
    FailureDetailView(failure: Failure(content: "dd", date: .now, category: "etc"))
}
