import ListPagination
import SwiftUI

protocol HouseListViewProtocol: HouseListProtocol {
    
}

struct HouseListView: View {
    @ObservedObject private var presenter = HouseListWireframe.makePresenter()
    weak var delegate: HouseListDelegateProtocol?
    
    var body: some View {
        NavigationView {
            List(presenter.viewModel.houses) { house in
                VStack {
                    NavigationLink(destination: HouseDetailView(url: house.url)) {
                        Text(house.name)
                    }
                    
                    if self.presenter.isLoading && self.presenter.viewModel.houses.isLastItem(house) {
                        Divider()
                        Text("Loading...")
                    }
                }.onAppear {
                    if self.presenter.viewModel.houses.isThresholdItem(offset: 5, item: house) {
                        self.presenter.didReachThresholdItem()
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
