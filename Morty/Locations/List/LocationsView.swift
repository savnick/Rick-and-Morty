//
//  LocationView.swift
//  RickAndMorty
//
//  Created by Nick on 18.02.2022.
//

import SwiftUI

struct LocationsView: View {
    // MARK: - PROPERTIES
    @StateObject var data: LocationsViewModel = LocationsViewModel()
    
    // MARK: - BODY
    var body: some View {
        if !data.locations.isEmpty {
            NavigationView {
                List {
                    ForEach(data.locations) { location in
                        NavigationLink {
                            LocationDetailView(location: location)
                        } label: {
                            LocationsListRowView(location: location)
                        }
                    }
                    if data.shouldDisplayNextPage {
                        nextPageView
                    }
                }
                .navigationTitle("Locations")
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
struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
    }
}
