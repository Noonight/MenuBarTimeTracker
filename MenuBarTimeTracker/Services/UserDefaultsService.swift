//
//  UserDefaultsHelper.swift
//  MenuBarTranslator
//
//  Created by Aiur on 21.05.2021.
//

import Foundation

enum UserDefaultsKeys: String {
    case currentTaskID = "CurrentTask"
}

protocol TaskUserDefaultsProtocol {
    func getCurrentTaskID() -> UUID?
    func setCurrentTaskID(_ id: UUID)
}

final class UserDefaultsService {
    static let shared: TaskUserDefaultsProtocol = UserDefaultsService()
    
    private let defaults = UserDefaults.standard
}

extension UserDefaultsService: TaskUserDefaultsProtocol {
    func getCurrentTaskID() -> UUID? {
        guard let uuid = defaults.string(forKey: UserDefaultsKeys.currentTaskID.rawValue) else { return nil }
        return UUID(uuidString: uuid)
    }
    
    func setCurrentTaskID(_ id: UUID) {
        defaults.setValue(id.uuidString, forKey: UserDefaultsKeys.currentTaskID.rawValue)
    }
}
