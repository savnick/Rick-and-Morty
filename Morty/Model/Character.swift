//
//  Character.swift
//  RickAndMorty
//
//  Created by Nick on 19.02.2022.
//

import SwiftUI

// MARK: - HOME
struct HomeCharacters: Decodable {
    let info: Info
    let results: [Character]
}


// MARK: - CHARACTER
public class Character: Decodable, Identifiable, ObservableObject {
    
    @Published var loadedEpisodes: [Episode] = []
    @Published var loadedLocations: [Location] = []
    
    public var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var location: CharLocation
    var origin: CharLocation
    var image: String
    var episode: [String]
    var url: String
    var created: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, status, species, type, gender, origin, location, image, episode, url, created
    }
    
    init(id: Int, name: String, status: String, species: String, type: String, gender: String, origin: CharLocation, location: CharLocation, image: String, episode: [String], url: String, created: String) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
        self.url = url
        self.created = created
    }
        
    func loadEpisodes() {
        let remoteEpisode = Remote<Episode>()
        episode.forEach { episodeUrl in
            remoteEpisode.performAPIRequestByURL(url: episodeUrl) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let episode):
                        self.loadedEpisodes.append(episode)
                    case .failure(let error):
                        switch error {
                        case .invalidResponse:
                            print("invalidResponse")
                        case .invalidURL:
                            print("invalidURL - load episodes")
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
    
    func loadLocations() {
        let remoteLocation = Remote<Location>()
        let locations = [location.url, origin.url]
        locations.forEach { locationUrl in
            remoteLocation.performAPIRequestByURL(url: locationUrl) { result in
                DispatchQueue.main.async { [self] in
                    switch result {
                    case .success(let location):
                        self.loadedLocations.append(location)
                        if location.url == origin.url {
                            self.loadedLocations.append(location)
                        }
                    case .failure(let error):
                        switch error {
                        case .invalidResponse:
                            print("invalidResponse")
                        case .invalidURL:
                            self.loadedLocations.append(Location(id: 0, name: "unknown", type: "unknown", dimension: "unknown", residents: [], url: "", created: ""))
                            print("invalidURL - load locations")
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

// MARK: - Location
public class CharLocation: Decodable {
    public var name: String = ""
    public var url: String = ""
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}

public enum Gender: String {
    case female = "female"
    case male = "male"
    case genderless = "genderless"
    case unknown = "unknown"
    case none = ""
}

public enum Species: String {
    case Alien
    case Human
    case Humanoid
    case Poopybutthole
    case Mythological = "Mythological Creature"
    case Robot
    case Animal
    case Cronenberg
    case unknown
}

public enum Status: String {
    case alive = "alive"
    case dead = "dead"
    case unknown = "unknown"
    case none = ""
}

