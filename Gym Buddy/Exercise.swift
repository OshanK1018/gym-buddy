import Foundation

struct ExerciseResponse: Codable {
    let total: Int
    let count: Int
    let data: [Exercise]
}

struct Exercise: Codable {
    let id: String
    let name: String
    let bodyPart: String
    let equipment: String
    let target: String
    let secondaryMuscles: [String]
    let instructions: [String]
    let gifUrl: String?
    let category: String
    let difficulty: String
    let description: String
    
    var muscle: String {
        return target
    }
    
    var type: String {
        return category
    }
    
    var difficultyText: String {
        return difficulty
    }
    
    var instructionsText: String {
        return instructions.enumerated().map { index, step in
            "\(index + 1). \(step)"
        }.joined(separator: "\n\n")
    }
}

extension String {
    func shortened(to length: Int) -> String {
        if self.count > length {
            let index = self.index(self.startIndex, offsetBy: length)
            return String(self[..<index]) + "..."
        } else {
            return self
        }
    }
}
