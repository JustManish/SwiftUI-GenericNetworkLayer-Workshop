//
//  TechStackLoadingView.swift
//  SwiftUI+Combine
//
//  Created by Manish Patidar on 22/03/22.
//

import SwiftUI

struct TechStackLoadingView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("😸")
                .font(.system(size: 100))
            ProgressView()
                .frame(width: 40, height: 40)
            Text("Getting the cats...")
        }
    }
}

struct TechStackLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        TechStackLoadingView()
    }
}
