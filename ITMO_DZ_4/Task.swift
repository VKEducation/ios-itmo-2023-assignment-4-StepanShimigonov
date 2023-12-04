//
//  Task.swift
//  ITMO_DZ_4
//
//  Created by StepanShimigonov  on 04.12.2023.
//

import Foundation

protocol Task {
    var priority: Int { get }

    func addDependency(_ task: Task)
    
    func getDependencies() -> any RandomAccessCollection<Task>
    
    func execute()
    
    func getId() -> UUID
}
