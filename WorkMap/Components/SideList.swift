//
//  SideList.swift
//  WorkMap
//
//  Created by Daniel Šuškevič on 2021-10-13.
//

import SwiftUI

struct SideList: View {
    // MARK: - PROPERTIES
    
    @EnvironmentObject var contentViewModel: ContentViewModel
    @State private var expand = false
    @State private var locationList: [Location] = []
    
    // MARK: - BODY
    
    var body: some View {
        VStack {
            Text("Locations")
                .padding(.top, 40)
            List {
                ForEach(locationList) { location in
                    Button {
                        contentViewModel.showLocation(location)
                    } label: {
                        Text(location.title)
                            .font(.title3)
                            .lineLimit(2)
                    }
                } //: LOOP
            } //: LIST
            .onAppear {
                locationList = contentViewModel.locationsList
        } //: ONAPPEAR
        } //: VSTACK
    }
}

// MARK: - PREVIEW

struct SideList_Previews: PreviewProvider {
    static var previews: some View {
        SideList()
            .environmentObject(ContentViewModel())
    }
}
