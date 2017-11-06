//
//  Point.swift
//  FFFoundation
//
//  Created by Florian Friedrich on 11.10.17.
//  Copyright 2017 Florian Friedrich
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

public struct Point<Value: FloatingPoint & TriangulatableValue>: Hashable {
    public var x: Value
    public var y: Value

    public var hashValue: Int { return x.hashValue ^ y.hashValue }

    public init(x: Value, y: Value) {
        (self.x, self.y) = (x, y)
    }

    public static func ==(lhs: Point, rhs: Point) -> Bool {
        return (lhs.x, lhs.y) == (rhs.x, rhs.y)
    }
}

public extension Point {
    public static var zero: Point { return .init(x: 0, y: 0) }
}

// TODO: extension Point: Triangulatable where Value: TriangulatableValue
extension Point: Triangulatable {}