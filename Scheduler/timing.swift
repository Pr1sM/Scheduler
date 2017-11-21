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
    
    public init(startTime:Float, endTime:Float, resource:Resource, subject:Subject) {
        self._startTime = startTime
        self._endTime = endTime
        self._resourceRequired = resource
        self._subjectRequired = subject
    }
}
