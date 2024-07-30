//
//  Utils+JSON.swift
//  SunriseTravel
//
//  Created by user262355 on 7/30/24.
//
import Foundation

func loadJSONData() -> [TravelCardData]? {
    guard let url = Bundle.main.url(forResource: "locations", withExtension: "json") else {
        return nil
    }
    do {
        let data = try Data(contentsOf: url)
        let travelData = try JSONDecoder().decode([TravelCardData].self, from: data)
        return travelData
    } catch {
        print("Failed to load or parse JSON: \(error)")
        return nil
    }
}
