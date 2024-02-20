//
//  Task.swift
//  ITMO_DZ_4
//
//  Created by StepanShimigonov  on 04.12.2023.
//

import Foundation

class Job: Task {
    private let ID = UUID()
    let priority: Int
    private var dependencies: [Task] = []
    let task: () -> ()
    
    init(priority: Int, task: @escaping () -> ()) {
        self.priority = priority
        self.task = task
    }
    

    func addDependency(_ task: Task) {
        dependencies.append(task)
    }
    
    func getDependencies() -> any RandomAccessCollection<Task> {
        return dependencies
    }
    
    func getId() -> UUID { ID }
    
    func execute() {
        task()
    }
}
