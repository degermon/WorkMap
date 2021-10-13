//
//  SideMenu.swift
//  WorkMap
//
//  Created by Daniel Šuškevič on 2021-10-13.
//

import SwiftUI

struct SideMenu: View {
    // MARK: - PROPERTIES
    
    let width: CGFloat
    let isOpen: Bool
    let menuClose: () -> Void
        
    
    // MARK: - BODY
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            } //: GEOMETRY
            .background(Color.gray.opacity(0.3))
            .opacity(self.isOpen ? 1.0 : 0.0)
            .animation(Animation.easeIn.delay(0.25))
            .onTapGesture {
                self.menuClose()
            } //: TAP
            
            HStack {
                SideList()
                    .frame(width: self.width)
                    .background(Color.white)
                    .offset(x: self.isOpen ? 0 : -self.width)
                    .animation(.default)
                Spacer()
            } //: HSTACK
        } //: ZSTACK
    }
}
