import Foundation

// FoodItem-modellen som representerar ett livsmedel
struct FoodItem: Identifiable, Codable, Hashable {
    let id = UUID()  // Unik identifierare för varje livsmedel
    let name: String  // Namn på livsmedlet
    let carbsPer100g: Double  // Kolhydrater per 100 gram
    var grams: Double  // Hur många gram som är tillagt
    var totalCarbs: Double {  // Totalt kolhydratinnehåll
        return (carbsPer100g / 100) * grams
    }
}

// Plate-klassen som hanterar tallrikens innehåll
class Plate: ObservableObject {
    @Published var items: [FoodItem] = []

    // Lägg till ett livsmedel på tallriken
    func addItem(_ item: FoodItem) {
        // Kontrollera om livsmedlet redan finns i tallriken
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item  // Uppdatera befintligt livsmedel
        } else {
            items.append(item)  // Lägg till nytt livsmedel
        }
        saveToUserDefaults()
    }
    
    // Töm tallriken
    func emptyPlate() {
        items.removeAll()
        saveToUserDefaults()
    }
    
    // Spara tallrikens innehåll till UserDefaults
    func saveToUserDefaults() {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: "plateItems")
        }
    }
    
    // Ladda tallrikens innehåll från UserDefaults
    func loadFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: "plateItems"),
           let savedItems = try? JSONDecoder().decode([FoodItem].self, from: data) {
            items = savedItems
        }
    }
}
