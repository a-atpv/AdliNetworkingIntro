import RealmSwift
import Foundation


class ToDoTaskModel: Object {
    
    @Persisted var name: String
    @Persisted var due: Date
    @Persisted var isDone: Bool
    
}
