import Foundation
import SwiftUI
import WebKit

struct WebLoadState: Equatable {
    enum StateType: Int {
        case idle = 0
        case progress
        case success
        case error
        case offline
    }
    let type: StateType
    let percent: Double?
    let error: Error?
    
    static func idle() -> WebLoadState {
        WebLoadState(type: .idle, percent: nil, error: nil)
    }
    static func progress(_ percent: Double) -> WebLoadState {
        WebLoadState(type: .progress, percent: percent, error: nil)
    }
    static func success() -> WebLoadState {
        WebLoadState(type: .success, percent: nil, error: nil)
    }
    static func error(_ err: Error) -> WebLoadState {
        WebLoadState(type: .error, percent: nil, error: err)
    }
    static func offline() -> WebLoadState {
        WebLoadState(type: .offline, percent: nil, error: nil)
    }
    
    static func == (lhs: WebLoadState, rhs: WebLoadState) -> Bool {
        if lhs.type != rhs.type { return false }
        switch lhs.type {
        case .progress:
            return lhs.percent == rhs.percent
        case .error:
            return true // Не сравниваем ошибки по содержимому
        default:
            return true
        }
    }
}

