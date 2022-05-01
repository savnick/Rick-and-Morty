//
//  EpisodeListCell.swift
//  RickAndMorty
//
//  Created by Nick on 24.02.2022.
//

import SwiftUI

struct EpisodesListRowView: View {
    // MARK: - PROPERTIES
    let episode: Episode
    
    // MARK: - BODY
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(episode.name)
                    .foregroundColor(.accentColor)
                Text(episode.episode)
                    .font(.footnote)
            }
            Spacer()
            Text(episode.airDate)
                .foregroundColor(.gray)
                .font(.footnote)
        }
    }
}

struct EpisodeListRowView_Previews: PreviewProvider {
    static var previews: some View {
        let episode = Episode(id: 1, name: "Pilot", airDate: "December 2, 2013", episode: "S01E01", characters: ["https://rickandmortyapi.com/api/character/1"], url: "https://rickandmortyapi.com/api/episode/1", created: "2017-11-10T12:56:33.798Z")
        EpisodesListRowView(episode: episode)
    }
}
