//
//  WorkMapApp.swift
//  WorkMap
//
//  Created by Daniel Šuškevič on 2021-10-13.
//

import SwiftUI

@main
struct WorkMapApp: App {
    
    @StateObject var contentViewModel = ContentViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(contentViewModel)
        }
    }
}
