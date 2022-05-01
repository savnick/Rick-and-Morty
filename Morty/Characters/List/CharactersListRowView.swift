//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Nick on 20.02.2022.
//

import SwiftUI

struct CharactersListRowView: View {
    // MARK: - PROPERTIES
    let character: Character
    
    // MARK: - BODY
    var body: some View {
        HStack {
            AsyncImage(
               url: URL(string: character.image)!,
               placeholder: { ProgressView() },
               image: { Image(uiImage: $0).resizable() }
            )
            .scaledToFit()
            .clipShape(Circle())
            .frame(width: 50, height: 50, alignment: .center)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(character.name)
                    .font(.title3)
                    .foregroundColor(.accentColor)
                Text(character.episode.count == 1 ? "1 episode" : "\(character.episode.count) episodes")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
    }
}

// MARK: - PREVIEW
struct CharactersListRowView_Previews: PreviewProvider {
    static var previews: some View {
        
        let character = Character(id: 1,
        name: "Rick Sanchez",
        status: "Alive",
        species: "Human",
        type: "",
        gender: "Male",
        origin: CharLocation(name: "Earth (Replacement Earth)",
                         url: "https://rickandmortyapi.com/api/location/1"
                       ),
        location: CharLocation(name: "Earth (Replacement Earth)",
                           url: "https://rickandmortyapi.com/api/location/1"
                         ),
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        episode: [
            "https://rickandmortyapi.com/api/episode/1",
            "https://rickandmortyapi.com/api/episode/2",
            "https://rickandmortyapi.com/api/episode/3",
            "https://rickandmortyapi.com/api/episode/4",
            "https://rickandmortyapi.com/api/episode/5"],
        url: "https://rickandmortyapi.com/api/character/1",
                                  created: "2017-11-04T18:48:46.250Z")
        
        CharactersListRowView(character: character)
    }
}
