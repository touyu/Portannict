//  This file was automatically generated and should not be edited.

import Apollo

public enum StatusState: String {
  case wannaWatch = "WANNA_WATCH"
  case watching = "WATCHING"
  case watched = "WATCHED"
  case onHold = "ON_HOLD"
  case stopWatching = "STOP_WATCHING"
  case noState = "NO_STATE"
}

extension StatusState: Apollo.JSONDecodable, Apollo.JSONEncodable {}

public final class GetViewerQuery: GraphQLQuery {
  public static let operationString =
    "query GetViewer {" +
    "  viewer {" +
    "    __typename" +
    "    ...UserDetails" +
    "    backgroundImageUrl" +
    "    recordsCount" +
    "    description" +
    "    followers {" +
    "      __typename" +
    "      edges {" +
    "        __typename" +
    "        node {" +
    "          __typename" +
    "          ...UserDetails" +
    "        }" +
    "      }" +
    "    }" +
    "    following {" +
    "      __typename" +
    "      edges {" +
    "        __typename" +
    "        node {" +
    "          __typename" +
    "          ...UserDetails" +
    "        }" +
    "      }" +
    "    }" +
    "  }" +
    "}"
  public static var requestString: String { return operationString.appending(UserDetails.fragmentString) }

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [Selection] = [
      Field("viewer", type: .object(Data.Viewer.self)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(viewer: Viewer? = nil) {
      self.init(snapshot: ["__typename": "Query", "viewer": viewer])
    }

    public var viewer: Viewer? {
      get {
        return (snapshot["viewer"]! as! Snapshot?).flatMap { Viewer(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "viewer")
      }
    }

    public struct Viewer: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [Selection] = [
        Field("__typename", type: .nonNull(.scalar(String.self))),
        Field("avatarUrl", type: .scalar(String.self)),
        Field("name", type: .nonNull(.scalar(String.self))),
        Field("username", type: .nonNull(.scalar(String.self))),
        Field("description", type: .nonNull(.scalar(String.self))),
        Field("backgroundImageUrl", type: .scalar(String.self)),
        Field("recordsCount", type: .nonNull(.scalar(Int.self))),
        Field("followers", type: .object(Viewer.Follower.self)),
        Field("following", type: .object(Viewer.Following.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(avatarUrl: String? = nil, name: String, username: String, description: String, backgroundImageUrl: String? = nil, recordsCount: Int, followers: Follower? = nil, following: Following? = nil) {
        self.init(snapshot: ["__typename": "User", "avatarUrl": avatarUrl, "name": name, "username": username, "description": description, "backgroundImageUrl": backgroundImageUrl, "recordsCount": recordsCount, "followers": followers, "following": following])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var avatarUrl: String? {
        get {
          return snapshot["avatarUrl"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "avatarUrl")
        }
      }

      public var name: String {
        get {
          return snapshot["name"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      public var username: String {
        get {
          return snapshot["username"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "username")
        }
      }

      public var description: String {
        get {
          return snapshot["description"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "description")
        }
      }

      public var backgroundImageUrl: String? {
        get {
          return snapshot["backgroundImageUrl"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "backgroundImageUrl")
        }
      }

      public var recordsCount: Int {
        get {
          return snapshot["recordsCount"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "recordsCount")
        }
      }

      public var followers: Follower? {
        get {
          return (snapshot["followers"]! as! Snapshot?).flatMap { Follower(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "followers")
        }
      }

      public var following: Following? {
        get {
          return (snapshot["following"]! as! Snapshot?).flatMap { Following(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "following")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot = newValue.snapshot
        }
      }

      public struct Fragments {
        public var snapshot: Snapshot

        public var userDetails: UserDetails {
          get {
            return UserDetails(snapshot: snapshot)
          }
          set {
            snapshot = newValue.snapshot
          }
        }
      }

      public struct Follower: GraphQLSelectionSet {
        public static let possibleTypes = ["UserConnection"]

        public static let selections: [Selection] = [
          Field("__typename", type: .nonNull(.scalar(String.self))),
          Field("edges", type: .list(.object(Follower.Edge.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(edges: [Edge?]? = nil) {
          self.init(snapshot: ["__typename": "UserConnection", "edges": edges])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of edges.
        public var edges: [Edge?]? {
          get {
            return (snapshot["edges"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Edge(snapshot: $0) } } }
          }
          set {
            snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "edges")
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes = ["UserEdge"]

          public static let selections: [Selection] = [
            Field("__typename", type: .nonNull(.scalar(String.self))),
            Field("node", type: .object(Edge.Node.self)),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(node: Node? = nil) {
            self.init(snapshot: ["__typename": "UserEdge", "node": node])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The item at the end of the edge.
          public var node: Node? {
            get {
              return (snapshot["node"]! as! Snapshot?).flatMap { Node(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "node")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes = ["User"]

            public static let selections: [Selection] = [
              Field("__typename", type: .nonNull(.scalar(String.self))),
              Field("avatarUrl", type: .scalar(String.self)),
              Field("name", type: .nonNull(.scalar(String.self))),
              Field("username", type: .nonNull(.scalar(String.self))),
              Field("description", type: .nonNull(.scalar(String.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(avatarUrl: String? = nil, name: String, username: String, description: String) {
              self.init(snapshot: ["__typename": "User", "avatarUrl": avatarUrl, "name": name, "username": username, "description": description])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            public var avatarUrl: String? {
              get {
                return snapshot["avatarUrl"]! as! String?
              }
              set {
                snapshot.updateValue(newValue, forKey: "avatarUrl")
              }
            }

            public var name: String {
              get {
                return snapshot["name"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "name")
              }
            }

            public var username: String {
              get {
                return snapshot["username"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "username")
              }
            }

            public var description: String {
              get {
                return snapshot["description"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "description")
              }
            }

            public var fragments: Fragments {
              get {
                return Fragments(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }

            public struct Fragments {
              public var snapshot: Snapshot

              public var userDetails: UserDetails {
                get {
                  return UserDetails(snapshot: snapshot)
                }
                set {
                  snapshot = newValue.snapshot
                }
              }
            }
          }
        }
      }

      public struct Following: GraphQLSelectionSet {
        public static let possibleTypes = ["UserConnection"]

        public static let selections: [Selection] = [
          Field("__typename", type: .nonNull(.scalar(String.self))),
          Field("edges", type: .list(.object(Following.Edge.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(edges: [Edge?]? = nil) {
          self.init(snapshot: ["__typename": "UserConnection", "edges": edges])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of edges.
        public var edges: [Edge?]? {
          get {
            return (snapshot["edges"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Edge(snapshot: $0) } } }
          }
          set {
            snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "edges")
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes = ["UserEdge"]

          public static let selections: [Selection] = [
            Field("__typename", type: .nonNull(.scalar(String.self))),
            Field("node", type: .object(Edge.Node.self)),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(node: Node? = nil) {
            self.init(snapshot: ["__typename": "UserEdge", "node": node])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The item at the end of the edge.
          public var node: Node? {
            get {
              return (snapshot["node"]! as! Snapshot?).flatMap { Node(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "node")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes = ["User"]

            public static let selections: [Selection] = [
              Field("__typename", type: .nonNull(.scalar(String.self))),
              Field("avatarUrl", type: .scalar(String.self)),
              Field("name", type: .nonNull(.scalar(String.self))),
              Field("username", type: .nonNull(.scalar(String.self))),
              Field("description", type: .nonNull(.scalar(String.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(avatarUrl: String? = nil, name: String, username: String, description: String) {
              self.init(snapshot: ["__typename": "User", "avatarUrl": avatarUrl, "name": name, "username": username, "description": description])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            public var avatarUrl: String? {
              get {
                return snapshot["avatarUrl"]! as! String?
              }
              set {
                snapshot.updateValue(newValue, forKey: "avatarUrl")
              }
            }

            public var name: String {
              get {
                return snapshot["name"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "name")
              }
            }

            public var username: String {
              get {
                return snapshot["username"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "username")
              }
            }

            public var description: String {
              get {
                return snapshot["description"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "description")
              }
            }

            public var fragments: Fragments {
              get {
                return Fragments(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }

            public struct Fragments {
              public var snapshot: Snapshot

              public var userDetails: UserDetails {
                get {
                  return UserDetails(snapshot: snapshot)
                }
                set {
                  snapshot = newValue.snapshot
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class GetViewerFollowersQuery: GraphQLQuery {
  public static let operationString =
    "query GetViewerFollowers($after: String) {" +
    "  viewer {" +
    "    __typename" +
    "    followers(first: 30, after: $after) {" +
    "      __typename" +
    "      edges {" +
    "        __typename" +
    "        node {" +
    "          __typename" +
    "          ...UserDetails" +
    "          viewerCanFollow" +
    "          viewerIsFollowing" +
    "        }" +
    "      }" +
    "      pageInfo {" +
    "        __typename" +
    "        endCursor" +
    "        hasNextPage" +
    "      }" +
    "    }" +
    "  }" +
    "}"
  public static var requestString: String { return operationString.appending(UserDetails.fragmentString) }

  public var after: String?

  public init(after: String? = nil) {
    self.after = after
  }

  public var variables: GraphQLMap? {
    return ["after": after]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [Selection] = [
      Field("viewer", type: .object(Data.Viewer.self)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(viewer: Viewer? = nil) {
      self.init(snapshot: ["__typename": "Query", "viewer": viewer])
    }

    public var viewer: Viewer? {
      get {
        return (snapshot["viewer"]! as! Snapshot?).flatMap { Viewer(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "viewer")
      }
    }

    public struct Viewer: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [Selection] = [
        Field("__typename", type: .nonNull(.scalar(String.self))),
        Field("followers", arguments: ["first": 30, "after": Variable("after")], type: .object(Viewer.Follower.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(followers: Follower? = nil) {
        self.init(snapshot: ["__typename": "User", "followers": followers])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var followers: Follower? {
        get {
          return (snapshot["followers"]! as! Snapshot?).flatMap { Follower(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "followers")
        }
      }

      public struct Follower: GraphQLSelectionSet {
        public static let possibleTypes = ["UserConnection"]

        public static let selections: [Selection] = [
          Field("__typename", type: .nonNull(.scalar(String.self))),
          Field("edges", type: .list(.object(Follower.Edge.self))),
          Field("pageInfo", type: .nonNull(.object(Follower.PageInfo.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(edges: [Edge?]? = nil, pageInfo: PageInfo) {
          self.init(snapshot: ["__typename": "UserConnection", "edges": edges, "pageInfo": pageInfo])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of edges.
        public var edges: [Edge?]? {
          get {
            return (snapshot["edges"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Edge(snapshot: $0) } } }
          }
          set {
            snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "edges")
          }
        }

        /// Information to aid in pagination.
        public var pageInfo: PageInfo {
          get {
            return PageInfo(snapshot: snapshot["pageInfo"]! as! Snapshot)
          }
          set {
            snapshot.updateValue(newValue.snapshot, forKey: "pageInfo")
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes = ["UserEdge"]

          public static let selections: [Selection] = [
            Field("__typename", type: .nonNull(.scalar(String.self))),
            Field("node", type: .object(Edge.Node.self)),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(node: Node? = nil) {
            self.init(snapshot: ["__typename": "UserEdge", "node": node])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The item at the end of the edge.
          public var node: Node? {
            get {
              return (snapshot["node"]! as! Snapshot?).flatMap { Node(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "node")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes = ["User"]

            public static let selections: [Selection] = [
              Field("__typename", type: .nonNull(.scalar(String.self))),
              Field("avatarUrl", type: .scalar(String.self)),
              Field("name", type: .nonNull(.scalar(String.self))),
              Field("username", type: .nonNull(.scalar(String.self))),
              Field("description", type: .nonNull(.scalar(String.self))),
              Field("viewerCanFollow", type: .nonNull(.scalar(Bool.self))),
              Field("viewerIsFollowing", type: .nonNull(.scalar(Bool.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(avatarUrl: String? = nil, name: String, username: String, description: String, viewerCanFollow: Bool, viewerIsFollowing: Bool) {
              self.init(snapshot: ["__typename": "User", "avatarUrl": avatarUrl, "name": name, "username": username, "description": description, "viewerCanFollow": viewerCanFollow, "viewerIsFollowing": viewerIsFollowing])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            public var avatarUrl: String? {
              get {
                return snapshot["avatarUrl"]! as! String?
              }
              set {
                snapshot.updateValue(newValue, forKey: "avatarUrl")
              }
            }

            public var name: String {
              get {
                return snapshot["name"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "name")
              }
            }

            public var username: String {
              get {
                return snapshot["username"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "username")
              }
            }

            public var description: String {
              get {
                return snapshot["description"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "description")
              }
            }

            public var viewerCanFollow: Bool {
              get {
                return snapshot["viewerCanFollow"]! as! Bool
              }
              set {
                snapshot.updateValue(newValue, forKey: "viewerCanFollow")
              }
            }

            public var viewerIsFollowing: Bool {
              get {
                return snapshot["viewerIsFollowing"]! as! Bool
              }
              set {
                snapshot.updateValue(newValue, forKey: "viewerIsFollowing")
              }
            }

            public var fragments: Fragments {
              get {
                return Fragments(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }

            public struct Fragments {
              public var snapshot: Snapshot

              public var userDetails: UserDetails {
                get {
                  return UserDetails(snapshot: snapshot)
                }
                set {
                  snapshot = newValue.snapshot
                }
              }
            }
          }
        }

        public struct PageInfo: GraphQLSelectionSet {
          public static let possibleTypes = ["PageInfo"]

          public static let selections: [Selection] = [
            Field("__typename", type: .nonNull(.scalar(String.self))),
            Field("endCursor", type: .scalar(String.self)),
            Field("hasNextPage", type: .nonNull(.scalar(Bool.self))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(endCursor: String? = nil, hasNextPage: Bool) {
            self.init(snapshot: ["__typename": "PageInfo", "endCursor": endCursor, "hasNextPage": hasNextPage])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// When paginating forwards, the cursor to continue.
          public var endCursor: String? {
            get {
              return snapshot["endCursor"]! as! String?
            }
            set {
              snapshot.updateValue(newValue, forKey: "endCursor")
            }
          }

          /// When paginating forwards, are there more items?
          public var hasNextPage: Bool {
            get {
              return snapshot["hasNextPage"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "hasNextPage")
            }
          }
        }
      }
    }
  }
}

public final class GetViewerFollowingQuery: GraphQLQuery {
  public static let operationString =
    "query GetViewerFollowing($after: String) {" +
    "  viewer {" +
    "    __typename" +
    "    following(first: 30, after: $after) {" +
    "      __typename" +
    "      edges {" +
    "        __typename" +
    "        node {" +
    "          __typename" +
    "          ...UserDetails" +
    "          viewerCanFollow" +
    "          viewerIsFollowing" +
    "        }" +
    "      }" +
    "      pageInfo {" +
    "        __typename" +
    "        endCursor" +
    "        hasNextPage" +
    "      }" +
    "    }" +
    "  }" +
    "}"
  public static var requestString: String { return operationString.appending(UserDetails.fragmentString) }

  public var after: String?

  public init(after: String? = nil) {
    self.after = after
  }

  public var variables: GraphQLMap? {
    return ["after": after]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [Selection] = [
      Field("viewer", type: .object(Data.Viewer.self)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(viewer: Viewer? = nil) {
      self.init(snapshot: ["__typename": "Query", "viewer": viewer])
    }

    public var viewer: Viewer? {
      get {
        return (snapshot["viewer"]! as! Snapshot?).flatMap { Viewer(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "viewer")
      }
    }

    public struct Viewer: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [Selection] = [
        Field("__typename", type: .nonNull(.scalar(String.self))),
        Field("following", arguments: ["first": 30, "after": Variable("after")], type: .object(Viewer.Following.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(following: Following? = nil) {
        self.init(snapshot: ["__typename": "User", "following": following])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var following: Following? {
        get {
          return (snapshot["following"]! as! Snapshot?).flatMap { Following(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "following")
        }
      }

      public struct Following: GraphQLSelectionSet {
        public static let possibleTypes = ["UserConnection"]

        public static let selections: [Selection] = [
          Field("__typename", type: .nonNull(.scalar(String.self))),
          Field("edges", type: .list(.object(Following.Edge.self))),
          Field("pageInfo", type: .nonNull(.object(Following.PageInfo.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(edges: [Edge?]? = nil, pageInfo: PageInfo) {
          self.init(snapshot: ["__typename": "UserConnection", "edges": edges, "pageInfo": pageInfo])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of edges.
        public var edges: [Edge?]? {
          get {
            return (snapshot["edges"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Edge(snapshot: $0) } } }
          }
          set {
            snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "edges")
          }
        }

        /// Information to aid in pagination.
        public var pageInfo: PageInfo {
          get {
            return PageInfo(snapshot: snapshot["pageInfo"]! as! Snapshot)
          }
          set {
            snapshot.updateValue(newValue.snapshot, forKey: "pageInfo")
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes = ["UserEdge"]

          public static let selections: [Selection] = [
            Field("__typename", type: .nonNull(.scalar(String.self))),
            Field("node", type: .object(Edge.Node.self)),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(node: Node? = nil) {
            self.init(snapshot: ["__typename": "UserEdge", "node": node])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The item at the end of the edge.
          public var node: Node? {
            get {
              return (snapshot["node"]! as! Snapshot?).flatMap { Node(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "node")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes = ["User"]

            public static let selections: [Selection] = [
              Field("__typename", type: .nonNull(.scalar(String.self))),
              Field("avatarUrl", type: .scalar(String.self)),
              Field("name", type: .nonNull(.scalar(String.self))),
              Field("username", type: .nonNull(.scalar(String.self))),
              Field("description", type: .nonNull(.scalar(String.self))),
              Field("viewerCanFollow", type: .nonNull(.scalar(Bool.self))),
              Field("viewerIsFollowing", type: .nonNull(.scalar(Bool.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(avatarUrl: String? = nil, name: String, username: String, description: String, viewerCanFollow: Bool, viewerIsFollowing: Bool) {
              self.init(snapshot: ["__typename": "User", "avatarUrl": avatarUrl, "name": name, "username": username, "description": description, "viewerCanFollow": viewerCanFollow, "viewerIsFollowing": viewerIsFollowing])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            public var avatarUrl: String? {
              get {
                return snapshot["avatarUrl"]! as! String?
              }
              set {
                snapshot.updateValue(newValue, forKey: "avatarUrl")
              }
            }

            public var name: String {
              get {
                return snapshot["name"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "name")
              }
            }

            public var username: String {
              get {
                return snapshot["username"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "username")
              }
            }

            public var description: String {
              get {
                return snapshot["description"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "description")
              }
            }

            public var viewerCanFollow: Bool {
              get {
                return snapshot["viewerCanFollow"]! as! Bool
              }
              set {
                snapshot.updateValue(newValue, forKey: "viewerCanFollow")
              }
            }

            public var viewerIsFollowing: Bool {
              get {
                return snapshot["viewerIsFollowing"]! as! Bool
              }
              set {
                snapshot.updateValue(newValue, forKey: "viewerIsFollowing")
              }
            }

            public var fragments: Fragments {
              get {
                return Fragments(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }

            public struct Fragments {
              public var snapshot: Snapshot

              public var userDetails: UserDetails {
                get {
                  return UserDetails(snapshot: snapshot)
                }
                set {
                  snapshot = newValue.snapshot
                }
              }
            }
          }
        }

        public struct PageInfo: GraphQLSelectionSet {
          public static let possibleTypes = ["PageInfo"]

          public static let selections: [Selection] = [
            Field("__typename", type: .nonNull(.scalar(String.self))),
            Field("endCursor", type: .scalar(String.self)),
            Field("hasNextPage", type: .nonNull(.scalar(Bool.self))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(endCursor: String? = nil, hasNextPage: Bool) {
            self.init(snapshot: ["__typename": "PageInfo", "endCursor": endCursor, "hasNextPage": hasNextPage])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// When paginating forwards, the cursor to continue.
          public var endCursor: String? {
            get {
              return snapshot["endCursor"]! as! String?
            }
            set {
              snapshot.updateValue(newValue, forKey: "endCursor")
            }
          }

          /// When paginating forwards, are there more items?
          public var hasNextPage: Bool {
            get {
              return snapshot["hasNextPage"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "hasNextPage")
            }
          }
        }
      }
    }
  }
}

public final class GetViewerWorksQuery: GraphQLQuery {
  public static let operationString =
    "query GetViewerWorks($state: StatusState, $after: String) {" +
    "  viewer {" +
    "    __typename" +
    "    works(state: state, first: 30, after: after) {" +
    "      __typename" +
    "      edges {" +
    "        __typename" +
    "        node {" +
    "          __typename" +
    "          title" +
    "          image {" +
    "            __typename" +
    "            twitterAvatarUrl" +
    "            recommendedImageUrl" +
    "          }" +
    "        }" +
    "        cursor" +
    "      }" +
    "      pageInfo {" +
    "        __typename" +
    "        endCursor" +
    "        hasNextPage" +
    "      }" +
    "    }" +
    "  }" +
    "}"

  public var state: StatusState?
  public var after: String?

  public init(state: StatusState? = nil, after: String? = nil) {
    self.state = state
    self.after = after
  }

  public var variables: GraphQLMap? {
    return ["state": state, "after": after]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [Selection] = [
      Field("viewer", type: .object(Data.Viewer.self)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(viewer: Viewer? = nil) {
      self.init(snapshot: ["__typename": "Query", "viewer": viewer])
    }

    public var viewer: Viewer? {
      get {
        return (snapshot["viewer"]! as! Snapshot?).flatMap { Viewer(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "viewer")
      }
    }

    public struct Viewer: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [Selection] = [
        Field("__typename", type: .nonNull(.scalar(String.self))),
        Field("works", arguments: ["state": "state", "first": 30, "after": "after"], type: .object(Viewer.Work.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(works: Work? = nil) {
        self.init(snapshot: ["__typename": "User", "works": works])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var works: Work? {
        get {
          return (snapshot["works"]! as! Snapshot?).flatMap { Work(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "works")
        }
      }

      public struct Work: GraphQLSelectionSet {
        public static let possibleTypes = ["WorkConnection"]

        public static let selections: [Selection] = [
          Field("__typename", type: .nonNull(.scalar(String.self))),
          Field("edges", type: .list(.object(Work.Edge.self))),
          Field("pageInfo", type: .nonNull(.object(Work.PageInfo.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(edges: [Edge?]? = nil, pageInfo: PageInfo) {
          self.init(snapshot: ["__typename": "WorkConnection", "edges": edges, "pageInfo": pageInfo])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of edges.
        public var edges: [Edge?]? {
          get {
            return (snapshot["edges"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Edge(snapshot: $0) } } }
          }
          set {
            snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "edges")
          }
        }

        /// Information to aid in pagination.
        public var pageInfo: PageInfo {
          get {
            return PageInfo(snapshot: snapshot["pageInfo"]! as! Snapshot)
          }
          set {
            snapshot.updateValue(newValue.snapshot, forKey: "pageInfo")
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes = ["WorkEdge"]

          public static let selections: [Selection] = [
            Field("__typename", type: .nonNull(.scalar(String.self))),
            Field("node", type: .object(Edge.Node.self)),
            Field("cursor", type: .nonNull(.scalar(String.self))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(node: Node? = nil, cursor: String) {
            self.init(snapshot: ["__typename": "WorkEdge", "node": node, "cursor": cursor])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The item at the end of the edge.
          public var node: Node? {
            get {
              return (snapshot["node"]! as! Snapshot?).flatMap { Node(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "node")
            }
          }

          /// A cursor for use in pagination.
          public var cursor: String {
            get {
              return snapshot["cursor"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "cursor")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes = ["Work"]

            public static let selections: [Selection] = [
              Field("__typename", type: .nonNull(.scalar(String.self))),
              Field("title", type: .nonNull(.scalar(String.self))),
              Field("image", type: .object(Node.Image.self)),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(title: String, image: Image? = nil) {
              self.init(snapshot: ["__typename": "Work", "title": title, "image": image])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            public var title: String {
              get {
                return snapshot["title"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "title")
              }
            }

            public var image: Image? {
              get {
                return (snapshot["image"]! as! Snapshot?).flatMap { Image(snapshot: $0) }
              }
              set {
                snapshot.updateValue(newValue?.snapshot, forKey: "image")
              }
            }

            public struct Image: GraphQLSelectionSet {
              public static let possibleTypes = ["WorkImage"]

              public static let selections: [Selection] = [
                Field("__typename", type: .nonNull(.scalar(String.self))),
                Field("twitterAvatarUrl", type: .scalar(String.self)),
                Field("recommendedImageUrl", type: .scalar(String.self)),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(twitterAvatarUrl: String? = nil, recommendedImageUrl: String? = nil) {
                self.init(snapshot: ["__typename": "WorkImage", "twitterAvatarUrl": twitterAvatarUrl, "recommendedImageUrl": recommendedImageUrl])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              public var twitterAvatarUrl: String? {
                get {
                  return snapshot["twitterAvatarUrl"]! as! String?
                }
                set {
                  snapshot.updateValue(newValue, forKey: "twitterAvatarUrl")
                }
              }

              public var recommendedImageUrl: String? {
                get {
                  return snapshot["recommendedImageUrl"]! as! String?
                }
                set {
                  snapshot.updateValue(newValue, forKey: "recommendedImageUrl")
                }
              }
            }
          }
        }

        public struct PageInfo: GraphQLSelectionSet {
          public static let possibleTypes = ["PageInfo"]

          public static let selections: [Selection] = [
            Field("__typename", type: .nonNull(.scalar(String.self))),
            Field("endCursor", type: .scalar(String.self)),
            Field("hasNextPage", type: .nonNull(.scalar(Bool.self))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(endCursor: String? = nil, hasNextPage: Bool) {
            self.init(snapshot: ["__typename": "PageInfo", "endCursor": endCursor, "hasNextPage": hasNextPage])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// When paginating forwards, the cursor to continue.
          public var endCursor: String? {
            get {
              return snapshot["endCursor"]! as! String?
            }
            set {
              snapshot.updateValue(newValue, forKey: "endCursor")
            }
          }

          /// When paginating forwards, are there more items?
          public var hasNextPage: Bool {
            get {
              return snapshot["hasNextPage"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "hasNextPage")
            }
          }
        }
      }
    }
  }
}

public struct UserDetails: GraphQLFragment {
  public static let fragmentString =
    "fragment UserDetails on User {" +
    "  __typename" +
    "  avatarUrl" +
    "  name" +
    "  username" +
    "  description" +
    "}"

  public static let possibleTypes = ["User"]

  public static let selections: [Selection] = [
    Field("__typename", type: .nonNull(.scalar(String.self))),
    Field("avatarUrl", type: .scalar(String.self)),
    Field("name", type: .nonNull(.scalar(String.self))),
    Field("username", type: .nonNull(.scalar(String.self))),
    Field("description", type: .nonNull(.scalar(String.self))),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public init(avatarUrl: String? = nil, name: String, username: String, description: String) {
    self.init(snapshot: ["__typename": "User", "avatarUrl": avatarUrl, "name": name, "username": username, "description": description])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  public var avatarUrl: String? {
    get {
      return snapshot["avatarUrl"]! as! String?
    }
    set {
      snapshot.updateValue(newValue, forKey: "avatarUrl")
    }
  }

  public var name: String {
    get {
      return snapshot["name"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "name")
    }
  }

  public var username: String {
    get {
      return snapshot["username"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "username")
    }
  }

  public var description: String {
    get {
      return snapshot["description"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "description")
    }
  }
}