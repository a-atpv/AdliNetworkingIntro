import Foundation
import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    let realm = try! Realm()
    
    func createTodo(name: String, dueDate: Date) {
        let task = ToDoTaskModel()
        task.due = dueDate
        task.name = name
        task.isDone = false
        
//        realm.add(task) this will not save data
        try! realm.write {
            
            realm.add(task)
        }
    }
    
    func getTasks() -> [ToDoTaskModel]? {
        let tasks = realm.objects(ToDoTaskModel.self)
        return tasks.map { task in task }
        
    }
    
    
    func updateTaskStatus(name: String) {
        let tasks = realm.objects(ToDoTaskModel.self)
        let task = tasks.filter { $0.name == name }.first
        guard let task else { return }
        
        try! realm.write({
            task.isDone.toggle()
        })
    }
    
    func deleteTask(name: String) {
        let tasks = realm.objects(ToDoTaskModel.self)
        let task = tasks.filter { $0.name == name }.first
        guard let task else { return }
        
        try! realm.write({
            realm.delete(task)
        })
    }
    
    // CRUD
    // create
    // read
    // update
    // delete
}
