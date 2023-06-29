//
//  PickupPoint.swift
//  Vestiaire Collective
//
//  Created by Duy Tran on 02/02/2023.
//  Copyright © 2023 VestiaireCollective. All rights reserved.
//

import MapKit

/// A prearranged place where you go to collect things.
struct PickupPoint: Codable, Equatable {
    let address: String?
    let name: String?
    let city: String?
    let reference: String
    let location: Location
    let carrier: Carrier?
    let openingTimes: OpeningTimes?
    let distance: Distance?

    // MARK: PickupPoint - Init

    init(
        address: String? = nil,
        name: String? = nil,
        city: String? = nil,
        reference: String = "",
        location: Location = Location(latitude: 0, longitude: 0),
        carrier: Carrier? = nil,
        openingTimes: OpeningTimes? = nil,
        distance: Distance? = nil
    ) {
        self.address = address
        self.name = name
        self.city = city
        self.reference = reference
        self.location = location
        self.carrier = carrier
        self.openingTimes = openingTimes
        self.distance = distance
    }

    // MARK: PickupPoint - Subtypes

    struct Carrier: Codable, Hashable {
        let name: String?
        let iconURL: URL?

        enum CodingKeys: String, CodingKey {
            case name
            case iconURL = "iconUrl"
        }
    }

    struct Distance: Codable, Hashable {
        let formatted: String?
        let meters: Int?
    }

    struct Location: Codable, Hashable {
        let latitude, longitude: Double

        var coordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }

        enum CodingKeys: String, CodingKey {
            case latitude = "lat"
            case longitude = "lng"
        }
    }

    struct OpeningTimes: Codable, Hashable {
        let monday: String?
        let friday: String?
        let sunday: String?
        let tuesday: String?
        let thursday: String?
        let wednesday: String?
        let saturday: String?
    }
}

extension PickupPoint: Identifiable {
    // MARK: PickupPoint - Identifiable

    var id: String {
        reference
    }
}

extension  PickupPoint {
    // MARK: PickupPoint - Previews

    enum Preview {
        static var applePark: PickupPoint {
            PickupPoint(
                address: "One Apple Park Way, Cupertino, CA 95014, United States",
                name: "Apple Park",
                city: "Cupertino",
                reference: "One Apple Park Way, Cupertino, CA 95014, United States",
                location: Location(
                    latitude: 37.334_900,
                    longitude: -122.009_020),
                carrier: Carrier(
                    name: "Apple",
                    iconURL: URL(string: "https://cdn-icons-png.flaticon.com/512/0/747.png")),
                openingTimes: OpeningTimes(
                    monday: "09:00 - 19:00",
                    friday: "09:00 - 19:00",
                    sunday: nil,
                    tuesday: "09:00 - 19:00",
                    thursday: "09:00 - 19:00",
                    wednesday: "09:00 - 19:00",
                    saturday: "09:00 - 19:00"),
                distance: Distance(formatted: "2m", meters: 2))
        }

        static var theDukeOfEdinburgh: PickupPoint {
            PickupPoint(
                address: "10801 N Wolfe Rd, Cupertino, CA 95014, United States",
                name: "The Duke of Edinburgh",
                city: "Cupertino",
                reference: "10801 N Wolfe Rd, Cupertino, CA 95014, United States",
                location: Location(
                    latitude: 37.334944,
                    longitude: -122.014694),
                carrier: Carrier(
                    name: "The Duke of Edinburgh",
                    iconURL: URL(string: "https://cdn-icons-png.flaticon.com/512/0/747.png")),
                openingTimes: OpeningTimes(
                    monday: "09:00 - 19:00",
                    friday: "09:00 - 19:00",
                    sunday: "09:00 - 19:00",
                    tuesday: "09:00 - 19:00",
                    thursday: "09:00 - 19:00",
                    wednesday: "09:00 - 19:00",
                    saturday: "09:00 - 19:00"),
                distance: Distance(formatted: "3m", meters: 3))
        }

        static var wolfeLiquor: PickupPoint {
            PickupPoint(
                address: "1689 S Wolfe Rd, Sunnyvale, CA 94087, United States",
                name: "Wolfe Liquor",
                city: "Cupertino",
                reference: "1689 S Wolfe Rd, Sunnyvale, CA 94087, United States",
                location: Location(
                    latitude: 37.338337,
                    longitude: -122.014590),
                carrier: Carrier(
                    name: "Wolfe Liquor",
                    iconURL: URL(string: "https://cdn-icons-png.flaticon.com/512/0/747.png")),
                openingTimes: OpeningTimes(
                    monday: "09:00 - 19:00",
                    friday: "09:00 - 19:00",
                    sunday: "09:00 - 19:00",
                    tuesday: "09:00 - 19:00",
                    thursday: "09:00 - 19:00",
                    wednesday: "09:00 - 19:00",
                    saturday: "09:00 - 19:00"),
                distance: Distance(formatted: "5m", meters: 5))
        }
    }
}
