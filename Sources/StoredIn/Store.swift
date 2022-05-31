// Copyright (c) 2022 Henrique Sasaki Yuya
// This software is released under the MIT License.
// See LICENSE file for details.

import Foundation

// MARK: - Store

/// ``Store`` provides data storing interfaces.
public protocol Store {
    /// A key type.
    associatedtype Key
    /// Returns whether the store contains a value or not.
    func containsValue(forKey key: Key) -> Bool
    /// Returns the value stored in this type.
    func value<S>(forKey key: Key) -> S? where S: Storable
    /// Sets the value to be stored in this type.
    mutating func set<S>(value: S, forKey key: Key) where S: Storable
}
