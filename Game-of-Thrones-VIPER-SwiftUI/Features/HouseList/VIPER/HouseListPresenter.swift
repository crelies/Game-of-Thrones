import Combine
import Foundation

protocol HouseListPresenterProtocol: class {
    var viewModel: HouseListViewModel { get }
    var isLoading: Bool { get }
    func didReceiveEvent(_ event: HouseListEvent)
    func didTriggerAction(_ action: HouseListAction)
    func didReachThresholdItem()
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
    
    private(set) var isLoading: Bool = false
    
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
    
    func didReachThresholdItem() {
        isLoading = true
        
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
                
                self.isLoading = false
            }
    }
}
