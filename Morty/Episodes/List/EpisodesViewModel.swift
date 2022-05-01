//
//  EpisodeViewModel.swift
//  RickAndMorty
//
//  Created by Nick on 24.02.2022.
//

import SwiftUI
final class EpisodesViewModel: ObservableObject {
    @Published var episodes: [Episode] = []
    private let remoteEpisodes = Remote<HomeEpisodes>()

    var totalPages = 0
    var page = 1 {
        didSet {
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
        let url = "https://rickandmortyapi.com/api/episode?page=\(page)"
        remoteEpisodes.performAPIRequestByURL(url: url) { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let homeEpisodes):
                    self.episodes.append(contentsOf: homeEpisodes.results)
                    self.totalPages = homeEpisodes.info.pages
                case .failure(let error):
                    switch error {
                    case .invalidResponse:
                        print("invalidResponse")
                    case .invalidURL:
                        print("invalidURL - main episodes")
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
