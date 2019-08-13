import Foundation

struct HouseDetailViewModel {
    let name: String
    let region: String
    let coatOfArms: String
    let words: String
    let titles: [String]
    let seats: [String]
    let currentLord: URL?
    let heir: URL?
    let overlord: URL?
    let founded: String
    let founder: URL?
    let diedOut: String
    let ancestralWeapons: [String]
    let cadetBranches: [URL]
    let swornMembers: [URL]
    
    init(name: String,
         region: String,
         coatOfArms: String,
         words: String,
         titles: [String],
         seats: [String],
         currentLord: URL?,
         heir: URL?,
         overlord: URL?,
         founded: String,
         founder: URL?,
         diedOut: String,
         ancestralWeapons: [String],
         cadetBranches: [URL],
         swornMembers: [URL]) {
        self.name = name
        self.region = region
        self.coatOfArms = coatOfArms
        self.words = words
        self.titles = titles
        self.seats = seats
        self.currentLord = currentLord
        self.heir = heir
        self.overlord = overlord
        self.founded = founded
        self.founder = founder
        self.diedOut = diedOut
        self.ancestralWeapons = ancestralWeapons
        self.cadetBranches = cadetBranches
        self.swornMembers = swornMembers
    }
}

extension HouseDetailViewModel {
    init() {
        name = ""
        region = ""
        coatOfArms = ""
        words = ""
        titles = []
        seats = []
        currentLord = nil
        heir = nil
        overlord = nil
        founded = ""
        founder = nil
        diedOut = ""
        ancestralWeapons = []
        cadetBranches = []
        swornMembers = []
    }
}
