//
//  Phone.swift
//  RealmManager_iOS
//
//  Created by 전소영 on 2022/12/12.
//

import Foundation
import RealmSwift

class Phone: Object {
    @Persisted(primaryKey: true) var number: String?
    @Persisted var name: String = ""
    @Persisted var status: String = ""

    convenience init(number: String) {
        self.init()
        self.number = number
    }
}
