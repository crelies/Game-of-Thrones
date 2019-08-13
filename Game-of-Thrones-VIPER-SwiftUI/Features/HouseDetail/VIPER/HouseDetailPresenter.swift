import Combine
import Foundation

protocol HouseDetailPresenterProtocol: class {
    var viewModel: HouseDetailViewModel { get }
    func didReceiveEvent(_ event: HouseDetailEvent)
    func didTriggerAction(_ action: HouseDetailAction)
}

final class HouseDetailPresenter: ObservableObject {
    private let dependencies: HouseDetailPresenterDependenciesProtocol
    private let interactor: HouseDetailInteractorProtocol
    private var getHouseCancellable: AnyCancellable?
    
    private(set) var viewModel: HouseDetailViewModel {
        didSet {
            objectWillChange.send()
        }
    }
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    init(dependencies: HouseDetailPresenterDependenciesProtocol,
         interactor: HouseDetailInteractorProtocol) {
        self.dependencies = dependencies
        self.interactor = interactor
        
        viewModel = HouseDetailViewModel()
    }
}

extension HouseDetailPresenter: HouseDetailPresenterProtocol {
    func didReceiveEvent(_ event: HouseDetailEvent) {
        switch event {
            case .viewAppears(let houseURL):
                getHouseCancellable = interactor.getHouse(atURL: houseURL)
                    .receive(on: RunLoop.main)
                    .sink(receiveCompletion: { completion in
                        debugPrint(completion)
                    }) { houseDataModel in
                        self.viewModel = HouseDetailViewModel(name: houseDataModel.name,
                                                              region: houseDataModel.region,
                                                              coatOfArms: houseDataModel.coatOfArms,
                                                              words: houseDataModel.words,
                                                              titles: houseDataModel.titles,
                                                              seats: houseDataModel.seats,
                                                              currentLord: houseDataModel.currentLord,
                                                              heir: houseDataModel.heir,
                                                              overlord: houseDataModel.overlord,
                                                              founded: houseDataModel.founded,
                                                              founder: houseDataModel.founder,
                                                              diedOut: houseDataModel.diedOut,
                                                              ancestralWeapons: houseDataModel.ancestralWeapons,
                                                              cadetBranches: houseDataModel.cadetBranches,
                                                              swornMembers: houseDataModel.swornMembers)
                    }
        }
    }

    func didTriggerAction(_ action: HouseDetailAction) {

    }
}