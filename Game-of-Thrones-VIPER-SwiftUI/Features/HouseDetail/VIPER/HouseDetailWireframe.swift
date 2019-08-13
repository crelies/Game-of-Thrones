import Foundation

protocol HouseDetailWireframeProtocol {
    static func makePresenter() -> HouseDetailPresenter
}

struct HouseDetailWireframe: HouseDetailWireframeProtocol {
    static func makePresenter() -> HouseDetailPresenter {
        let interactorDependencies = HouseDetailInteractorDependencies()
        let interactor = HouseDetailInteractor(dependencies: interactorDependencies)

        let presenterDependencies = HouseDetailPresenterDependencies()
        let presenter = HouseDetailPresenter(dependencies: presenterDependencies,
                                             interactor: interactor)
        return presenter
    }
}
