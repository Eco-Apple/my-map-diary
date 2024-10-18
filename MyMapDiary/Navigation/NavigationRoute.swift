//
//  NavigationRoute.swift
//  MyMapDiary
//
//  Created by Jerico Villaraza on 10/18/24.
//

import Foundation

enum NavigationRoute: Hashable {
    case location(LocationRoute)
    
    enum LocationRoute: Hashable {
        case detail
    }
}
