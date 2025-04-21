//
//  ConfirmButton.swift
//  FailureCat
//
//  Created by jamin on 4/14/25.
//

import SwiftUI

enum CustomButtonType {
    case iconWithTitle(title: String, systemImage: String)
    case titleOnly(title: String)
}

struct ConfirmButton: View {
    let type: CustomButtonType
    
    var body: some View {
        Button(action: {} ) {
            switch type {
            case .iconWithTitle(let title, let systemImage):
                Label(title, systemImage: systemImage)
            case .titleOnly(let title):
                Text(title)
                    
            }
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .frame(height: 62)
        .background(.green)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        
        
    
    }
}

#Preview {
    ConfirmButton(type: CustomButtonType.titleOnly(title: "gg"))
}
