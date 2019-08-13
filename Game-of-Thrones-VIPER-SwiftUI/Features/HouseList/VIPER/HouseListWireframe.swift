import Foundation

protocol HouseListWireframeProtocol {
    static func makePresenter() -> HouseListPresenter
}

struct HouseListWireframe: HouseListWireframeProtocol {
    static func makePresenter() -> HouseListPresenter {
        let interactorDependencies = HouseListInteractorDependencies()
        let interactor = HouseListInteractor(dependencies: interactorDependencies)

        let presenterDependencies = HouseListPresenterDependencies()
        let presenter = HouseListPresenter(dependencies: presenterDependencies,
                                           interactor: interactor)
        return presenter
    }
}
