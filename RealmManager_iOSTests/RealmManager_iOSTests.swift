//
//  RealmManager_iOSTests.swift
//  RealmManager_iOSTests
//
//  Created by 전소영 on 2022/12/12.
//

import XCTest
import RealmSwift
@testable import RealmManager_iOS

final class RealmManager_iOSTests: XCTestCase {
    var realmManager: RealmManager?
    var phone1: Phone?
    
    override func setUpWithError() throws {
        realmManager = RealmManager()
        realmManager?.deleteAllObjects()
        phone1 = Phone(number: "010-1111-1111")
        phone1?.name = "1111"
        phone1?.status = "저장1"
    }

    func test_givenRealmManager_whenSaveData_ThenSuccess() throws {
        guard let phone1 else {
            return
        }
        realmManager?.saveObject(phone1)
        
        let phoneBooks = realmManager?.selectObjects(Phone.self)
        if let phoneBook1 = phoneBooks?.first {
            XCTAssertEqual(phoneBook1.number, "010-1111-1111")
            XCTAssertEqual(phoneBook1.name, "1111")
            XCTAssertEqual(phoneBook1.status, "저장1")
            XCTAssertNotEqual(phoneBook1.status, "저장2")
        }
    }
    
    func test_givenRealmManager_whenUpdateData_ThenSuccess() throws {
        guard let phone1 else {
            return
        }
        phone1.name = "2222"
        phone1.status = "저장2"
        realmManager?.updateObject(phone1)
        
        let phoneBooks = realmManager?.selectObjects(Phone.self)
        if let phoneBook1 = phoneBooks?.first {
            XCTAssertEqual(phoneBook1.number, "010-1111-1111")
            XCTAssertEqual(phoneBook1.name, "2222")
            XCTAssertEqual(phoneBook1.status, "저장2")
            XCTAssertNotEqual(phoneBook1.status, "저장1")
        }
    }
    
    func test_givenRealmManager_whenDeleteData_ThenSuccess() throws {
        guard let phone1 else {
            return
        }
        realmManager?.saveObject(phone1)
        
        if let phoneBooks = realmManager?.selectObjects(Phone.self) {
            XCTAssertEqual(phoneBooks.count, 1)
        }
        realmManager?.deleteObject(phone1)
        if let phoneBooks = realmManager?.selectObjects(Phone.self) {
            XCTAssertEqual(phoneBooks.count, 0)
        }
    }
    
    func test_givenRealmManager_whenDeleteAllData_ThenSuccess() throws {
        guard let phone1 else {
            return
        }
        let phone2 = Phone(number: "010-2222-2222")
        realmManager?.saveObject(phone1)
        realmManager?.saveObject(phone2)
        
        if let phoneBooks = realmManager?.selectObjects(Phone.self) {
            XCTAssertEqual(phoneBooks.count, 2)
        }
        realmManager?.deleteAllObjects()
        if let phoneBooks = realmManager?.selectObjects(Phone.self) {
            XCTAssertEqual(phoneBooks.count, 0)
        }
    }
}






//final class RealmManager_iOSTests: XCTestCase {
//    var realmManager = RealmManager()
//    var phoneBook: Phonebook?
//
//    override func setUpWithError() throws {
////        phoneBook = Phonebook(number: "010-1111-1111")
////        phoneBook?.name = "1111"
////        phoneBook?.status = "저장1"
////        print("초기화")
//    }
//
//    func test_give() throws {
//        XCTAssertEqual("d", "저장2")
////        guard let phoneBook else {
////            return
////        }
////        realmManager.saveObject(phoneBook)
////            print("all: \(realmManager.selectObjects(Phonebook.self))")
////            let phoneBooks = realmManager.selectObjects(Phonebook.self)
////            if let phoneBook1 = phoneBooks?.first {
////                XCTAssertEqual(phoneBook1.name, "1111")
////                XCTAssertEqual(phoneBook1.status, "저장2")
////            }
//    }
//
////: QuickSpec {
////    override func spec() {
////        var realmManager: RealmManager?
////        var phoneBook: Phonebook?
////
////        describe("RealmManager에서") {
////            beforeEach {
////                realmManager = RealmManager()
////                phoneBook = Phonebook(number: "010-1111-1111")
////                phoneBook?.name = "1111"
////                phoneBook?.status = "저장1"
////                print("초기화")
////            }
////            context("phoneBook object를 save하면") {
////                guard let phoneBook else {
////                    return
////                }
////                realmManager?.saveObject(phoneBook)
////                it("save 된 phoneBook의 name은 '1111'이고, status는 '저장1'이다.") {
////                    print("all: \(realmManager?.selectObjects(Phonebook.self))")
////                    let phoneBooks = realmManager?.selectObjects(Phonebook.self)
////                    if let phoneBook1 = phoneBooks?.first {
////                        expect(phoneBook1.name).to(equal("1111"))
////                        expect(phoneBook1.status).to(equal("저장2"))
////                    }
////                }
////            }
////
//////            context("phoneBook object를 update 하면") {
//////                phoneBook?.name = "2222"
//////                phoneBook?.status = "저장2"
//////                guard let phoneBook else {
//////                    return
//////                }
//////                realmManager?.saveObject(phoneBook)
//////                let phoneBooks = realmManager?.selectObjects(Phonebook.self)
//////                if let phoneBook1 = phoneBooks?.first {
//////                    expect(phoneBook1.name).to(equal("2222"))
//////                    expect(phoneBook1.status).to(equal("저장1"))
//////                    expect(phoneBook1.status).to(equal("저장3"))
//////                }
//////            }
////        }
////    }
//}
