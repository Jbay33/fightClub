//
//  TeamData.swift
//  pitScoutingJordan
//
//  Created by Milo Woodman on 12/8/22.
//

import Foundation

enum DriveTrain: Codable {
    case Unkown
    case Tank
    case Swerve
    case WestCoast
    case Other(String)
}

class Team: Codable, Identifiable {
    static func == (lhs: Team, rhs: Team) -> Bool {
        return lhs.number == rhs.number
    }
    
    var id = UUID()
    
    var driveTrain: DriveTrain
    var number: Int
    
    var robotWorking: Bool
    
    var shootsHigh: Bool
    var shootsLow: Bool
    
    init(num: Int) {
        self.number = num
        self.driveTrain = .Unkown
        self.shootsLow = false
        self.shootsHigh = false
        self.robotWorking = false
    }
}
