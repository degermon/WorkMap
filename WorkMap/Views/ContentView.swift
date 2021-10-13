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
    @State var menuOpen: Bool = false
    
    // MARK: - BODY
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(coordinateRegion: $contentViewModel.region, showsUserLocation: true)
                .ignoresSafeArea()
                .accentColor(Color(.systemRed))
                .onAppear {
                    contentViewModel.checkIfLocationServicesIsEnabled()
                } //: ONAPPEAR
            
            HStack { // HSTACK with both buttons for list and current location
                if !self.menuOpen { // show list of locations to to display
                    Button(action: {
                        self.openMenu()
                    }, label: {
                        Image(systemName: "list.bullet")
                    })
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)
                        .background(Color(.systemBlue))
                        .cornerRadius(30)
                }
                
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
            } //: HSTACK
            .padding()
            
            SideMenu(width: 270,
                     isOpen: self.menuOpen,
                     menuClose: self.openMenu)
                .ignoresSafeArea()
        } //: ZSTACK
    } //: BODY
    
    func openMenu() {
        self.menuOpen.toggle()
    }
}

// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ContentViewModel())
    }
}
