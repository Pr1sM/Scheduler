//
//  event.swift
//  Scheduler
//
//  Created by Srinivas Dhanwada on 11/9/17.
//  Copyright © 2017 dhanwada. All rights reserved.
//

import Foundation

public enum EventError: Error {
    case badResource(typesNeeded: [ResourceType])
}

public struct Event {
    public var id:UUID
    public var cooldownTime:Float
    public var warmupTime:Float
    public var time:Float
    public var resourceType:ResourceType
    
    public var totalTime:Float {
        return cooldownTime + warmupTime + time
    }
    
    public var debugDescription:String {
        return "Resource: \(resourceType.toString()) Timings: \(warmupTime)/\(time)/\(cooldownTime) = \(totalTime)"
    }
    
    public init(warmupTime:Float, time:Float, cooldownTime:Float, resourceType:ResourceType) {
        self.warmupTime = warmupTime
        self.time = time
        self.cooldownTime = cooldownTime
        self.resourceType = resourceType
        self.id = UUID()
    }
    
    public init(judging resourceType:ResourceType) throws {
        guard [.judgingCV, .judgingPR, .judgingRD].contains(resourceType) else {
            throw EventError.badResource(typesNeeded: [.judgingPR, .judgingCV, .judgingRD])
        }
        self.resourceType = resourceType
        self.warmupTime = 5.0
        self.cooldownTime = 5.0
        self.time = 15.0
        self.id = UUID()
    }
    
    public init(robotGame resourceType:ResourceType) throws {
        guard resourceType == .robotGame else {
            throw EventError.badResource(typesNeeded: [.robotGame])
        }
        self.resourceType = resourceType
        self.warmupTime = 5.0
        self.cooldownTime = 5.0
        self.time = 7.5
        self.id = UUID()
    }
    
    public static func ==(left:Event, right:Event) -> Bool {
        return left.cooldownTime == right.cooldownTime && left.time == right.time && left.warmupTime == right.warmupTime && left.resourceType == right.resourceType && left.id == right.id
    }
}
