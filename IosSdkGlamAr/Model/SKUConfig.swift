import Foundation

// Struct representing the configuration of a SKU (Stock Keeping Unit)
struct SKUConfig: Codable {
    let config: Config
    let hash: String
    let requestId: String
}

// Struct representing the configuration details of a SKU
struct Config: Codable {
    let id: Int // SKU ID
    let categoryName: String // Category name for the SKU
    let name: String // Name of the SKU
    let baseAsset: String? // Base asset for the SKU (optional)
    let pattern: [[String: QuantumValue]] // Pattern details of the SKU (array of dictionaries with String keys and QuantumValue values)
    let imageUrl: String? // Image URL for the SKU (optional)
}




