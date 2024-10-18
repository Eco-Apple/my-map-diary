//
//  NavigationRouter.swift
//  MyMapDiary
//
//  Created by Jerico Villaraza on 10/18/24.
//

import Foundation
import SwiftUI

@Observable
class NavigationRouter: ObservableObject {
    var path = NavigationPath()
    
    func destination(for route: NavigationRoute) -> some View {
        switch route {
        case .location(let route):
            handleLocationRoutes(route)
        }
    }
    
    private func handleLocationRoutes(_ route: NavigationRoute.LocationRoute) -> some View {
        switch route {
        case .detail:
            EmptyView()
        }
    }
}
