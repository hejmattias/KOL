import SwiftUI

struct FoodDetailView: View {
    @ObservedObject var plate: Plate
    @State private var selectedGrams: Int = 0
    var food: FoodItem
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Text(food.name)
                .font(.headline)
            
            Picker("Antal gram", selection: $selectedGrams) {
                ForEach(0..<500, id: \.self) { grams in
                    Text("\(grams) gram").tag(grams)
                }
            }
            .labelsHidden()
            .frame(maxHeight: 100)
            
            Button("Lägg till på tallriken") {
                var selectedFood = food
                selectedFood.grams = Double(selectedGrams)
                plate.addItem(selectedFood)
                showAlert = true
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Tillagd"), message: Text("\(food.name) har lagts till på tallriken"), dismissButton: .default(Text("OK")))
            }
        }
        .navigationTitle(food.name)
        @Environment(\.presentationMode) var presentationMode
    }
}
