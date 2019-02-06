//
//  ModelStatus.swift
//  AnimationTest
//
//  Created by Inna Kuts on 2/3/19.
//  Copyright © 2019 Inna Kuts. All rights reserved.
//

import Foundation

enum ResourceRetrievalStatus<T> {
    
    case empty
    case loading
    case success(T)
    case failure(Error)
    
    var value: T? {
        guard case .success(let value) = self else {
            return nil
        }
        return value
    }
    
    var error: Error? {
        guard case .failure(let error) = self else {
            return nil
        }
        return error
    }
    
    var isEmpty: Bool {
        guard case .empty = self else {
            return false
        }
        return true
    }
    
    var isLoading: Bool {
        guard case .loading = self else {
            return false
        }
        return true
    }
    
    var isSucceded: Bool {
        guard case .success = self else {
            return false
        }
        return true
    }
    
    var isFailed: Bool {
        guard case .failure = self else {
            return false
        }
        return true
    }
}
