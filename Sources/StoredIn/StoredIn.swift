// Copyright (c) 2022 Henrique Sasaki Yuya
// This software is released under the MIT License.
// See LICENSE file for details.

import Foundation

// MARK: - StoredIn

/// ``StoredIn/StoredIn`` is a property wrapper.
///
/// You should specify three types.
///  - `S` should be a type confirms to ``Store`` protocol.
///  - `K` should equal to `S.Key`.
///  - `V` should be a type confirms to ``StoringTypeConvertible``.
@propertyWrapper
public struct StoredIn<S, K, V> where S: Store, S.Key == K, V: StoringTypeConvertible {
    /// Value stroing strategy.
    public enum Strategy {
        /// The default strategy. You can change stored value as many times as you need.
        case `default`
        /// You can store a value only once.
        case once
    }

    private var store: S
    private let key: K
    private let `default`: V
    private let strategy: Strategy

    public var wrappedValue: V {
        get {
            self.store.value(forKey: self.key).flatMap(V.init) ?? self.default
        }

        set {
            switch self.strategy {
            case .default:
                self.store.set(value: newValue.storingValue, forKey: self.key)
            case .once:
                if !self.store.containsValue(forKey: self.key) {
                    self.store.set(value: newValue.storingValue, forKey: self.key)
                }
            }
        }
    }

    public init(store: S, key: K, `default`: V, strategy: Strategy = .default) {
        self.key = key
        self.default = `default`
        self.store = store
        self.strategy = strategy
    }
}
