//
//  Task+CoreDataProperties.swift
//  MenuBarTimeTracker
//
//  Created by Aiur on 29.05.2021.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var describe: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var taskTimes: NSSet?

}

// MARK: Generated accessors for taskTimes
extension Task {

    @objc(addTaskTimesObject:)
    @NSManaged public func addToTaskTimes(_ value: TaskTime)

    @objc(removeTaskTimesObject:)
    @NSManaged public func removeFromTaskTimes(_ value: TaskTime)

    @objc(addTaskTimes:)
    @NSManaged public func addToTaskTimes(_ values: NSSet)

    @objc(removeTaskTimes:)
    @NSManaged public func removeFromTaskTimes(_ values: NSSet)

}

extension Task : Identifiable {

}
