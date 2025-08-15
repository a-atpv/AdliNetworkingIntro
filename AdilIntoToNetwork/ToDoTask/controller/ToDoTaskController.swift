import Foundation


protocol ToDoTaskControllerProtocol {
    
    func viewDidLoad()
//    func createTapped()
//    func tapped()
//    func doneTapped()
    
}


class ToDoTaskController: ToDoTaskControllerProtocol {
    
    var view: ToDoTaskView?
    
    func viewDidLoad() {
        let tasks = getTasks()
        view?.showTasks(tasks)
    }
    
    
    private func getTasks() -> [ToDoTaskModel] {
        guard let tasks = RealmManager.shared.getTasks() else { return [] }
        
        return tasks
    }
    
    
    private func updateTaskStatus(name: String) {
        RealmManager.shared.updateTaskStatus(name: name)
    }
    
    private func deleteTask(name: String) {
        RealmManager.shared.deleteTask(name: name)
    }
    
    private func createTask(name: String) {
        RealmManager.shared.createTodo(name: name, dueDate: Date())
    }
    
}
