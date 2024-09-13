import SwiftUI

struct ContentView: View {
    @StateObject private var plate = Plate()
    @State private var selectedFood: FoodItem?

    let foodList = [
        FoodItem(name: "Äpple", carbsPer100g: 11.4, grams: 0),
        FoodItem(name: "Banan", carbsPer100g: 22.8, grams: 0),
        // Lägg till fler livsmedel här
    ]

    var body: some View {
        NavigationStack {
            List(foodList) { food in
                Button(action: {
                    selectedFood = food
                }) {
                    Text(food.name)
                }
                .navigationDestination(for: FoodItem.self) { food in
                    FoodDetailView(plate: plate, food: food)
                }
            }
            .navigationTitle("Livsmedel")
            .navigationDestination(isPresented: .constant(selectedFood != nil)) {
                PlateView(plate: plate)
            }
        }
        .onAppear {
            plate.loadFromUserDefaults()
        }
    }
}
