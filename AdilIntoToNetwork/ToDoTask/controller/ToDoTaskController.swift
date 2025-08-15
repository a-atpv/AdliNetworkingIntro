import Foundation


protocol ToDoTaskControllerProtocol {
    
    func viewDidLoad()
    func createTapped(_ name: String)
    func deleteTapped(_ name: String)
    func doneTapped(_ name: String)
    
}


class ToDoTaskController: ToDoTaskControllerProtocol {
    var view: ToDoTaskView?
    
    func viewDidLoad() {
       getTasks()
    }
    func createTapped(_ name: String) {
        
        RealmManager.shared.createTodo(name: name, dueDate: Date())
        getTasks()
    }
    
    
    func doneTapped(_ name: String) {
        updateTaskStatus(name: name)
        getTasks()
    }
    
    
    func deleteTapped(_ name: String) {
        deleteTask(name: name)
        getTasks()
    }
    

 
    
    
    private func getTasks() {
        let tasks = RealmManager.shared.getTasks() ?? []
        
        
        view?.showTasks(tasks)
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
