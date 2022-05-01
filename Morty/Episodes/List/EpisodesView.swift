//
//  EpisodeView.swift
//  RickAndMorty
//
//  Created by Nick on 18.02.2022.
//

import SwiftUI

struct EpisodesView: View {
    // MARK: - PROPERTIES
    @StateObject var data: EpisodesViewModel = EpisodesViewModel()
    
    // MARK: - BODY
    var body: some View {
        if !data.episodes.isEmpty {
            NavigationView {
                List {
                    ForEach(data.episodes) { episode in
                        NavigationLink {
                            EpisodeDetailView(episode: episode)
                        } label: {
                            EpisodesListRowView(episode: episode)
                        }
                    }
                    if data.shouldDisplayNextPage {
                        nextPageView
                    }
                }
                .navigationTitle("Episodes")
            }
        } else {
            ProgressView()
        }
    }
    private var nextPageView: some View {
        HStack {
            Spacer()
            VStack {
                ProgressView()
                Text("Loading...")
            }
            Spacer()
        }
        .onAppear(perform: {
            data.page += 1
        })
    }
}

struct EpisodeView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesView()
    }
}
