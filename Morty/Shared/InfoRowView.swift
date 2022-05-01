//
//  InfoRowView.swift
//  RickAndMorty
//
//  Created by Nick on 26.04.2022.
//

import SwiftUI

struct InfoRowView: View {
    // MARK: - PROPERTIES
    let label: String
    let icon: String
    let value: String
    
    // MARK: - BODY
    var body: some View {
        HStack {
            Label(label, systemImage: icon)
            Spacer()
            Text(value)
                .foregroundColor(.accentColor)
                .fontWeight(.semibold)
        }
    }
}

// MARK: - PREVIEW
struct InfoRowView_Previews: PreviewProvider {
    static var previews: some View {
        InfoRowView(label: "Species", icon: "hare", value: "Human")
    }
}
