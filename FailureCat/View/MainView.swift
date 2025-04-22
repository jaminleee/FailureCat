//
//  MainView.swift
//  FailureCat
//
//  Created by jamin on 4/10/25.
//

import SwiftUI
import SwiftData

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
                //                    .background(Color.gray)
                Group {
                    VStack(spacing: 0) {
                        Image(.catBlack)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Button(action: {
//                            isPresented = true
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
                        NavigationLink(destination: FailureListView()) {
                            HStack {
                                Text("실패 리스트")
                                    .font(.title2)
                                Image(systemName: "chevron.right")
                                Spacer()
                            }
                        }
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
//                                    selectedFailure = failure
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
                        .frame(height: 180)
                        .frame(maxWidth: .infinity)
                    
                    HStack(alignment: .bottom) {
//                        ForEach(FailureCategory.allCases, id: \.self) { category in
//                            let isMost = viewModel?.mostCategory == category
//                                let imageName = isMost ? category.standingImage : category.sleepingImage
//                                let imageSize: CGFloat = isMost ? 100 : 70
//                            VStack {
//                                Image(imageName)
//                                    .resizable()
//                                    .frame(width: imageSize, height: imageSize)
//                                    .aspectRatio(contentMode: .fit)
//                                
//                                Text("\(category.rawvalue)냥")
//                                    .font(.caption)
//                                    .foregroundStyle(.black.opacity(0.6))
//                            }
//                            
//                        }
                                                VStack {
                                                    Image(.sleeping1)
                                                        .resizable()
                                                        .frame(width: 70, height: 70)
                                                        .aspectRatio(contentMode: .fit)
                        
                                                    Text("챌린지냥")
                                                        .font(.caption)
                                                        .foregroundStyle(.black.opacity(0.6))
                                                }
                                                VStack {
                                                    Image(.standing2)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 100, height: 100)
                        
                        
                                                    Text("습관냥")
                                                        .font(.caption)
                                                        .foregroundStyle(.black.opacity(0.6))
                                                }
                                                VStack {
                                                    Image(.sleeping3)
                                                        .resizable()
                                                        .frame(width: 70, height: 70)
                                                        .aspectRatio(contentMode: .fit)
                        
                                                    Text("기타냥")
                                                        .font(.caption)
                                                        .foregroundStyle(.black.opacity(0.6))
                                                }
                    }
                    .padding(.top, 30)
                }
                .ignoresSafeArea(.all)
            }
//            .navigationDestination(item: $selectedFailure) { failure in
//                FailureDetailView(failure: failure)
//            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .create(let failure):
                    CreateFailureView(failure: failure)
                case .detail(let id):
                    FailureDetailView(failureID: id)
                }
            }
        }
        .tint(.black)
        .task {
            viewModel.listenToFailures()
        }
//        .onAppear() {
//            viewModel.loadFailures()
//        }
        .onDisappear {
            viewModel.stopListening()
        }
    }
}

#Preview {
    MainView()
}
