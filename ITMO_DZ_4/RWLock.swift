//
//  RWLock.swift
//  ITMO_DZ_4
//
//  Created by StepanShimigonov  on 04.12.2023.
//

import Foundation

class RWLock {
    private var rwlock = pthread_rwlock_t()
    
    init() {
        let initCode = pthread_rwlock_init(&rwlock, nil)
        guard initCode == 0 else {
            fatalError("Error with code \(initCode) while init rwlock")
        }
    }
    
    deinit {
        let destroytCode = pthread_rwlock_destroy(&rwlock)
        guard destroytCode == 0 else {
            fatalError("Error with code \(destroytCode) while destroy rwlock")
        }
    }
    
    @discardableResult
    func readLock() -> Bool {
        pthread_rwlock_rdlock(&rwlock) == 0
    }
    
    @discardableResult
    func writeLock() -> Bool {
        pthread_rwlock_wrlock(&rwlock) == 0
    }
    
    @discardableResult
    func unlock() -> Bool {
        pthread_rwlock_unlock(&rwlock) == 0
    }
}
