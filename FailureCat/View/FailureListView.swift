//
//  FailureListView.swift
//  FailureCat
//
//  Created by jamin on 4/10/25.
//

import SwiftUI
import SwiftData
import FirebaseFirestore

enum FailureCategoryFilter: String, CaseIterable, Identifiable {
    case all = "전체"
    case challenge = "챌린지"
    case habit = "습관"
    case etc = "기타"
    
    var id: String {
        self.rawValue
    }
    
    var category: FailureCategory? {
        switch self {
        case .all: return nil
        case .challenge: return .challenge
        case .habit: return .habit
        case .etc: return .etc
        }
    }
}

struct FailureListView: View {
    let initialCategory: FailureCategoryFilter?
    @EnvironmentObject var coordinator: AppCoordinator
//    @State private var failures: [Failure] = []
    @State private var selectedCategory: FailureCategoryFilter
//    @State private var selectedFailure: Failure?
    @StateObject private var viewModel = FailureListViewModel()

    init(category: FailureCategoryFilter? = nil) {
        self.initialCategory = category
        _selectedCategory = State(initialValue: category ?? .all)
    }
    
    private var filteredFailures: [Failure] {
        if let category = selectedCategory.category {
            return viewModel.failures.filter { $0.category == category.rawValue }
        } else {
            return viewModel.failures
        }
    }
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(FailureCategoryFilter.allCases, id: \.self) { category in
                        Button(action: {
                            selectedCategory = category
                        }) {
                            Text(category.rawValue)
                                .font(.callout)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 8)
                                .background(selectedCategory == category ? .black : .white)
                                .foregroundStyle(selectedCategory == category ? .white : .gray)
                                .fontWeight(selectedCategory == category ? .bold : .regular)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(.gray, lineWidth: 1))
                                
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
            }
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(filteredFailures) { failure in
                        FailureRowView(failure: failure)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                coordinator.goToDetail(failure: failure)
                            }
                    }
                }
            }
            .padding(.top, 15)
            .padding(.horizontal, 20)
        }
        .onAppear {
            viewModel.loadFailures()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    coordinator.goToCreate()
                }) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    FailureListView()
}
