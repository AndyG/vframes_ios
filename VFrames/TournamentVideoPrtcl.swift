import Foundation

public protocol TournamentVideoPrtcl: VideoPrtcl {
    func getFirstCharacter() -> CharacterID
    func getSecondCharacter() -> CharacterID
}