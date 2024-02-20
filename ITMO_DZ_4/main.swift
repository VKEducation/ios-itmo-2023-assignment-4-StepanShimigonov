import Foundation


let ff = ThreadSafeArray<Int>()

for i in 1...100 {
    DispatchQueue.global(qos: .userInitiated).async {
        ff.append(i)
        print(ff.toString())
    }
}


let TM = TaskManager()

let group = DispatchGroup()

for i in 1...100 {
    group.enter()
    DispatchQueue.global(qos: .userInitiated).async {
        let pr = Int.random(in: 1...20)
        TM.add(task: Job(priority: pr) {
            print("Running task number_\(i), with priority: \(pr)")
        })
        group.leave()
    }
}

group.enter()
DispatchQueue.global(qos: .userInitiated).async {
    let job_1 = Job(priority: 1){
        print("in 1")
    }
    let job_2 = Job(priority: 1){
        print("in 2")
    }
    let job_3 = Job(priority: 1){
        print("in 3")
    }
    job_1.addDependency(job_2)
    job_2.addDependency(job_3)
    job_3.addDependency(job_1)
    TM.add(task: job_1)
    TM.add(task: job_2)
    TM.add(task: job_3)
    group.leave()
}

group.notify(queue: .main) {
    TM.start()
}


RunLoop.current.run()
