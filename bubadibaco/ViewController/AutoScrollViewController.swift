//
//  AutoScrollViewController.swift
//  bubadibaco
//
//  Created by Gwynneth Isviandhy on 28/07/24.
//

import UIKit

class AutoScrollViewController: UIViewController {

    var scrollView: UIScrollView!
    var autoScrollTimer: Timer?
    let scrollSpeed: CGFloat = 1.0
    let scrollInterval: TimeInterval = 0.03

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup ScrollView
        scrollView = UIScrollView(frame: self.view.bounds)
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height * 2)
        scrollView.delegate = self
        self.view.addSubview(scrollView)

        // Add content to ScrollView
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height))
        contentView.backgroundColor = .lightGray
        scrollView.addSubview(contentView)
    }

    func startAutoScroll() {
        autoScrollTimer = Timer.scheduledTimer(timeInterval: scrollInterval, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }

    func stopAutoScroll() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }

    @objc func autoScroll() {
        var newOffset = scrollView.contentOffset
        newOffset.y += scrollSpeed

        if newOffset.y + scrollView.bounds.height > scrollView.contentSize.height {
            newOffset.y = scrollView.contentSize.height - scrollView.bounds.height
        }

        scrollView.setContentOffset(newOffset, animated: false)
    }
}

extension AutoScrollViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewHeight = scrollView.bounds.height
        let contentHeight = scrollView.contentSize.height
        let offsetY = scrollView.contentOffset.y

        if offsetY >= contentHeight - scrollViewHeight - 50 { // Near the bottom
            if autoScrollTimer == nil {
                startAutoScroll()
            }
        } else {
            stopAutoScroll()
        }
    }
}
