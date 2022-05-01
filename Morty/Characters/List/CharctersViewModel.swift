//
//  CharcterViewModel.swift
//  RickAndMorty
//
//  Created by Nick on 19.02.2022.
//


import SwiftUI

final class CharactersViewModel: ObservableObject {
    @Published var characters: [Character] = []
    private let remoteCharaters = Remote<HomeCharacters>()
    
    var totalPages = 0
    var page = 1 {
        didSet {
            loadNextPage()
        }
    }
    
    init() {
        loadNextPage()
    }
    
    public var shouldDisplayNextPage: Bool {
        if page < totalPages {
            return true
        }
        return false
    }
    
    func loadNextPage() {
        let url = "https://rickandmortyapi.com/api/character?page=\(page)"
        remoteCharaters.performAPIRequestByURL(url: url) { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let homeCharacters):
                    self.characters.append(contentsOf: homeCharacters.results)
                    self.totalPages = homeCharacters.info.pages
                case .failure(let error):
                    switch error {
                    case .invalidResponse:
                        print("invalidResponse")
                    case .invalidURL:
                        print("invalidURL - load main chatacters")
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
