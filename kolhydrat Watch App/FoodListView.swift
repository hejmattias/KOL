import SwiftUI

struct FoodListView: View {
    @ObservedObject var plate: Plate
    
    let foodList = [
        FoodItem(name: "Äpple", carbsPer100g: 11.4, grams: 0),
        FoodItem(name: "Banan", carbsPer100g: 22.8, grams: 0),
        // Lägg till fler livsmedel här
    ]
    
    var body: some View {
        List {
            ForEach(foodList, id: \.id) { food in
                NavigationLink(destination: FoodDetailView(plate: plate, food: food)) {
                    Text(food.name)
                }
            }
        }
        .navigationTitle("Livsmedel")
    }
}

struct FoodListView_Previews: PreviewProvider {
    static var previews: some View {
        FoodListView(plate: Plate())
    }
}
