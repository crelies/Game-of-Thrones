import Combine
import Foundation

final class HouseDetailViewModel: ObservableObject {
    private let apiService: APIService
    private var getHouseCancellable: AnyCancellable?
    private var loaded = false
    private var currentHouseURL: URL?

    @Published private(set) var model: HouseModel
    @Published private(set) var isLoading = false

    init() {
        apiService = APIService()
        model = HouseModel()
    }
}

extension HouseDetailViewModel {
    func loadHouse(atURL url: URL) {
        guard !isLoading && (!loaded || currentHouseURL != url) else {
            return
        }

        isLoading = true

        getHouseCancellable = getHouse(atURL: url)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                debugPrint(completion)
            }) { houseDataModel in
                self.model = HouseModel(
                    name: houseDataModel.name,
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
                    swornMembers: houseDataModel.swornMembers
                )
                self.isLoading = false
                self.loaded = true
            }
    }
}

private extension HouseDetailViewModel {
    func getHouse(atURL url: URL) -> AnyPublisher<HouseDataModel, Error> {
        return apiService.getHouse(atURL: url)
            .tryMap { houseResponseModel in
                return try houseResponseModel.houseDataModel()
            }.eraseToAnyPublisher()
    }
}
