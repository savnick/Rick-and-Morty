//
//  LocationDetaiView.swift
//  RickAndMorty
//
//  Created by Nick on 25.04.2022.
//

import SwiftUI

struct LocationDetailView: View {
    // MARK: - PROPERTIES
    @ObservedObject var location: Location
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - BODY
    var body: some View {
        List {
            Section {
                InfoRowView(label: "Name",
                            icon: "info",
                            value: location.name)
                InfoRowView(label: "Dimension",
                            icon: "tornado",
                            value: location.dimension)
                InfoRowView(label: "Type",
                            icon: "newspaper",
                            value: location.type)
            } header: {
                Text("Info")
            }
            
            if !location.loadedResidents.isEmpty {
                Section {
                    ForEach(location.loadedResidents) { character in
                        NavigationLink {
                            CharacterDetailView(character: character)
                        } label: {
                            HStack {
                                AsyncImage(
                                   url: URL(string: character.image)!,
                                   placeholder: { ProgressView() },
                                   image: { Image(uiImage: $0).resizable() }
                                )
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: 30, height: 30, alignment: .center)
                                Text(character.name)
                            }
                        }

                    }
                } header: {
                    Text("Residents")
                }
            } else {
                ProgressView()
                    .onAppear {
                        location.loadResidents()
                    }
            }
            
        }
        .listStyle(GroupedListStyle())
        .navigationTitle(location.name)
    }
}

// MARK: - PREVIEW
struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let location = Location(id: 3, name: "Citadel of Ricks", type: "Space station", dimension: "unknown", residents: [
            "https://rickandmortyapi.com/api/character/8",
            "https://rickandmortyapi.com/api/character/14"], url: "https://rickandmortyapi.com/api/location/3", created: "2017-11-10T13:08:13.191Z")
        
        LocationDetailView(location: location)
    }
}
