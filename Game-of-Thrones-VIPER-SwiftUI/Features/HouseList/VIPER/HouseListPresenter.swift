import Combine
import Foundation

protocol HouseListPresenterProtocol: class {
    var viewModel: HouseListViewModel { get }
    func didReceiveEvent(_ event: HouseListEvent)
    func didTriggerAction(_ action: HouseListAction)
    func isEndOfListReached(_ house: HouseViewModel) -> Bool
    func didReachEndOfList()
}

final class HouseListPresenter: ObservableObject {
    private let dependencies: HouseListPresenterDependenciesProtocol
    private let interactor: HouseListInteractorProtocol
    private var getCurrentHousesCancellable: AnyCancellable?
    private var getNextHousesCancellable: AnyCancellable?
    
    private(set) var viewModel: HouseListViewModel {
        didSet {
            objectWillChange.send()
        }
    }
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    init(dependencies: HouseListPresenterDependenciesProtocol,
         interactor: HouseListInteractorProtocol) {
        self.dependencies = dependencies
        self.interactor = interactor
        
        viewModel = HouseListViewModel()
    }
}

extension HouseListPresenter: HouseListPresenterProtocol {
    func didReceiveEvent(_ event: HouseListEvent) {
        switch event {
            case .viewAppears:
                getCurrentHousesCancellable = interactor.getCurrentHouses()
                    .receive(on: RunLoop.main)
                    .sink(receiveCompletion: { completion in
                        debugPrint(completion)
                    }) { houseDataModels in
                        let houseViewModels: [HouseViewModel] = houseDataModels.compactMap { houseDataModel in
                            return HouseViewModel(url: houseDataModel.url,
                                                  name: houseDataModel.name)
                        }
                        self.viewModel.houses.append(contentsOf: houseViewModels)
                    }
        }
    }

    func didTriggerAction(_ action: HouseListAction) {

    }
    
    func isEndOfListReached(_ house: HouseViewModel) -> Bool {
        guard !viewModel.houses.isEmpty else {
            return true
        }
        let lastIndex = viewModel.houses.count - 1
        // TODO: use identifier
        let houseIndex = viewModel.houses.firstIndex(where: { $0.name == house.name })
        return lastIndex == houseIndex
    }
    
    func didReachEndOfList() {
        getNextHousesCancellable = interactor.getNextHouses()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                debugPrint(completion)
            }) { houseDataModels in
                let houseViewModels: [HouseViewModel] = houseDataModels.compactMap { houseDataModel in
                    return HouseViewModel(url: houseDataModel.url,
                                          name: houseDataModel.name)
                }
                self.viewModel.houses.append(contentsOf: houseViewModels)
            }
    }
}
