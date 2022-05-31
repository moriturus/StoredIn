// Copyright (c) 2022 Henrique Sasaki Yuya
// This software is released under the MIT License.
// See LICENSE file for details.

import Foundation

// MARK: - Storable

/// ``Storable`` is a marker protocol.
/// Any types that stored in ``Store`` should comfirm this protocol.
///
/// ## Implemented Types
///
/// - `Int`
/// - `Float`
/// - `Double`
/// - `Bool`
/// - `Data`
/// - `String`
/// - `Date`
/// - `Array where Element: Storable`
/// - `Dictionary where Key == String, Value: Storable`
public protocol Storable {
    // marker protocol
}

// MARK: - Int + Storable

extension Int: Storable {
    // marker implementation
}

// MARK: - Float + Storable

extension Float: Storable {
    // marker implementation
}

// MARK: - Double + Storable

extension Double: Storable {
    // marker implementation
}

// MARK: - Bool + Storable

extension Bool: Storable {
    // marker implementation
}

// MARK: - Data + Storable

extension Data: Storable {
    // marker implementation
}

// MARK: - String + Storable

extension String: Storable {
    // marker implementation
}

// MARK: - Date + Storable

extension Date: Storable {
    // marker implementation
}

// MARK: - Array + Storable

extension Array: Storable where Element: Storable {
    // marker implementation
}

// MARK: - Dictionary + Storable

extension Dictionary: Storable where Key == String, Value: Storable {
    // marker implementation
}

// MARK: - StoringTypeConvertible

/// `StoringTypeConvertible` provides data conversion interfaces.
/// Any types that stored in ``Store`` should comfirm this protocol.
///
/// The default implementations will be provided if you pass your type as ``StoringTypeConvertible/StoringType``.
///
/// ## Implemented Types
///
/// - `Int`
/// - `Float`
/// - `Double`
/// - `Bool`
/// - `Data`
/// - `String`
/// - `Date`
/// - `Array where Element: Storable`
/// - `Dictionary where Key == String, Value: Storable`
public protocol StoringTypeConvertible {
    /// The actual type to be stored in ``Store``.
    associatedtype StoringType: Storable

    /// Returns the value to be stored in ``Store``.
    var storingValue: StoringType { get }
    /// The initializer with the value stored in ``Store``.
    ///
    /// - Parameter storedValue: The value stored in ``Store``.
    init?(from storedValue: StoringType)
}

extension StoringTypeConvertible where StoringType == Self {
    public var storingValue: Self {
        self
    }

    public init?(from storedValue: Self) {
        self = storedValue
    }
}

// MARK: - Int + StoringTypeConvertible

extension Int: StoringTypeConvertible {
    public typealias StoringType = Self
}

// MARK: - Float + StoringTypeConvertible

extension Float: StoringTypeConvertible {
    public typealias StoringType = Self
}

// MARK: - Double + StoringTypeConvertible

extension Double: StoringTypeConvertible {
    public typealias StoringType = Self
}

// MARK: - Bool + StoringTypeConvertible

extension Bool: StoringTypeConvertible {
    public typealias StoringType = Self
}

// MARK: - Data + StoringTypeConvertible

extension Data: StoringTypeConvertible {
    public typealias StoringType = Self
}

// MARK: - String + StoringTypeConvertible

extension String: StoringTypeConvertible {
    public typealias StoringType = Self
}

// MARK: - Date + StoringTypeConvertible

extension Date: StoringTypeConvertible {
    public typealias StoringType = Self
}

// MARK: - Array + StoringTypeConvertible

extension Array: StoringTypeConvertible where Element: Storable {
    public typealias StoringType = Self
}

// MARK: - Dictionary + StoringTypeConvertible

extension Dictionary: StoringTypeConvertible where Key == String, Value: Storable {
    public typealias StoringType = Self
}
