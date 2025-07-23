import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var currencies = [CurrencyModel]()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.register(Cell.self, forCellReuseIdentifier: Cell.cellIdentifier)
//        tableView.separatorStyle = .none
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrencies()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupConstraints()
    }
    
    // MARK: this is constraints setup
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.verticalEdges.equalToSuperview().inset(20)
        }
    }
    
    private func getCurrencies() {
        NetworkManager.shared.getCurrencies { currencies in
            self.currencies = currencies
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let currency = currencies[indexPath.row]
        cell.textLabel?.text = "\(currency.symbol) \(currency.current_price)"
        return cell
    }
    
    
    
}
