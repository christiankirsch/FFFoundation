//
//  FunctionsAndHelpers.swift
//  FFFoundation
//
//  Created by Florian Friedrich on 9.12.14.
//  Copyright 2014 Florian Friedrich
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation

#if swift(>=3.0)
    @available(*, deprecated, message:"Use NSLocalizedString again. Its API is now fine to use in Swift.", renamed:"NSLocalizedString")
    @warn_unused_result
    public func localizedString(key: String, comment: String = "") -> String {
        return NSLocalizedString(key, comment: comment)
    }
#else
    @available(*, deprecated, message="Use NSLocalizedString again. Its API is now fine to use in Swift.", renamed="NSLocalizedString")
    @warn_unused_result
    public func localizedString(key: String, comment: String = "") -> String {
        return NSLocalizedString(key, comment: comment)
    }
#endif


/**
 Swift-aware NSStringFromClass. Removes '.' in Swift class names if `removeNamespace` is `true`.
 
 - parameter aClass:          The class to convert to a string.
 - parameter removeNamespace: If `true`, Dots (and the preceding namespace) gets removed from the name. Defaults to `true`.
 
 - returns: The name of the class as string. Dots are removed if `removeNamespace` was `true`.
 
 - note: If `removeNamespace` is `false`, this function behaves just like `NSSStringFromClass`.
 */
@warn_unused_result
public func StringFromClass(aClass: AnyClass, removeNamespace: Bool = true) -> String {
    var className = NSStringFromClass(aClass)
#if swift(>=3.0)
    if let range = className.range(of: ".", options: .backwardsSearch) where removeNamespace {
        className = className.substring(from: range.upperBound)
    }
#else
    if let range = className.rangeOfString(".", options: .BackwardsSearch) where removeNamespace {
        className = className.substringFromIndex(range.endIndex)
    }
#endif
    return className
}
