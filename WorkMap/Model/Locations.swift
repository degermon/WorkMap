//
//  Locations.swift
//  WorkMap
//
//  Created by Daniel Šuškevič on 2021-10-13.
//

import Foundation

struct Location: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let latitude: Double
    let longitude: Double
}
