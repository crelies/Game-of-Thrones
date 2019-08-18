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
                VStack {
                    Text(error.localizedDescription)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    
                    Button(action: {
                        self.presenter.didTriggerAction(.retry)
                    }) {
                        Text("Retry")
                    }.padding()
                }
            }, loadingStateView: {
                Text("Loading...")
            }, pagination: presenter.pagination)
            .navigationBarTitle("Houses")
        }
        .onAppear {
            self.presenter.didReceiveEvent(.viewAppears)
        }
        .onDisappear {
            self.presenter.didReceiveEvent(.viewDisappears)
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
