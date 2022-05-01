//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Nick on 18.02.2022.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
            CharactersView()
                .tabItem {
                    Label("Characters", systemImage: "person.text.rectangle")
                }
            LocationsView()
                .tabItem {
                    Label("Locations", systemImage: "map")
                }
            EpisodesView()
                .tabItem {
                    Label("Episodes", systemImage: "tv")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
