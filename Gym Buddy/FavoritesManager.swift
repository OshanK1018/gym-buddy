import Foundation

class FavoritesManager {
    
    static let shared = FavoritesManager()
    
    private init() { }
    
    private var fileURL: URL {
        let documentsFolder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsFolder.appendingPathComponent("favorites.plist")
    }
    
    func saveFavorites(_ exercises: [Exercise]) {
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(exercises)
            try data.write(to: fileURL)
        } catch {
            print("Error saving favorites: \(error)")
        }
    }
    
    func loadFavorites() -> [Exercise] {
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = PropertyListDecoder()
            let favorites = try decoder.decode([Exercise].self, from: data)
            return favorites
        } catch {
            print("Error loading favorites: \(error)")
            return []
        }
    }
}
