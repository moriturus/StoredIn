# StoredIn

[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

`StoredIn` is a simple property wrapper library to store any value in anywhere.

## Installation

Please use the `Swift Package Manager`.

```swift
dependencies: [
    .package(url: "https://github.com/moriturus/StoredIn.git", .upToNextMajor(from: "1.0.0"))
]
```

## Usage

```swift
import StoredIn

// implement the `Store` where your data are saved.
final class SharedDictionary: Store {
    var inner: [String: Any] = [:]
    
    func containsValue(forKey key: String) -> Bool {
        self.inner[key] != nil
    }
    
    func value<S>(forKey key: String) -> S? where S : Storable {
        self.inner[key] as? S
    }
    
    func set<S>(value: S, forKey key: String) where S : Storable {
        self.inner[key] = value
    }
}

let sharedDictionary = SharedDictionary()

struct Foo {
    @StoredIn(store: sharedDictionary, key: "key", default: 0, strategy: .default)
    var value: Int
}

var foo = Foo()
let x = foo.value // x == 0
foo.value = 1
sharedDictionary.inner["key"] as? Int == foo.value // true
```

## Strategy

- `default`
    - The default strategy. You can change stored value as many times as you need.
- `once`
    - You can store a value only once.

## License

This software is released under the MIT License.  
See LICENSE file for details.
