//
//  CharactersView.swift
//  RickAndMorty
//
//  Created by Nick on 18.02.2022.
//

import SwiftUI

struct CharactersView: View {
    // MARK: - PROPERTIES
    @StateObject var data: CharactersViewModel = CharactersViewModel()
    
    // MARK: - BODY
    var body: some View {
        if !data.characters.isEmpty {
            NavigationView {
                List {
                    ForEach(data.characters) { character in
                        NavigationLink {
                            CharacterDetailView(character: character)
                        } label: {
                            CharactersListRowView(character: character)
                        }//: LINK
                    }//: FOREACH
                    if data.shouldDisplayNextPage {
                        nextPageView
                    }
                }//: LIST
                .navigationTitle("Characters")
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

// MARK: - PREVIEW
struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
    }
}
