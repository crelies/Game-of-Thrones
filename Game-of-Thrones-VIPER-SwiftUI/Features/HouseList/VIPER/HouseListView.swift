import SwiftUI

protocol HouseListViewProtocol: HouseListProtocol {
    
}

struct HouseListView: View {
    @ObservedObject private var presenter = HouseListWireframe.makePresenter()
    weak var delegate: HouseListDelegateProtocol?
    
    var body: some View {
        NavigationView {
            List(presenter.viewModel.houses, id: \.name) { house in
                NavigationLink(destination: HouseDetailView(url: house.url)) {
                    Text(house.name)
                }.onAppear {
                    if self.presenter.isEndOfListReached(house) {
                        self.presenter.didReachEndOfList()
                    }
                }
            }.navigationBarTitle("Houses")
        }
        .onAppear {
            self.presenter.didReceiveEvent(.viewAppears)
        }
    }
}

extension HouseListView: HouseListViewProtocol {
    
}

extension HouseListView: HouseListProtocol {
    
}

#if DEBUG
struct HouseListView_Previews: PreviewProvider {
    static var previews: some View {
        HouseListView()
    }
}
#endif
