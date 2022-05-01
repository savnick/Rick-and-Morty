//
//  Episode.swift
//  RickAndMorty
//
//  Created by Nick on 24.02.2022.
//

import SwiftUI

// MARK: - HOME
struct HomeEpisodes: Decodable {
    let info: Info
    let results: [Episode]
}

// MARK: - EPISODE
class Episode: Decodable, Identifiable, ObservableObject  {
    
    @Published var loadedCharacters: [Character] = []
    
    public var id: Int
    var name: String
    var airDate: String
    var episode: String
    var characters: [String]
    var url: String
    var created: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, episode, characters, url, created
        case airDate = "air_date"
    }
        
    init(id: Int, name: String, airDate: String, episode: String, characters: [String], url: String, created: String) {
        self.id = id
        self.name = name
        self.airDate = airDate
        self.episode = episode
        self.characters = characters
        self.url = url
        self.created = created
    }
    
    func loadCharacters() {
        let remoteCharacter = Remote<Character>()
        characters.forEach { characterUrl in
            remoteCharacter.performAPIRequestByURL(url: characterUrl) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let character):
                        self.loadedCharacters.append(character)
                    case .failure(let error):
                        switch error {
                        case .invalidResponse:
                            print("invalidResponse")
                        case .invalidURL:
                            print("invalidURL - characters")
                        case .invalidData:
                            print("invalidData")
                        case .apiError:
                            print("apiError")
                        case .decodingError:
                            print("decodingError")
                        }
                    }
                }
            }
        }
    }
}

