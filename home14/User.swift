
import Foundation


enum Sex: String {
    case male
    case female
    case another
    
    func description () -> String {
        switch self {
        case .female:
            return "Female"
        case .male:
            return "Male"
        case .another:
            return "Another"
        }
    }
}

struct User {
    var name: String
    var secondName: String
    var sex: Sex
}
