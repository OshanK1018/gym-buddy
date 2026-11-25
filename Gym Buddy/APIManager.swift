import Foundation

class APIManager {
    
    static let shared = APIManager()
    
    private init() { }
    
    private var apiKey: String? {
        guard let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist") else {
            print("Missing Secrets.plist. Copy Gym Buddy/Secrets.example.plist to Gym Buddy/Secrets.plist and set WORKOUTX_API_KEY.")
            return nil
        }
        
        guard let dict = NSDictionary(contentsOf: url),
              let key = dict["WORKOUTX_API_KEY"] as? String else {
            print("Secrets.plist is missing the WORKOUTX_API_KEY entry. Add your WorkoutX API key and rebuild.")
            return nil
        }
        
        let trimmed = key.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty || trimmed == "YOUR_WORKOUTX_API_KEY" {
            print("WORKOUTX_API_KEY is empty or still a placeholder. Set your WorkoutX API key in Gym Buddy/Secrets.plist and rebuild.")
            return nil
        }
        
        return trimmed
    }
    
    func fetchExercises(muscle: String, type: String, difficulty: String, completion: @escaping ([Exercise]) -> Void) {
        
        let bodyPart = muscle
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        guard !bodyPart.isEmpty else {
            print("No muscle entered")
            completion([])
            return
        }
        
        guard let apiKey = apiKey else {
            completion([])
            return
        }
        
        guard let url = URL(string: "https://api.workoutxapp.com/v1/exercises/bodyPart/\(bodyPart)") else {
            print("Invalid URL")
            completion([])
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "X-WorkoutX-Key")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Request error:", error.localizedDescription)
                completion([])
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code:", httpResponse.statusCode)
            }
            
            guard let data = data else {
                print("No data")
                completion([])
                return
            }
            
            do {
                let response = try JSONDecoder().decode(ExerciseResponse.self, from: data)
                completion(response.data)
            } catch {
                print("Decoding error:", error)
                completion([])
            }
        }
        
        task.resume()
    }
}
