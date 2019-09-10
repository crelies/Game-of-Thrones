import AdvancedList
import Combine
import SwiftUI

protocol HouseListPresenterProtocol: class {
    associatedtype PaginationErrorView: View
    associatedtype PaginationLoadingView: View
    
    var listService: ListService { get }
    var pagination: AdvancedListPagination<PaginationErrorView, PaginationLoadingView> { get }
    func didReceiveEvent(_ event: HouseListEvent)
    func didTriggerAction(_ action: HouseListAction)
}

final class HouseListPresenter: NSObject, ObservableObject {
    private let dependencies: HouseListPresenterDependenciesProtocol
    private var interactor: HouseListInteractorProtocol
    private var getCurrentHousesCancellable: AnyCancellable?
    private var getNextHousesCancellable: AnyCancellable?
    
    let listService: ListService
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
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    init(dependencies: HouseListPresenterDependenciesProtocol,
         interactor: HouseListInteractorProtocol) {
        self.dependencies = dependencies
        self.interactor = interactor
        listService = ListService()
    }
}

extension HouseListPresenter: HouseListPresenterProtocol {
    func didReceiveEvent(_ event: HouseListEvent) {
        switch event {
            case .viewAppears:
                getCurrentHouses(isInitialLoading: true)
            case .viewDisappears:
                getCurrentHousesCancellable?.cancel()
                getNextHousesCancellable?.cancel()
                listService.listState = .items
                pagination.state = .idle
        }
    }

    func didTriggerAction(_ action: HouseListAction) {
        switch action {
            case .retry:
                getCurrentHouses(isInitialLoading: true)
        }
    }
}

extension HouseListPresenter {
    private func getCurrentHouses(isInitialLoading: Bool) {
        if isInitialLoading {
            listService.listState = .loading
        } else {
            pagination.state = .loading
        }
        
        getCurrentHousesCancellable = interactor.getCurrentHouses()
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
            switch completion {
                case .failure(let error):
                    if isInitialLoading {
                        self.listService.listState = .error(error)
                    } else {
                        self.pagination.state = .error(error)
                    }
                case .finished:
                    if isInitialLoading {
                        self.listService.listState = .items
                    } else {
                        self.pagination.state = .idle
                    }
            }
        }) { houseDataModels in
            let houseViewModels: [HouseViewModel] = houseDataModels.compactMap { houseDataModel in
                return HouseViewModel(url: houseDataModel.url,
                                      name: houseDataModel.name)
            }
            self.listService.appendItems(houseViewModels)
        }
    }
    
    private func getNextHouses() {
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
                
                let houseViewModels: [HouseViewModel] = houseDataModels.compactMap { houseDataModel in
                    return HouseViewModel(url: houseDataModel.url,
                                          name: houseDataModel.name)
                }
                self.listService.appendItems(houseViewModels)
            }
    }
}
