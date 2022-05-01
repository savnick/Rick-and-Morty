//
//  LocationViewModel.swift
//  RickAndMorty
//
//  Created by Nick on 23.02.2022.
//


import SwiftUI

final class LocationsViewModel: ObservableObject {
    @Published var locations: [Location] = []
    private let remote = Remote<HomeLocations>()
    
    var totalPages = 0
    var page = 1 {
        didSet{
            loadNextPage()
        }
    }
    
    public var shouldDisplayNextPage: Bool {
        if page < totalPages {
            return true
        }
        return false
    }
    
    init () {
        loadNextPage()
    }
    
    func loadNextPage() {
        let url = "https://rickandmortyapi.com/api/location?page=\(page)"
        remote.performAPIRequestByURL(url: url) { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let homeLocations):
                    self.locations.append(contentsOf: homeLocations.results)
                    self.totalPages = homeLocations.info.pages

                case .failure(let error):
                    switch error {
                    case .invalidResponse:
                        print("invalidResponse")
                    case .invalidURL:
                        print("invalidURL - main locations")
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
