import AdvancedList
import Combine
import SwiftUI

protocol HouseListPresenterProtocol: class {
    associatedtype PaginationLoadingView: View
    
    var listService: ListService { get }
    var pagination: AdvancedListPagination<PaginationLoadingView> { get }
    var viewModel: HouseListViewModel { get }
    func didReceiveEvent(_ event: HouseListEvent)
    func didTriggerAction(_ action: HouseListAction)
    func didReachThresholdItem()
}

final class HouseListPresenter: ObservableObject {
    private let dependencies: HouseListPresenterDependenciesProtocol
    private let interactor: HouseListInteractorProtocol
    private var getCurrentHousesCancellable: AnyCancellable?
    private var getNextHousesCancellable: AnyCancellable?
    
    let listService: ListService
    private(set) lazy var pagination: AdvancedListPagination<TupleView<(Divider, Text)>> = {
        .thresholdItemPagination(loadingView: {
            Divider()
            Text("Loading...")
        }, offset: interactor.pageSize - 1, shouldLoadNextPage: {
            self.didReachThresholdItem()
        }, isLoading: false)
    }()
    
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
        listService = ListService()
        viewModel = HouseListViewModel()
    }
}

extension HouseListPresenter: HouseListPresenterProtocol {
    func didReceiveEvent(_ event: HouseListEvent) {
        switch event {
            case .viewAppears:
                listService.listState = .loading
                
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
                        self.listService.appendItems(houseViewModels)
                        self.listService.listState = .items
                    }
            case .viewDisappears:
                getCurrentHousesCancellable?.cancel()
                getNextHousesCancellable?.cancel()
        }
    }

    func didTriggerAction(_ action: HouseListAction) {

    }
    
    func didReachThresholdItem() {
        pagination.isLoading = true
        
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
                self.listService.appendItems(houseViewModels)
                self.pagination.isLoading = false
            }
    }
}
