import Foundation

class TaskManager {
    private var tasks = ThreadSafeArray<Task>()
    private let rwlock = RWLock()

    func add(task: Task) -> Void {
        tasks.append(task)
    }
    
    func start() {
        rwlock.writeLock()
        defer { rwlock.unlock() }
        tasks.sort{$0.priority >= $1.priority}
        let dependencySort = topSort(tasks)
        dependencySort.forEach {$0.execute()}
    }
    
    private func topSort(_ tasks: ThreadSafeArray<Task>) -> ThreadSafeArray<Task> {
        var res = ThreadSafeArray<Task>()
        var stack = Set<UUID>()
        var marked = Set<UUID>()
        
        for task in tasks {
            if !marked.contains(task.getId()) {
                dfs(task, &marked, &stack, &res)
            }
        }
        
        return res
    }
    
    private func dfs(_ task: Task, _ marked: inout Set<UUID>, _ stack: inout Set<UUID>, _ res: inout ThreadSafeArray<Task>) {
        if (stack.contains(task.getId())) {
            fatalError("dependency cycle with task: \(task)")
        }
        
        if (marked.contains(task.getId())) {
            return
        }
        
        marked.insert(task.getId())
        stack.insert(task.getId())
        
        for dependency in task.getDependencies() {
            dfs(dependency, &marked, &stack, &res)
        }
        
        stack.remove(task.getId())
        res.append(task)
    }
    
    
    
}
