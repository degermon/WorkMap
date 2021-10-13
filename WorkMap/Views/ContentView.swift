//
//  ContentView.swift
//  WorkMap
//
//  Created by Daniel Šuškevič on 2021-10-13.
//

import SwiftUI
import MapKit

struct ContentView: View {
    // MARK: - PROPERTIES
    
    @EnvironmentObject var contentViewModel: ContentViewModel
    
    // MARK: - BODY
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(coordinateRegion: $contentViewModel.region, showsUserLocation: true)
                .ignoresSafeArea()
                .accentColor(Color(.systemRed))
                .onAppear {
                    contentViewModel.checkIfLocationServicesIsEnabled()
                }
            
            HStack {
                Spacer()
                Button(action: {
                    contentViewModel.showCurrentLocation()
                }, label: {
                    Image(systemName: "location.fill")
                })
                .frame(width: 60, height: 60)
                .foregroundColor(.white)
                .background(Color(.systemBlue))
                .cornerRadius(30)
            }
            .padding()
        } //: ZSTACK
    }
}

// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ContentViewModel())
    }
}
