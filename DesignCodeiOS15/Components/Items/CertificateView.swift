//
//  CertificateView.swift
//  DesignCodeiOS15
//
//  Created by Rahmonali on 05/11/23.
//

import SwiftUI

struct CertificateView: View {
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 8) {
                Text("SwiftUI for iOS 15")
                    .font(.title3.weight(.semibold))
                Text("Certificate")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Feb 25, 2022".uppercased())
                    .font(.footnote.weight(.semibold))
                
                Text("Design Code Instructor: Meng To")
                    .font(.footnote.weight(.medium))
            }
            .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay (
            Image("Logo 2")
                .resizable()
                .scaledToFit()
                .frame(width: 26, height: 26)
                .clipShape(.rect(cornerRadius: 10))
                .padding(9)
                .background(Color(UIColor.systemBackground).opacity(0.1), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                .strokeStyle(cornerRadius: 16)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        )
        .padding(20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle(cornerRadius: 30)
        
    }
}

#Preview {
    CertificateView()
}
