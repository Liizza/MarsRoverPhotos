//
//  Models.swift
//  MarsRoverPhotos
//
//  Created by Liza on 02.10.2023.
//

import Foundation

enum RoverType: String, CaseIterable {
    case all
    case curiosity
    case opportunity
    case spirit
    
    var fullName: String {
        switch self {
        case .all: return "All"
        case .curiosity: return "Curiosity"
        case .opportunity: return "Opportunity"
        case .spirit: return "Spirit"
        }
    }
    var cameraTypes: [CameraType] {
        switch self {
        case .all: return CameraType.allCases
        case .curiosity: return [ .all, .fhaz, .rhaz, .mast, .chemcam, .mahli, .mardi, .navcam]
        case .opportunity, .spirit : return [.all, .fhaz, .rhaz, .navcam, .pancam, .minites]
        }
    }
    
}

enum CameraType: String, CaseIterable {
    case all
    case fhaz
    case rhaz
    case mast
    case chemcam
    case mahli
    case mardi
    case navcam
    case pancam
    case minites
    
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
    var roverTypes: [RoverType] {
        switch self {
        case .fhaz, .rhaz, .navcam, .all: return RoverType.allCases
        case .pancam, .minites : return [.all, .opportunity, .spirit]
        case .mast, .chemcam, .mahli, .mardi: return [.all, .curiosity]
        }
    }
}
