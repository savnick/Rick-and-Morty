//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Nick on 25.04.2022.
//

import SwiftUI

extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}
