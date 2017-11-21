//
//  subject.swift
//  Scheduler
//
//  Created by Srinivas Dhanwada on 11/9/17.
//  Copyright © 2017 dhanwada. All rights reserved.
//

import Foundation

public struct Subject {
    public var name:String
    public var number:Int
    public var id:Int
    public var events:[Event]
    public var eventTimes:[UUID:Float]
    public var openEvents:[Event]
    public var closedEvents:[Event]
    
    public var eventsDescription:String {
        var concat = ""
        for e in events {
            concat.append("\t" + e.debugDescription + "\n")
        }
        return concat
    }
    
    public var debugDescription:String {
        return "\(id) - \(number) - \(name), Events: \n\(eventsDescription)"
    }
    
    public var timingSummary:String {
        if(!eventsCompleted) {
            return "\tTiming summary is only available after all events are completed"
        }
        
        var concat = "\(number) - \(name)\n"
        
        for (key, val) in eventTimes {
            concat += "\t\(val): \(events.first(where: { $0.id == key })!.resourceType.toString())\n"
        }
        
        return concat
    }
    
    public var eventsCompleted:Bool {
        return closedEvents.count == events.count
    }
    
    public init(id:Int, number:Int, name:String, events:[Event]) {
        self.id = id
        self.number = number
        self.name = name
        self.events = events
        self.eventTimes = [:]
        self.openEvents = events
        self.closedEvents = []
    }
    
    public mutating func addEventTime(_ time:Float, forEventWithId eventId:UUID) {
        for i in 0..<openEvents.count {
            if(openEvents[i].id == eventId) {
                closedEvents.append(openEvents[i])
                eventTimes.updateValue(time, forKey: eventId)
                openEvents.remove(at: i)
                break
            }
        }
    }
}
