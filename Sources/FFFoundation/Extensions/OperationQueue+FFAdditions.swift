//
//  OperationQueue+FFAdditions.swift
//  FFFoundation
//
//  Created by Florian Friedrich on 10.12.14.
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

import class Foundation.OperationQueue
import class Foundation.BlockOperation

public extension OperationQueue {
    public var isMain: Bool { return self === type(of: self).main }
    
    public var isCurrent: Bool { return type(of: self).current.flatMap { $0 === self } ?? false }
    
    public func addOperation(with block: @escaping () -> (), completion: @escaping () -> ()) {
        let operation = BlockOperation(block: block)
        operation.completionBlock = completion
        addOperation(operation)
    }
    
    public func addOperationWithBlockAndWait(block: @escaping () -> ()) {
        addOperation(with: block, andWait: true)
    }
    
    public func addOperationWithBlockAndWaitIfNotCurrentQueue(block: @escaping () -> ()) {
        addOperation(with: block, andWait: !isCurrent)
    }
    
    private final func addOperation(with block: @escaping () -> (), andWait wait: Bool) {
        let operation = BlockOperation(block: block)
        addOperations([operation], waitUntilFinished: wait)
    }
}
