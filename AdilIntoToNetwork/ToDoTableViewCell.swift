import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    
    static let cellIdentifier = "ToDoTableViewCell"
    var task: ToDoTaskModel?
    var delegate: ToDoTableViewCellDelegate?
    var index: Int = 0
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "description"
        label.textColor = .black

        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "checkmark.square") // "square"
        button.setImage(image, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(someAction), for: .touchUpInside)
        return button
    }()
    
    
    @objc func someAction() {
        print("task is done")
    
        delegate?.buttonTapped(at: index)
    }
    
    func setUp(task: ToDoTaskModel) {
        self.task = task
        nameLabel.text = task.name
        descriptionLabel.text = task.due.ISO8601Format()
        let imageName = task.isDone ? "checkmark.square" : "square"
        let image = UIImage(systemName: imageName)
        button.setImage(image, for: .normal)
    }

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(button)
        
        
        nameLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(16)
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
        }
        
        button.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


protocol ToDoTableViewCellDelegate {
    func buttonTapped(at index: Int)
}
