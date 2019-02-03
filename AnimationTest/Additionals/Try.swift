//
//  Try.swift
//  AnimationTest
//
//  Created by Inna Kuts on 2/3/19.
//  Copyright © 2019 Inna Kuts. All rights reserved.
//

import Foundation

enum Try<T> {
    case success(T)
    case failure(Error)
    
    init(_ factory: () throws -> T) {
        do {
            self = .success(try factory())
        } catch {
            self = .failure(error)
        }
    }
    
    init(_ value: T) {
        self = .success(value)
    }
    
    init(_ error: Error) {
        self = .failure(error)
    }
    
    init(_ optional: T?, else factory: @autoclosure () -> Error) {
        if let t = optional {
            self = .success(t)
        } else {
            self = .failure(factory())
        }
    }
    
    
}
