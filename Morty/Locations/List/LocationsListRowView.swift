//
//  LocationListCell.swift
//  RickAndMorty
//
//  Created by Nick on 23.02.2022.
//

import SwiftUI

struct LocationsListRowView: View {
    // MARK: - PROPERTIES
    let location: Location
    
    // MARK: - BODY
    var body: some View {
        HStack(alignment: .center) {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text(location.name)
                        .foregroundColor(.accentColor)
                    Text(location.residents.isEmpty ? "0 residents" : (location.residents.count == 1 ? "1 resdent": "\(location.residents.count) residents"))
                        .font(.footnote)
                }
                Spacer()
                Text(location.dimension)
                    .foregroundColor(.gray)
                    .font(.footnote)
            }
        }
    }
}

// MARK: - PREVIEW
struct LocationsListRowView_Previews: PreviewProvider {
    static var previews: some View {
        let location = Location(id: 1, name: "Earth (C-137)", type: "Planet", dimension: "Dimension C-137", residents: ["1", "2"], url: "https://rickandmortyapi.com/api/location/1", created: "2017-11-10T12:42:04.162Z")
        
        LocationsListRowView(location: location)
    }
}
