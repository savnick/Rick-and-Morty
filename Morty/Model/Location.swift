//
//  Location.swift
//  RickAndMorty
//
//  Created by Nick on 23.02.2022.
//

import SwiftUI

// MARK: - HOME
struct HomeLocations: Decodable {
    let info: Info
    let results: [Location]
}

// MARK: - LOCATION
class Location: Decodable, Identifiable, ObservableObject  {
    
    @Published var loadedResidents: [Character] = []
    
    public var id: Int
    var name: String
    var type: String
    var dimension: String
    var residents: [String]
    var url: String
    var created: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, type, dimension, residents, url, created
    }
        
    init(id: Int, name: String, type: String, dimension: String, residents: [String], url: String, created: String) {
        self.id = id
        self.name = name
        self.type = type
        self.dimension = dimension
        self.residents = residents
        self.url = url
        self.created = created
    }
    
    func loadResidents() {
        let remoteResident = Remote<Character>()
        residents.forEach { residentUrl in
            remoteResident.performAPIRequestByURL(url: residentUrl) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let resident):
                        self.loadedResidents.append(resident)
                    case .failure(let error):
                        switch error {
                        case .invalidResponse:
                            print("invalidResponse")
                        case .invalidURL:
                            print("invalidURL - load residents")
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
