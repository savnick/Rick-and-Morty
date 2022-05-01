//
//  EpisodeDetailView.swift
//  RickAndMorty
//
//  Created by Nick on 25.04.2022.
//

import SwiftUI

struct EpisodeDetailView: View {
    // MARK: - PROPERTIES
    @ObservedObject var episode: Episode
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - BODY
    var body: some View {
        List {
            Section {
                InfoRowView(label: "Name",
                            icon: "info",
                            value: episode.name)
                InfoRowView(label: "Air date",
                            icon: "calendar",
                            value: episode.airDate)
                InfoRowView(label: "Code",
                            icon: "barcode",
                            value: episode.episode)
            } header: {
                Text("Info")
            }
            
            if !episode.loadedCharacters.isEmpty {
                Section {
                    ForEach(episode.loadedCharacters) { character in
                        NavigationLink(
                            destination: CharacterDetailView(character: character),
                            label: {
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
                            })
                    }
                } header: {
                    Text("Characters")
                }
            } else {
                ProgressView()
                    .onAppear {
                        episode.loadCharacters()
                    }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle(episode.name)
    }
}

// MARK: - PREVIEW
struct EpisodeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let episode = Episode(id: 28, name: "The Ricklantis Mixup", airDate: "September 10, 2017", episode: "S03E07", characters: [
            "https://rickandmortyapi.com/api/character/1",
            "https://rickandmortyapi.com/api/character/2"], url: "https://rickandmortyapi.com/api/location/3", created: "2017-11-10T13:08:13.191Z")
        EpisodeDetailView(episode: episode)
    }
}
