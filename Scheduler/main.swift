//
//  main.swift
//  Scheduler
//
//  Created by Srinivas Dhanwada on 11/9/17.
//  Copyright © 2017 dhanwada. All rights reserved.
//

import Foundation

let testEvents = [
    try Event(judging: .judgingRD),
    try Event(judging: .judgingCV),
    try Event(judging: .judgingPR),
    try Event(robotGame: .robotGame),
    try Event(robotGame: .robotGame),
    try Event(robotGame: .robotGame)
]

let testResources = [
    Resource.robotGameTable1A,
    Resource.robotGameTable1B,
    Resource.judgingPRTrackA,
    Resource.judgingCVTrackA,
    Resource.judgingRDTrackA
]

let testSubjects = [
    Subject(id: 1, number: 1, name: "Team 1", events: testEvents),
    Subject(id: 2, number: 2, name: "Team 2", events: testEvents),
    Subject(id: 3, number: 3, name: "Team 3", events: testEvents),
    Subject(id: 4, number: 4, name: "Team 4", events: testEvents),
    Subject(id: 5, number: 5, name: "Team 5", events: testEvents),
    Subject(id: 6, number: 6, name: "Team 6", events: testEvents),
    Subject(id: 7, number: 7, name: "Team 7", events: testEvents),
    Subject(id: 8, number: 8, name: "Team 8", events: testEvents),
    Subject(id: 9, number: 9, name: "Team 9", events: testEvents),
    Subject(id: 10, number: 10, name: "Team 10", events: testEvents),
    Subject(id: 11, number: 11, name: "Team 11", events: testEvents),
    Subject(id: 12, number: 12, name: "Team 12", events: testEvents)
]

var scheduler = System(resources: testResources, subjects: testSubjects)

try scheduler.schedule()

print("\nTiming Summary Below")

for subject in scheduler.subjects {
    print(subject.timingSummary)
}
