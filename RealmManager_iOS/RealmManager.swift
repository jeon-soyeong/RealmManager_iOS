//
//  RealmManager.swift
//  RealmManager_iOS
//
//  Created by 전소영 on 2022/12/12.
//

import Foundation
import RealmSwift

final class RealmManager {
    private let realm: Realm?

    init(_ realm: Realm? = try? Realm()) {
        self.realm = realm
        // Realm 파일 위치
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }

    func saveObject<T: Object>(_ object: T) {
        try? realm?.write {
            realm?.add(object)
        }
    }

    func updateObject<T: Object>(_ object: T) {
        try? realm?.write {
            realm?.add(object, update: .modified)
        }
    }

    func selectObjects<T: Object>(_ type: T.Type, predicate: NSPredicate? = nil) -> [T]? {
        guard let predicate = predicate else {
            return realm?.objects(type.self).toArray(type: T.self)
        }
        
        return realm?.objects(type.self).filter(predicate).toArray(type: T.self)
    }

    func deleteObject<T: Object>(_ object: T) {
        try? realm?.write {
            realm?.delete(object)
        }
    }

    func deleteObjectByPredicate<T: Object>(withType type: T.Type, predicate: NSPredicate? = nil) {
        if let predicate = predicate,
           let object = realm?.objects(type).filter(predicate) {
            try? realm?.write {
                realm?.delete(object)
            }
        }
    }

    func deleteAllObjects() {
        try? realm?.write {
            realm?.deleteAll()
        }
    }
}

extension Results {
    func toArray<T>(type: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }
 }
