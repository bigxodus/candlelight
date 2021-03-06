//
//  Comment.swift
//  candlelight
//
//  Created by Lawrence on 2017. 3. 6..
//  Copyright © 2017년 Waynlaw. All rights reserved.
//

import Foundation

class Comment {
    // 댓글
    var content: String?

    // 작성자
    var author: String?

    // 작성일
    var regDate: Date?

    // 댓글 깊이
    var depth: Int?

    public init() {
    }

    public init(author: String, content: String, regDate: Date, depth: Int) {
        self.content = content
        self.author = author
        self.regDate = regDate
        self.depth = depth
    }

    func toHtml() -> String {
        let res = "<div class='depth\(depth!) '> <p> <span class='author'>\(author!)</span> <span class='reg-date'>\(dateToString(regDate!))</span> </p> <span class='comment'> \(content!) </span> </div>"
        return res
    }

    func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.setLocalizedDateFormatFromTemplate("MM.dd HH:mm:ss")
        return formatter.string(from: date)
    }

}
