//
//  TaskTime+CoreDataProperties.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 29.05.2021.
//
//

import Foundation
import CoreData


extension TaskTime {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskTime> {
        return NSFetchRequest<TaskTime>(entityName: "TaskTime")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var time: Date?
    @NSManaged public var task: Task?

}

extension TaskTime : Identifiable {

}
