import SwiftUI

struct HouseListScreen: View {
    @ObservedObject var viewModel: HouseListViewModel
    @Binding var selectedHouse: HouseMetadataModel?

    var body: some View {
        NavigationView {
            List(selection: $selectedHouse) {
                ForEach(viewModel.houseModels) { houseModel in
                    Label(houseModel.name, systemImage: "house").tag(houseModel)
                }
            }
            .navigationTitle("Houses")
        }
        .onAppear(perform: viewModel.loadHouses)
    }
}

#if DEBUG
struct HouseListScreen_Previews: PreviewProvider {
    static var previews: some View {
        HouseListScreen(viewModel: .init(), selectedHouse: .constant(nil))
    }
}
#endif
