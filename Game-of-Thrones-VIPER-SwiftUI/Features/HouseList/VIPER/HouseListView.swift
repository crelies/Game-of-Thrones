import AdvancedList
import SwiftUI

protocol HouseListViewProtocol: HouseListProtocol {
    
}

struct HouseListView: View {
    @ObservedObject private var presenter = HouseListWireframe.makePresenter()
    weak var delegate: HouseListDelegateProtocol?
    
    var body: some View {
        NavigationView {
            AdvancedList(listService: presenter.listService, emptyStateView: {
                Text("No houses")
            }, errorStateView: { error in
                Text(error.localizedDescription)
            }, loadingStateView: {
                Text("Loading...")
            }, pagination: presenter.pagination)
            .navigationBarTitle("Houses")
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
