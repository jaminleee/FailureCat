//
//  FailureRowView.swift
//  FailureCat
//
//  Created by jamin on 4/11/25.
//

import SwiftUI

struct FailureRowView: View {
    let failure: Failure
    var body: some View {
        
        HStack() {
            VStack(alignment: .leading, spacing: 2) {
                Text(failure.content)
                    .lineLimit(1)
                
                Text(dateString(from: failure.date))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            Text(failure.category)
                .font(.caption2)
                .padding(.vertical, 5)
                .padding(.horizontal, 8)
                .background(failure.categoryEnum.color)
                .clipShape(Capsule())
        }
    }
    
    private func dateString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy/MM/dd"
        return formatter.string(from: date)
    }
}

#Preview {
    FailureRowView(failure: Failure(content: "dd", date: .now, category: "챌린지"))
}
