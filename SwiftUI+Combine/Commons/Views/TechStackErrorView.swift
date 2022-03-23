//
//  TechStackErrorView.swift
//  SwiftUI+Combine
//
//  Created by Manish Patidar on 22/03/22.
//

import SwiftUI

struct TechStackErrorView: View {
    
    let errorMessage: String
    
    var body: some View {
        VStack {
            Text("😿")
                .font(.system(size: 100))
            Text(errorMessage)
        }
    }
}

struct TechStackErrorView_Previews: PreviewProvider {
    static var previews: some View {
        TechStackErrorView(errorMessage: "Someting Went Wrong!")
    }
}
