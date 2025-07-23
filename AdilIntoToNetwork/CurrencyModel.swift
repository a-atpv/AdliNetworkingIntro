import Foundation

struct CurrencyModel: Codable {
    var id: String
    var symbol: String
    var current_price: Double
}




struct OffersResponce: Codable {
    var count: Int
    var data: [OffersModel]
}


struct OffersModel: Codable {
    var id: Int
    var postId: Int
    var initiator: InitiatorModel
}

struct InitiatorModel: Codable {
    var id: Int
}
