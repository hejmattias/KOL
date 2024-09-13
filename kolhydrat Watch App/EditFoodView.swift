import SwiftUI

struct EditFoodView: View {
    @ObservedObject var plate: Plate
    @State private var selectedGrams: Int
    var item: FoodItem

    // Initialisera med FoodItem
    init(plate: Plate, item: FoodItem) {
        self._plate = ObservedObject(initialValue: plate)
        self.item = item
        self._selectedGrams = State(initialValue: Int(item.grams))
    }

    @Environment(\.presentationMode) var presentationMode // Deklarera presentationMode här

    var body: some View {
        VStack {
            Text(item.name)
                .font(.headline)

            Picker("Antal gram", selection: $selectedGrams) {
                ForEach(0..<500, id: \.self) { grams in
                    Text("\(grams) gram").tag(grams)
                }
            }
            .labelsHidden()
            .frame(maxHeight: 100)

            Button("Uppdatera") {
                var updatedItem = item
                updatedItem.grams = Double(selectedGrams)
                if let index = plate.items.firstIndex(where: { $0.id == item.id }) {
                    plate.items[index] = updatedItem
                }
                plate.saveToUserDefaults()
                presentationMode.wrappedValue.dismiss() // Använd presentationMode här
            }
        }
        .navigationTitle("Redigera \(item.name)")
    }
}

struct EditFoodView_Previews: PreviewProvider {
    static var previews: some View {
        EditFoodView(plate: Plate(), item: FoodItem(name: "Äpple", carbsPer100g: 11.4, grams: 0))
    }
}
