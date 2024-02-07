//
//  OnboardVC.swift
//  MovieMate
//
//  Created by Вадим Игнатенко on 7.02.24.
//

import UIKit

class OnboardVC: UIViewController {
    
    private var slides = [OnbordingView]()
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.isPagingEnabled = true
        sv.bounces = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "back5")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        scrollView.showsVerticalScrollIndicator = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        slides = createSlides()
        setupSlidesScrollView(slides: slides)
        slides[1].fixText()
        slides[2].noHideButton()
        slides[2].delegateClosed = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setDelegates()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .gray
        view.addSubview(scrollView)
        scrollView.addSubview(backImageView)
        view.addSubview(pageControl)
    }
    
    private func setDelegates() {
        scrollView.delegate = self
    }
    
    private func createSlides() -> [OnbordingView] {
        let firstOnboardingView = OnbordingView()
        firstOnboardingView.setPageLabelText(text: "Добро пожаловать в MovieMate — твоего нового кинематографического компаньона!")
        let secondOnboardingView = OnbordingView()
        secondOnboardingView.setPageLabelText(text: "MovieMate станет твоим приятелем, который поможет тебе найти интересующую тебя информацию по конкретному фильму, либо фильмам определенного жанра. \n \nТакже с помощью MovieMate ты найдешь себе фильм на сегодняшний вечер.")
        let thirdOnboardingView = OnbordingView()
        thirdOnboardingView.setPageLabelText(text: "Открой для себя много увлекательных фильмов и узнай о них много интересного. \n \nДавай начнем!")
        return [firstOnboardingView, secondOnboardingView, thirdOnboardingView]
    }
    
    private func setupSlidesScrollView(slides: [OnbordingView]) {
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat (slides.count), height: view.frame.height)
        for i in 0..<slides.count {
        slides[i].frame = CGRect(x: view.frame.width * CGFloat(i),
                                 y: 0,
                                 width: view.frame.width,
                                 height: view.frame.height)
        scrollView.addSubview(slides[i])
        }
    }
}

extension OnboardVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard slides.count >= 3 else { return}
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        let maxHorizontalOffset = scrollView.contentSize.width - view.frame.width
        let percentHorizontalOffset = scrollView.contentOffset.x / maxHorizontalOffset
        if percentHorizontalOffset <= 0.5 {
            let firstTransform = CGAffineTransform(scaleX: (0.5 - percentHorizontalOffset) / 0.5,
                                                   y: (0.5 - percentHorizontalOffset) / 0.5)
            let secondTransform = CGAffineTransform(scaleX: percentHorizontalOffset / 0.5,
                                                    y: percentHorizontalOffset / 0.5)
            slides[0].setPagelabelTransform(transform: firstTransform)
            slides[1].setPagelabelTransform(transform: secondTransform)
        } else {
            let secondTransform = CGAffineTransform(scaleX: (1 - percentHorizontalOffset) / 0.5,
                                                    y: (1 - percentHorizontalOffset) / 0.5)
            let thirdTransform = CGAffineTransform(scaleX: percentHorizontalOffset,
                                                   y: percentHorizontalOffset)
            slides[1].setPagelabelTransform(transform: secondTransform)
            slides[2].setPagelabelTransform(transform: thirdTransform)
        }
        pageControl.isHidden = (pageControl.currentPage == 2)
    }
}
    
extension OnboardVC {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint (equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            backImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            backImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            backImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            backImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            pageControl.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


extension OnboardVC: ClosedOnbording {
    func closeOnbord() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.popToRootViewController(animated: true)
    }
}
