
import Foundation
import AlfredKit
import APIKit

var items = [Alfred.Item]()

guard CommandLine.arguments.count >= 2 else {

    exit(1)
}

let arg = CommandLine.arguments[1]

let semaphor = DispatchSemaphore(value: 0)
Session.send(GitHubAPI.SearchRepositories(query: arg), callbackQueue: .sessionQueue)
{ result in

    switch result {

    case .success(let response):

        items = response.items.map{ Alfred.Item(title: $0.fullName) }
    default:
        break
    }

    semaphor.signal()
}

semaphor.wait()
do {

    try items.export()
} catch {
    
    items.removeAll()
    items.append(.init(title: "Failed to request", valid: false))
    try items.export()
}
