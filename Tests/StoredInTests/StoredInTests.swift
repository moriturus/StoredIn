// Copyright (c) 2022 Henrique Sasaki Yuya
// This software is released under the MIT License.
// See LICENSE file for details.

import XCTest
@testable import StoredIn

// MARK: - SharedDictionary

final class SharedDictionary: Store {
    typealias Key = String
    var inner: [Key: Any] = [:]
    
    func containsValue(forKey key: Key) -> Bool {
        self.inner[key] != nil
    }
    
    func value<S>(forKey key: Key) -> S? where S : Storable {
        self.inner[key] as? S
    }
    
    func set<S>(value: S, forKey key: Key) where S : Storable {
        self.inner[key] = value
    }
    
    func removeAll() {
        self.inner.removeAll()
    }
}

private var sharedDictionary: SharedDictionary = SharedDictionary()

// MARK: - StoredInTests

final class StoredInTests: XCTestCase {
    override func tearDown() {
        super.tearDown()
        
        sharedDictionary.removeAll()
    }
    
    func testStoredInIntValue() {
        struct Foo {
            @StoredIn(store: sharedDictionary, key: "key", default: 0)
            var value: Int
            @StoredIn(store: sharedDictionary, key: "key2", default: 0.0)
            var value2: Float
        }
        
        var x = Foo()
        XCTAssertEqual(x.value, 0)
        
        x.value = 1
        XCTAssertEqual(x.value, sharedDictionary.inner["key"] as? Int)
    }
    
    func testOnceStoredInIntValue() {
        struct Foo {
            @StoredIn(store: sharedDictionary, key: "key", default: 0, strategy: .once)
            var value: Int
        }
        
        var x = Foo()
        XCTAssertEqual(x.value, 0)
        
        x.value = 1
        XCTAssertEqual(x.value, sharedDictionary.inner["key"] as? Int)
        
        x.value = 2
        XCTAssertEqual(x.value, 1)
        XCTAssertEqual(sharedDictionary.inner["key"] as? Int, 1)
    }
}
