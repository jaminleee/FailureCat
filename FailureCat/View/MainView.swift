//
//  MainView.swift
//  FailureCat
//
//  Created by jamin on 4/10/25.
//

import SwiftUI

struct MainView: View {
//    @State private var isPresented = false
    @State private var selectedFailure: Failure?
    
//    @Query(sort: \Failure.date, order: .reverse) private var failures: [Failure]
    @EnvironmentObject var coordinator: AppCoordinator
    @StateObject private var viewModel = MainViewModel()

    var body: some View {
        
        NavigationStack(path: $coordinator.path) {
            VStack(spacing: 0) {
                
                Image(.threadBlack)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180)
                    .ignoresSafeArea(.all)

                Group {
                    VStack(spacing: 0) {
                        Image(.catBlack)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Button(action: {
                            coordinator.goToCreate()
                        }) {
                            Label("실패 추가하기", systemImage: "")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(.black.opacity(0.8))
                                .tint(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
  
                        Button {
                            coordinator.goToList()
                        } label: {
                            HStack {
                                Text("실패 리스트")
                                    .font(.title2)
                                Image(systemName: "chevron.right")
                                Spacer()
                            }
                        }
                        .tint(.black)
                        
                        Text("최근 실패 3가지다냥! 다시 보니 별거 아니지않냐옹?")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .tint(.black)
                    .padding(.top, 30)
                    .frame(maxWidth: .infinity)
                    
                    
                    VStack(spacing: 20) {
                        ForEach(viewModel.failures.prefix(3)) { failure in
                            FailureRowView(failure: failure)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    coordinator.goToDetail(failure: failure)
                                }
                        }
                    }
                    .padding(.top, 24)
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                ZStack(alignment: .top) {
                    Image(.grass)
                        .resizable()
                        .ignoresSafeArea(.all)
//                        .frame(height: 130)
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                    
                    HStack(alignment: .bottom) {
                        ForEach(FailureCategory.allCases, id: \.self) { category in
                            let isMost = viewModel.mostCategories.contains(category)
                            let imageName = isMost ? category.standingImage : category.sleepingImage
                            let size: CGFloat = isMost ? 90 : 70

                            VStack {
                                Image(imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: size, height: size)
                                    
                                Text("\(category.rawValue)냥")
                                    .font(.caption)
                                    .foregroundStyle(.black.opacity(0.6))
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 8)
                                    .background(category.color)
                                    .clipShape(Capsule())
                            }
                            .onTapGesture {
                                SoundManager.shared.playSound(named: category.soundFileName)
                                if let filter = FailureCategoryFilter.allCases.first(where: { $0.category == category }) {
                                    coordinator.goToList(category: filter)
                                }
                            }
                        }
                    }
                    .padding(.top, 30)
                }
                .ignoresSafeArea(.all)
            }

            .navigationDestination(for: Route.self) { route in
                switch route {
                case .create(let failure):
                    CreateFailureView(failure: failure)
                case .detail(let id):
                    FailureDetailView(failureID: id)
                case .list(let category):
                    FailureListView(category: category)
                }
            }
        }
        .tint(.black)
        
//        .task {
//            viewModel.listenToFailures()
//        }
        .onAppear() {
            viewModel.loadFailures()
        }
        .onChange(of: coordinator.path) {
            viewModel.loadFailures()
        }
//        .onDisappear {
//            viewModel.stopListening()
//        }
        
    }
    
}

#Preview {
    MainView()
}
