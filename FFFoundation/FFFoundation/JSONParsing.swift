//
//  JSONParsing.swift
//  FFFoundation
//
//  Created by Florian Friedrich on 12/06/16.
//  Copyright © 2016 Florian Friedrich. All rights reserved.
//

#if swift(>=3.0)
//    precedencegroup JSONPrecedence {
//        associativity: right
//        higherThan: AssignmentPrecedence
//        assignment: true
//    }
  
prefix operator <|
infix operator =<| : AssignmentPrecedence
#else
prefix operator <| {}

infix operator =<| {
    associativity left
    precedence 75
    assignment
}
#endif

public prefix func <|<T>(value: JSONDictionary.Value?) -> T? {
    return value as? T
}
//
//public prefix func <|<T: JSONCreatable>(value: JSONDictionary.Value?) -> T? {
//    return (value as? T.JSONType).map(T.init)
//}
//
//public prefix func <|<T: JSONStaticCreatable>(value: JSONDictionary.Value?) -> T? {
//    return (value as? T.JSONType).flatMap(T.from)
//}

public prefix func <|<T: JSONCreatable>(value: T.JSONType) -> T {
    return T(json: value)
}

public prefix func <|<T: JSONCreatable>(value: T.JSONType?) -> T? {
    return value.map(T.init)
}

public prefix func <|<T: JSONStaticCreatable>(value: T.JSONType?) -> T? {
    return value.flatMap(T.from)
}

#if swift(>=3.0)
public func =<|<T>(lhs: inout T, value: JSONDictionary.Value?) {
    if let v: T = <|value { lhs = v }
}

public func =<|<T: JSONCreatable>(lhs: inout T, value: JSONDictionary.Value?) {
    if let val: T = <|value { lhs = val }
}

public func =<|<T: JSONStaticCreatable>(lhs: inout T, value: JSONDictionary.Value?) {
    if let val: T = <|value { lhs = val }
}

public func =<|<T: JSONCreatable>(lhs: inout T?, value: JSONDictionary.Value?) {
    lhs = <|value
}

public func =<|<T: JSONStaticCreatable>(lhs: inout T?, value: JSONDictionary.Value?) {
    lhs = <|value
}

public func =<|<T: JSONCreatable>(lhs: inout T, value: T.JSONType) {
    lhs = <|value
}

public func =<|<T: JSONStaticCreatable>(lhs: inout T, value: T.JSONType) {
    if let val: T = <|value { lhs = val }
}

public func =<|<T: JSONCreatable>(lhs: inout T?, value: T.JSONType?) {
    lhs = <|value
}

public func =<|<T: JSONStaticCreatable>(lhs: inout T?, value: T.JSONType?) {
    lhs = <|value
}
#else
public func =<|<T>(inout lhs: T, value: JSONDictionary.Value?) {
    if let v: T = <|value { lhs = v }
}

public func =<|<T: JSONCreatable>(inout lhs: T, value: JSONDictionary.Value?) {
    if let val: T = <|value { lhs = val }
}

public func =<|<T: JSONStaticCreatable>(inout lhs: T, value: JSONDictionary.Value?) {
    if let val: T = <|value { lhs = val }
}

public func =<|<T: JSONCreatable>(inout lhs: T?, value: JSONDictionary.Value?) {
    lhs = <|value
}

public func =<|<T: JSONStaticCreatable>(inout lhs: T?, value: JSONDictionary.Value?) {
    lhs = <|value
}

public func =<|<T: JSONCreatable>(inout lhs: T, value: T.JSONType) {
    lhs = <|value
}

public func =<|<T: JSONStaticCreatable>(inout lhs: T, value: T.JSONType) {
    if let val: T = <|value { lhs = val }
}

public func =<|<T: JSONCreatable>(inout lhs: T?, value: T.JSONType?) {
    lhs = <|value
}

public func =<|<T: JSONStaticCreatable>(inout lhs: T?, value: T.JSONType?) {
    lhs = <|value
}
#endif

public struct JSON {
    private init() { }
    
    public static func convert<T>(value: JSONDictionary.Value?) -> T? {
        return <|value
    }
    
    #if swift(>=3.0)
    public static func convert<T>(value: JSONDictionary.Value?) -> T? where T: JSONCreatable {
        return <|value
    }
    
    public static func convert<T>(value: JSONDictionary.Value?) -> T? where T: JSONStaticCreatable {
        return <|value
    }
    
    public static func convert<T>(value: T.JSONType) -> T where T: JSONCreatable {
        return <|value
    }
    
    public static func convert<T>(value: T.JSONType) -> T? where T: JSONStaticCreatable {
        return <|value
    }
    
    public static func map<T>(value: JSONDictionary.Value?, to output: inout T) {
        output =<| value
    }
    
    public static func map<T>(value: JSONDictionary.Value?, to output: inout T) where T: JSONCreatable {
        output =<| value
    }
    
    public static func map<T>(value: JSONDictionary.Value?, to output: inout T) where T: JSONStaticCreatable {
        output =<| value
    }
    
    public static func map<T>(value: JSONDictionary.Value?, to output: inout T?) where T: JSONCreatable {
        output =<| value
    }
    
    public static func map<T>(value: JSONDictionary.Value?, to output: inout T?) where T: JSONStaticCreatable {
        output =<| value
    }
    
    public static func map<T>(value: T.JSONType, to output: inout T) where T: JSONCreatable {
        output =<| value
    }
    
    public static func map<T>(value: T.JSONType, to output: inout T) where T: JSONStaticCreatable {
        output =<| value
    }
    
    public static func map<T>(value: T.JSONType?, to output: inout T?) where T: JSONCreatable {
        output =<| value
    }
    
    public static func map<T>(value: T.JSONType?, to output: inout T?) where T: JSONStaticCreatable {
        output =<| value
    }
    #else
    public static func convert<T where T: JSONCreatable>(value: JSONDictionary.Value?) -> T? {
        return <|value
    }
    
    public static func convert<T where T: JSONStaticCreatable>(value: JSONDictionary.Value?) -> T? {
        return <|value
    }
    
    public static func convert<T where T: JSONCreatable>(value: T.JSONType) -> T {
        return <|value
    }
    
    public static func convert<T where T: JSONStaticCreatable>(value: T.JSONType) -> T? {
        return <|value
    }
    
    public static func map<T>(value: JSONDictionary.Value?, inout to output: T) {
        output =<| value
    }
    
    public static func map<T where T: JSONCreatable>(value: JSONDictionary.Value?, inout to output: T) {
        output =<| value
    }
    
    public static func map<T where T: JSONStaticCreatable>(value: JSONDictionary.Value?, inout to output: T) {
        output =<| value
    }
    
    public static func map<T where T: JSONCreatable>(value: JSONDictionary.Value?, inout to output: T?) {
        output =<| value
    }
    
    public static func map<T where T: JSONStaticCreatable>(value: JSONDictionary.Value?, inout to output: T?) {
        output =<| value
    }
    
    public static func map<T where T: JSONCreatable>(value: T.JSONType, inout to output: T) {
        output =<| value
    }
    
    public static func map<T where T: JSONStaticCreatable>(value: T.JSONType, inout to output: T) {
        output =<| value
    }
    
    public static func map<T where T: JSONCreatable>(value: T.JSONType?, inout to output: T?) {
        output =<| value
    }
    
    public static func map<T where T: JSONStaticCreatable>(value: T.JSONType?, inout to output: T?) {
        output =<| value
    }
    #endif
}