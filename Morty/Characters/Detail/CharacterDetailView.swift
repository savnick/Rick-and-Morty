//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Nick on 25.02.2022.
//

import SwiftUI

struct CharacterDetailView: View {
    // MARK: - PROPERTIES
    @ObservedObject var character: Character
    
    // MARK: - BODY
    var body: some View {
        
        List {
            Section {
                HStack {
                    Spacer()
                    if let image = character.image,
                       let url = URL(string: image) {
                        AsyncImage(
                            url: url,
                            placeholder: { ProgressView() },
                            image: { Image(uiImage: $0).resizable() }
                        )
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .cornerRadius(25)
                    } else {
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 150, height: 150)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
            } header: {
                Text("Screenshot")
            }
            
            Section {
                InfoRowView(label: "Species",
                            icon: "hare",
                            value: character.species)
                InfoRowView(label: "Gender",
                            icon: "eyes",
                            value: character.gender)
                InfoRowView(label: "Status",
                            icon: "waveform.path.ecg.rectangle",
                            value: character.status)
            } header: {
                Text("Info")
            }
            
            if !character.loadedLocations.isEmpty && character.loadedLocations.count > 1  {
                Section {
                    if character.location.url.isEmpty {
                        InfoRowView(label: "Location",
                                    icon: "map",
                                    value: character.location.name)
                    } else {
                        NavigationLink(
                            destination:
                                LocationDetailView(location: character.loadedLocations[0]),
                            label: {
                                InfoRowView(label: "Location",
                                            icon: "map",
                                            value: character.location.name)
                            })
                    }
                    if character.origin.url.isEmpty {
                        InfoRowView(label: "Origin",
                                    icon: "paperplane",
                                    value: character.origin.name)
                    } else {
                        NavigationLink(
                            destination:
                                LocationDetailView(location: character.loadedLocations[1]),
                            label: {
                                InfoRowView(label: "Origin",
                                            icon: "paperplane",
                                            value: character.origin.name)
                            })
                    }
                } header: {
                    Text("Location")
                }
            } else {
                ProgressView()
                    .onAppear {
                        character.loadLocations()
                    }
            }
            
            if !character.loadedEpisodes.isEmpty {
                Section {
                    ForEach(character.loadedEpisodes) { episode in
                        NavigationLink(
                            destination: EpisodeDetailView(episode: episode),
                            label: {
                                HStack {
                                    Text(episode.name)
                                    Spacer()
                                    Text(episode.airDate)
                                        .foregroundColor(.gray)
                                        .font(.footnote)
                                }
                            })
                    }
                } header: {
                    Text("Episodes")
                }
            } else {
                ProgressView()
                    .onAppear {
                        character.loadEpisodes()
                    }
            }
                
        }
        .listStyle(GroupedListStyle())
        .navigationTitle(character.name)
    }//: BODY
}

// MARK: - PREVIEW
struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let character = Character(id: 1,name: "Rick Sanchez", status: "Alive", species: "Human", type: "", gender: "Male", origin: CharLocation(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1"), location: CharLocation(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/1"), image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", episode: ["https://rickandmortyapi.com/api/episode/1", "https://rickandmortyapi.com/api/episode/2"], url: "https://rickandmortyapi.com/api/character/1", created: "2017-11-04T18:48:46.250Z")
        
        CharacterDetailView(character: character)
            .previewDevice("iPhone 12")
        
    }
}


