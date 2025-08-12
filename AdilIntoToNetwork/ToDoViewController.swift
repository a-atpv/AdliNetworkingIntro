import UIKit

class ToDoViewController: UIViewController {
    
    var tasks = [ToDoTaskModel]()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.cellIdentifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello!"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    lazy var textField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "enter Text"
        return textfield
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Set name", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getTasks()
        setupUI()
        
//        deleteName()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubViews(tableView, textField, button)
        setupConstraints()
    }
    
    func setupConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(600)
        }
        
        textField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(tableView.snp.bottom).offset(20)
            make.height.equalTo(40)
        }
        
        button.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.bottom.equalToSuperview().inset(20)
        }
    }

    @objc func buttonAction() {
        
        guard let name = textField.text else { return }
//        saveName(name)
        RealmManager.shared.createTodo(name: name, dueDate: Date())
        textField.text = ""
        getTasks()
    }
    
    private func getTasks() {
        guard let tasks = RealmManager.shared.getTasks() else { return }
        self.tasks = tasks
        
        tableView.reloadData()
    }
    
    private func saveName(_ name: String) {
        UserDefaults.standard.set(name, forKey: "UserName")
    }

    private func sayHello() {
        guard let name = UserDefaults.standard.object(forKey: "UserName") else { return }
        nameLabel.text = "Hello, \(name)!"
    }
    
    private func deleteName() {
        UserDefaults.standard.removeObject(forKey: "UserName")
    }
    
}


extension ToDoViewController: UITableViewDelegate, UITableViewDataSource, ToDoTableViewCellDelegate {
    
    func buttonTapped(at index: Int) {
        let task = tasks[index]
        RealmManager.shared.updateTaskStatus(name: task.name)
        getTasks()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Действие "Удалить"
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }
            let task = self.tasks[indexPath.row]
            RealmManager.shared.deleteTask(name: task.name)
            getTasks()
            completionHandler(true)
        }
        
        
        // Возвращаем оба действия
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false // отключаем "автосвайп"
        return configuration
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.cellIdentifier) as? ToDoTableViewCell else { return UITableViewCell() }
        let task = tasks[indexPath.row]
        cell.setUp(task: task)
        cell.delegate = self
        cell.index = indexPath.row
        return cell
    }
    
    
    
    
    
}
