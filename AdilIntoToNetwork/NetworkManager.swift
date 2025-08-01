import UIKit


class NetworkManager {
    static let shared = NetworkManager()
    fileprivate let data = "sdfsdf"
    
    func getCurrencies(completion: @escaping ([CurrencyModel]) -> ()) {
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error {
                print(error)
            }
            
            guard let data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                let currencies = try decoder.decode([CurrencyModel].self, from: data)
                completion(currencies)
            } catch {
                print(error)
            }
            
        }.resume()
    }
    
}

