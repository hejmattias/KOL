import SwiftUI

struct MainView: View {
    @StateObject private var plate = Plate()
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: PlateView(plate: plate)) {
                    Text("Visa tallriken")
                }
                .padding()
                
                NavigationLink(destination: FoodListView(plate: plate)) {
                    Text("Lägg till på tallriken")
                }
                .padding()
            }
            .navigationTitle("Huvudmeny")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
