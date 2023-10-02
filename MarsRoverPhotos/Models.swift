//
//  Models.swift
//  MarsRoverPhotos
//
//  Created by Liza on 02.10.2023.
//

import Foundation

enum RoverType: String, CaseIterable {
    case curiosity
    case opportunity
    case spirit
}

enum CameraType: String, CaseIterable {
    case fhaz
    case rhaz
    case mast
    case chemcam
    case mahli
    case mardi
    case navcam
    case pancam
    case minites
    case all
    
    var fullName: String {
        switch self {
        case .fhaz: return "Front Hazard Avoidance Camera"
        case .rhaz: return "Rear Hazard Avoidance Camera"
        case .mast: return "Mast Camera"
        case .chemcam: return "Chemistry and Camera Complex"
        case .mahli: return "Mars Hand Lens Imager"
        case .mardi: return "Mars Descent Imager"
        case .navcam: return "Navigation Camera"
        case .pancam: return "Panoramic Camera"
        case .minites: return "Miniature Thermal Emission Spectrometer (Mini-TES)"
        case .all: return "All"
        }
    }
}
