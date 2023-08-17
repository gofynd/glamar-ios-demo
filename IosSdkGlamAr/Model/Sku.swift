import Foundation

// Struct to represent a SKU (Stock Keeping Unit) with product data
struct Sku: Codable, Hashable {
    
    let id: Int         // SKU ID
    let name: String    // Name of the SKU
    let category: String    // Category of the SKU
    let pattern: [String: [String: QuantumValue?]]    // Dictionary to represent pattern data
    let barcode: String?    // Optional barcode information
    let imageUrl: String?    // Optional URL for the image of the SKU
}

// Enum to represent different types of values for the pattern in the Sku struct
enum QuantumValue: Codable, Hashable {
    case int(Int)       // Integer value
    case string(String)    // String value
    case float(Float)    // Float value
    case double(Double)    // Double value
    
    // Custom decoding to handle different types of values in the JSON
    init(from decoder: Decoder) throws {
        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(int)
            return
        }
        
        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }
        
        if let float = try? decoder.singleValueContainer().decode(Float.self) {
            self = .float(float)
            return
        }
        
        if let double = try? decoder.singleValueContainer().decode(Double.self) {
            self = .double(double)
            return
        }
        
        throw QuantumError.missingValue
    }
    
    // Error enum to handle missing values while decoding
    enum QuantumError: Error {
        case missingValue
    }
}

// Extension to QuantumValue to provide a stringValue() method for conversion to String
extension QuantumValue {
    func stringValue() -> String {
        // Return the value as a String based on the type
        switch self {
        case .int(let value): return String(value)
        case .string(let value): return value
        case .float(let value): return String(value)
        case .double(let value): return String(value)
        }
    }
}
