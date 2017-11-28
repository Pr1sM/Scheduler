//
//  system.swift
//  Scheduler
//
//  Created by Srinivas Dhanwada on 11/9/17.
//  Copyright © 2017 dhanwada. All rights reserved.
//

import Foundation

public enum ScheduleError: Error {
    case eventMismatch(event:Event, givenEvents:[Event])
}

public struct System {
    public var resources:[Resource]
    public var subjects:[Subject]
    
    fileprivate var subjectQueue:Queue<Subject>
    fileprivate var resourceQueues:Dictionary<ResourceType, Queue<Resource>>
    fileprivate var currentTime:Float
    
    fileprivate typealias ScheduleLink = (Resource, Subject, Event, Float)
    
    
    public init(resources:[Resource], subjects:[Subject]) {
        self.resources = resources
        self.subjects = subjects
        self.currentTime = 0.0
        
        subjectQueue = Queue<Subject>()
        resourceQueues = [
            .judgingCV: Queue<Resource>(),
            .judgingPR: Queue<Resource>(),
            .judgingRD: Queue<Resource>(),
            .robotGame: Queue<Resource>()
        ]
        
        for s in subjects {
            subjectQueue.enqueue(s)
        }
        
        for r in resources {
            resourceQueues[r.type]!.enqueue(r)
        }
    }
    
    public mutating func schedule() throws {
        currentTime = 0.0;
        var inProgressLinks = [ScheduleLink]()
        var subjectBacklogQueue = Queue<Subject>()
        
        func releaseAvailableLinks() {
            for link in inProgressLinks {
                _ = releaseScheduleLink(link)
            }
        }
        
        func releaseBacklog() {
            while !subjectBacklogQueue.isEmpty {
                subjectQueue.enqueue(subjectBacklogQueue.dequeue()!)
            }
        }
        
        log.d("Current Time: \(currentTime)")
        
        while subjects.first(where: { return !$0.eventsCompleted }) != nil {
            guard currentTime < 12.0*60 else {
                log.d("\tSchedule Time Limit Reached -- No Schedule found!")
                break
            }
            
            
            guard !subjectQueue.isEmpty else {
                currentTime += 7.5
                log.d("Current Time: \(currentTime)")
                log.d("\tSubject Queue empty, releasing backlog and links")
                releaseBacklog()
                releaseAvailableLinks()
                continue
            }
            
            guard subjectQueue.front!.openEvents.first(where: { !resourceQueues[$0.resourceType]!.isEmpty }) != nil else {
                log.t("\tSubject: \(subjectQueue.front!.name) moved to backlog")
                subjectBacklogQueue.enqueue(subjectQueue.dequeue()!)
                continue
            }
            
            let subject = subjectQueue.dequeue()!
            let event = subject.openEvents.first(where: { !resourceQueues[$0.resourceType]!.isEmpty })!
            let resource = resourceQueues[event.resourceType]!.dequeue()!
            
            let link = try reserveResource(resource, forSubject: subject, andEvent: event)
            
            inProgressLinks.append(link)
            log.t("\tReserved Link:")
            logLink(link)
        }
    }
    
    fileprivate mutating func releaseScheduleLink(_ link:ScheduleLink) -> Bool {
        if(currentTime == link.3) {
            for idx in 0..<subjects.count {
                if(subjects[idx].id == link.1.id) {
                    subjects[idx].addEventTime(currentTime - link.2.time, forEventWithId: link.2.id)
                    subjectQueue.enqueue(subjects[idx])
                    resourceQueues[link.0.type]!.enqueue(link.0)
                    log.t("\tReleased link:")
                    logLink(link)
                    return true
                }
            }
        }
        return false
    }
    
    fileprivate func reserveResource(_ resource:Resource, forSubject subject:Subject, andEvent event:Event) throws -> ScheduleLink {
        guard subject.openEvents.contains(where: { return $0 == event }) else {
            throw ScheduleError.eventMismatch(event: event, givenEvents: subject.events)
        }
        
        return (resource, subject, event, currentTime + event.time)
    }
    
    fileprivate func logLink(_ link:ScheduleLink) {
        log.t("\t\tR: \(link.0.name), S: \(link.1.name), E: \(link.2.resourceType.toString()), T: \(link.3)")
    }
}
