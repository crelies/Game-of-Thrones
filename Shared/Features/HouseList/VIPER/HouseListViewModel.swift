import AdvancedList
import Combine
import SwiftUI

final class HouseListViewModel: ObservableObject {
    private var interactor: HouseListInteractorProtocol
    private var getCurrentHousesCancellable: AnyCancellable?
    private var getNextHousesCancellable: AnyCancellable?

    @Published private(set) var houseModels: [HouseMetadataModel] = []
    @Published var listState: ListState = .items
    private(set) lazy var pagination: AdvancedListPagination<AnyView, AnyView> = {
        .thresholdItemPagination(errorView: { error in
            AnyView(
                VStack {
                    Text(error.localizedDescription)
                        .lineLimit(nil)
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        self.getCurrentHouses(isInitialLoading: false)
                    }) {
                        Text("Retry")
                    }.padding()
                }
            )
        }, loadingView: {
            AnyView(
                VStack {
                    Divider()
                    Text("Loading...")
                }
            )
        }, offset: interactor.pageSize - 1, shouldLoadNextPage: {
            self.getNextHouses()
        }, state: .idle)
    }()

    init() {
        let interactorDependencies = HouseListInteractorDependencies()
        self.interactor = HouseListInteractor(dependencies: interactorDependencies)
    }
}

extension HouseListViewModel {
    func loadHouses() {
        getCurrentHouses(isInitialLoading: true)
    }

    func retry() {
        getCurrentHouses(isInitialLoading: true)
    }
}

private extension HouseListViewModel {
    func getCurrentHouses(isInitialLoading: Bool) {
        if isInitialLoading {
            listState = .loading
        } else {
            pagination.state = .loading
        }
        
        getCurrentHousesCancellable = interactor.getCurrentHouses()
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
            switch completion {
                case .failure(let error):
                    if isInitialLoading {
                        self.listState = .error(error)
                    } else {
                        self.pagination.state = .error(error)
                    }
                case .finished:
                    if isInitialLoading {
                        self.listState = .items
                    } else {
                        self.pagination.state = .idle
                    }
            }
        }) { houseDataModels in
            let houseModels: [HouseMetadataModel] = houseDataModels.compactMap { houseDataModel in
                return HouseMetadataModel(
                    url: houseDataModel.url,
                    name: houseDataModel.name
                )
            }
            self.houseModels.append(contentsOf: houseModels)
        }
    }
    
    func getNextHouses() {
        guard !interactor.allHousesLoaded, pagination.state == .idle else {
            return
        }
        
        pagination.state = .loading
        
        getNextHousesCancellable = interactor.getNextHouses()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .failure(let error):
                        if let interactorError = error as? HouseListInteractorError, interactorError == .allHousesLoaded {
                            self.pagination.state = .idle
                        } else {
                            self.pagination.state = .error(error)
                        }
                    case .finished:
                        self.pagination.state = .idle
                }
            }) { houseDataModels in
                self.interactor.allHousesLoaded = houseDataModels.count < self.interactor.pageSize
                
                let houseModels: [HouseMetadataModel] = houseDataModels.compactMap { houseDataModel in
                    return HouseMetadataModel(
                        url: houseDataModel.url,
                        name: houseDataModel.name
                    )
                }
                self.houseModels.append(contentsOf: houseModels)
            }
    }
}
