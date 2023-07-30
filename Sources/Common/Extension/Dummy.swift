//
//  Dummy.swift
//  Portannict
//
//  Created by Yuto Akiba on 2021/01/17.
//

import Foundation

extension ReviewFragment {
    static var dummy: ReviewFragment {
        ReviewFragment(id: "", annictId: 0, body: "良い作品だった", ratingOverallState: .good, createdAt: "2021-01-06T17:20:54Z", user: .init(unsafeResultMap: UserFragment.dummy.resultMap), work: .init(unsafeResultMap: WorkFragment.dummy.resultMap))
    }

    static var dummy2: ReviewFragment {
        ReviewFragment(id: "",
                       annictId: 0,
                       body: "良い作品だった",
                       ratingAnimationState: .good,
                       ratingOverallState: .great,
                       ratingMusicState: .average,
                       ratingStoryState: .bad,
                       ratingCharacterState: .great,
                       createdAt: "2021-01-06T17:20:54Z",
                       user: .init(unsafeResultMap: UserFragment.dummy.resultMap),
                       work: .init(unsafeResultMap: WorkFragment.dummy.resultMap))
    }
}

extension UserFragment {
    static var dummy: UserFragment {
        UserFragment(id: "user", name: "touyu", username: "touyu", avatarUrl: "https://api-assets.annict.com/shrine/profile/5482/image/master-70884f30052922f4f758e6eb69dc6985.jpg", description: "")
    }
}

extension WorkFragment {
    static var dummy: WorkFragment {
        WorkFragment(id: "", annictId: 6524, title: "PSYCHO-PASS", episodesCount: 24, watchersCount: 51, reviewsCount: 12, media: .tv)
    }

    static var dummy2: WorkFragment {
        WorkFragment(id: "", annictId: 0, title: "No Title No Title No Title", episodesCount: 0, watchersCount: 0, reviewsCount: 0, media: .tv)
    }

    static var dummy3: WorkFragment {
        WorkFragment(id: "", annictId: 6524, title: "No Title No Title No Title No Title No Title No Title", episodesCount: 0, watchersCount: 0, reviewsCount: 0, media: .tv)
    }
}
