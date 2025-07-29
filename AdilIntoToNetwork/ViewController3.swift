import UIKit
import SnapKit
import Alamofire

class ViewController3: UIViewController {
    
    var currencies = [CurrencyModel]() {
        didSet {
            sortedCurrencies = currencies
        }
    }
    
    var sortedCurrencies = [CurrencyModel]()
    var isSorted = false
    
    lazy var sortButton: UIButton = {
        let button = UIButton()
        button.setTitle("✓", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(sortAction), for: .touchUpInside)
        return button
    }()
    

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
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(sortButton)
        setupConstraints()
    }
    
    // MARK: this is constraints setup
    private func setupConstraints() {
        sortButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.width.height.equalTo(40)
            make.top.equalToSuperview().offset(60)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(sortButton.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(20)
        }
        
    }
    
    private func getCurrencies() {
        
//        NetworkManager.shared.getCurrencies { currencies in
//            self.currencies = currencies
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
        
        let params: Parameters = ["vs_currency" : "usd"]
        AlamofireManager.shared.getRequest(url: "https://api.coingecko.com/api/v3/coins/markets", parameters: params) { (result: Result<[CurrencyModel], AFError>) in
            switch result {
            case .success(let success):
                self.currencies = success
                self.tableView.reloadData()
            case .failure(let failure):
                print("Error: \(failure.localizedDescription)")
            }
        }
    }
    
    @objc func sortAction() {
        if isSorted {
            sortedCurrencies = currencies
        }else {
            sortedCurrencies = currencies.sorted(by: { $0.symbol < $1.symbol })
        }
        
        isSorted.toggle()
        tableView.reloadData()
    }
}

extension ViewController3: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sortedCurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let currency = sortedCurrencies[indexPath.row]
        cell.textLabel?.text = "\(currency.symbol) \(currency.current_price)"
        return cell
    }
    
    
    
}
