//
//  TipsData.swift
//  SunriseTravel
//
//  Created by user262355 on 7/31/24.
//
import Foundation

struct TipsData: Codable {
    let text: String
    let icon: String
    let children: [TipItem]
}

struct TipItem: Codable {
    let text: String
}
