//
//  ResultsModel.swift
//  Test Assignment
//
//  Created by Ahmed Serdah on 24/06/2022.
//

import Foundation

// MARK: - ResultsModel
struct ResultsModel: Codable {
    var totalCount: Int
    var incompleteResults: Bool
    var items: [UserModel]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

// MARK: - User
struct UserModel: Codable {
    var login: String
    var id: Int
    var nodeID: String
    var avatarURL: String
    var gravatarID: String
    var url, htmlURL, followersURL: String
    var followingURL, gistsURL, starredURL: String
    var subscriptionsURL, organizationsURL, reposURL: String
    var eventsURL: String
    var receivedEventsURL: String
    var type: AccountType
    var siteAdmin: Bool
    var score: Int

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
        case score
    }
}

enum AccountType: String, Codable {
    case organization = "Organization"
    case user = "User"
}
