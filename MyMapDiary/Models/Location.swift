//
//  Location.swift
//  MyMapDiary
//
//  Created by Jerico Villaraza on 10/18/24.
//

import CoreLocation
import UIKit
import SwiftData

@Model
class Location: Codable, Identifiable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case latitude
        case longitude
        case imageData
        
        case createdAt
        case updatedAt
    }
    
    private(set) var id: UUID
    private(set) var latitude: Double
    private(set) var longitude: Double
    @Attribute(.externalStorage) private var imageData: Data
    
    private var createdAt: Date
    private var updatedAt: Date
    
    var uiImage: UIImage {
        return UIImage(data: imageData)!
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(latitude: Double, longitude: Double, imageData: Data) {
        self.id = UUID()
        self.latitude = latitude
        self.longitude = longitude
        self.imageData = imageData
        self.createdAt = .now
        self.updatedAt = .now
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
        imageData = try container.decode(Data.self, forKey: .imageData)
        createdAt = try container.decode(Date.self, forKey: .createdAt)
        updatedAt = try container.decode(Date.self, forKey: .updatedAt)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(imageData, forKey: .imageData)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
    }
}

extension Location {
    static var preview: Location {
        let uiImage = UIImage(named: "swiz")!
        let data = uiImage.jpegData(compressionQuality: 80)!
        return Location(latitude: 20.45798, longitude: 121.9941, imageData: data)
    }
}
