//
//  TravelCardData.swift
//  SunriseTravel
//
//  Created by user262355 on 7/30/24.
//

import Foundation

struct TravelCardData: Codable {
    let id: Int
    let name: String
    let country: String
    let description: String
    let more: String
    let latitude: Double
    let longitude: Double
    let heroPicture: String
    let pictures: [String]
    let advisory: String
}
