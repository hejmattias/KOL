import SwiftUI

struct PlateView: View {
    @ObservedObject var plate: Plate
    @State private var showClearButton = false
    @State private var fadeText: String?
    @State private var fadeIn = false
    @State private var fadeOut = false

    var totalCarbs: Double {
        plate.items.reduce(0) { $0 + $1.totalCarbs }
    }

    var body: some View {
        VStack {
            if fadeIn {
                Text(fadeText ?? "")
                    .font(.headline)
                    .transition(.opacity)
                    .onAppear {
                        withAnimation(Animation.easeIn(duration: 1)) {
                            fadeIn = true
                        }
                    }
                    .onDisappear {
                        withAnimation(Animation.easeOut(duration: 1)) {
                            fadeIn = false
                        }
                    }
            }

            Text("Totalt kolhydrater: \(totalCarbs, specifier: "%.1f") g")
                .font(.headline)
                .padding()

            List {
                ForEach(plate.items) { item in
                    NavigationLink(destination: EditFoodView(plate: plate, item: item)) {
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("\(item.grams, specifier: "%.1f") g")
                        }
                    }
                }
                .onDelete(perform: deleteItems) // Använd deleteItems här
            }
            .onAppear {
                showClearButton = !plate.items.isEmpty
            }
            .onChange(of: plate.items) { newItems in
                showClearButton = !newItems.isEmpty
            }
            
            if showClearButton {
                Button("Töm tallriken") {
                    plate.emptyPlate()
                }
                .padding()
            }
        }
        .navigationTitle("Tallriken")
        .onChange(of: plate.items) { newItems in
            if !newItems.isEmpty {
                fadeText = "Lagt till på tallriken"
                withAnimation {
                    fadeIn = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        fadeIn = false
                    }
                }
            }
        }
    }

    private func deleteItems(at offsets: IndexSet) {
        plate.items.remove(atOffsets: offsets)
    }
}

struct PlateView_Previews: PreviewProvider {
    static var previews: some View {
        PlateView(plate: Plate())
    }
}
