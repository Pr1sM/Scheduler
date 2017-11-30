//
//  timing.swift
//  Scheduler
//
//  Created by Srinivas Dhanwada on 11/9/17.
//  Copyright © 2017 dhanwada. All rights reserved.
//

import Foundation

public struct Timing {
    fileprivate var _startTime:Float
    fileprivate var _endTime:Float
    fileprivate var _resourceRequired:Resource
    fileprivate var _subjectRequired:Subject
    
    public var startTime:Float {
        return _startTime
    }
    
    public var endTime:Float {
        return _endTime
    }
    
    public var resourceRequired:Resource {
        return _resourceRequired
    }
    
    public var subjectRequired:Subject {
        return _subjectRequired
    }
    
    public var description:String {
        return "\(startTime) - \(endTime): \(subjectRequired.number), \(resourceRequired.name)"
    }
    
    public var isBlank:Bool {
        return self == Timing.blank
    }
    
    public init(startTime:Float, endTime:Float, resource:Resource, subject:Subject) {
        self._startTime = startTime
        self._endTime = endTime
        self._resourceRequired = resource
        self._subjectRequired = subject
    }
    
    public static func < (left:Timing, right:Timing) -> Bool {
        return left.startTime < right.startTime
    }
    
    public static func == (left:Timing, right:Timing) -> Bool {
        return left.startTime == right.startTime && left.endTime == right.endTime && left.resourceRequired == right.resourceRequired && left.subjectRequired == right.subjectRequired
    }
    
    public static let blank = Timing(startTime: -1, endTime: -1, resource: Resource.blank, subject: Subject.blank)
}
