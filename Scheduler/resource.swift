//
//  resource.swift
//  Scheduler
//
//  Created by Srinivas Dhanwada on 11/9/17.
//  Copyright © 2017 dhanwada. All rights reserved.
//

import Foundation

public enum ResourceType:Int {
    case none, robotGame, judgingPR, judgingCV, judgingRD
    
    public func toString() -> String {
        return (self == .none) ? "none" :
            (self == .robotGame) ? "Robot Game" :
            (self == .judgingPR) ? "PR Judging" :
            (self == .judgingCV) ? "CV Judging" :
            (self == .judgingRD) ? "RD Judging" : "ERROR"
    }
}

public struct Resource {
    public var name:String
    public var type:ResourceType
    
    public var debugDescription:String {
        return "\(name) - \(type.toString())"
    }
    
    public init(name:String, type:ResourceType) {
        self.name = name
        self.type = type
    }
    
    public static let robotGameTable1A = Resource(name: "Table 1A", type: .robotGame)
    public static let robotGameTable1B = Resource(name: "Table 1B", type: .robotGame)
    public static let robotGameTable2A = Resource(name: "Table 2A", type: .robotGame)
    public static let robotGameTable2B = Resource(name: "Table 2B", type: .robotGame)
    public static let robotGameTable3A = Resource(name: "Table 3A", type: .robotGame)
    public static let robotGameTable3B = Resource(name: "Table 3B", type: .robotGame)
    public static let judgingPRTrackA  = Resource(name: "Project Judging A", type: .judgingPR)
    public static let judgingPRTrackB  = Resource(name: "Project Judging B", type: .judgingPR)
    public static let judgingPRTrackC  = Resource(name: "Project Judging C", type: .judgingPR)
    public static let judgingCVTrackA  = Resource(name: "Core Values Judging A", type: .judgingCV)
    public static let judgingCVTrackB  = Resource(name: "Core Values Judging B", type: .judgingCV)
    public static let judgingCVTrackC  = Resource(name: "Core Values Judging C", type: .judgingCV)
    public static let judgingRDTrackA  = Resource(name: "Robot Design Judging A", type: .judgingRD)
    public static let judgingRDTrackB  = Resource(name: "Robot Design Judging B", type: .judgingRD)
    public static let judgingRDTrackC  = Resource(name: "Robot Design Judging C", type: .judgingRD)
}
