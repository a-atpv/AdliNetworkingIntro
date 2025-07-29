import Foundation
import Alamofire

final class AlamofireManager {
    
    static let shared = AlamofireManager()
    
    func getRequest<T:Codable>(url: String, parameters: Parameters, completion: @escaping(Result<T, AFError>) -> ()) {
        
        AF.request(url, method: .get, parameters: parameters)
            .responseDecodable(of: T.self) { response in
                completion(response.result)
            }
    }
    
}



//MARK: -Access levels

//open
//public
//internal
//fileprivate
//private


