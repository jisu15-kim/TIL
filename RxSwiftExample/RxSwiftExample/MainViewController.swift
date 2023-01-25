//
//  ViewController.swift
//  RxSwiftExample
//
//  Created by 김지수 on 2023/01/25.
//

import UIKit
import RxSwift

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = Observable.from([1, 2, 3, 4, 5])
        
        // just: 단일 변수 생성
        let observable1 = Observable.just(1)
        
        // of: 배열이나 서로 다른 자료형 set
        let observable2 = Observable.of(1, 3, 7)
        
        // 배열을 리턴
        let observable3 = Observable.of([1, 3, 7])
        
        // 요소 하나하나를 리턴
        let observable4 = Observable.from([1, 2, 3, 4, 5])
        
        observable3.subscribe { event in
            // of: 배열 전체를 리턴
            if let element = event.element {
                print("observable3 ====")
                print(element)
            }
        }
        
        observable4.subscribe { event in
            // from: 배열의 요소 하나하나를 리턴
            if let element = event.element {
                print("observable4 ====")
                print(element)
            }
        }
        
        let subscription1 = observable3.subscribe(onNext: { event in
            
            // 배열 전체를 리턴
            print(event)
            event.forEach { element in
                print("Element: \(element)")
            }
        })
        
        subscription1.dispose()
        
        // bag 생성
        let disposeBag = DisposeBag()
        
        // disposeBag은 .disposed(by:)와 함께 사용
        let ABC = Observable.of("A", "B", "C")
        ABC.subscribe(onNext: {
            print($0)
        }).disposed(by: disposeBag)
        
        //
        let observable5 = Observable<String>.create { observer in
            observer.onNext("A")
            // onCompleted 이후의 함수는 실행되지 않는다
            observer.onNext("?")
            // create 메소드는 disposable 리턴 필요
            return Disposables.create()
        }.subscribe(onNext: {print($0)},
                    onError: {print($0)},
                    onCompleted: {print("OnCompleted")},
                    onDisposed: {print("disposed")})
            .disposed(by: disposeBag)
        
        print("=====subject====")
        
        
        let subject = PublishSubject<String>()
        subject.onNext("issue#1")
        
        // 이벤트 정의
        subject.subscribe(onNext: {
            print("값이 바뀌었다: \($0)")
        })
        // 이 시점엔 출력 X
        
        subject.onNext("issue#2")
        // 출력
        
        subject.onNext("issue#3")
        
        for i in 0...100 {
            subject.onNext("\(i)")
        }
        
        
        // behaviorSubject
        let behaviorSubject = BehaviorSubject(value: "issue#1")
        behaviorSubject.subscribe { event in
            print(event)
        }
        
        behaviorSubject.onNext("issue#2")
        
        // replaySubject
        // subscribe 시점에 버퍼사이즈 만큼 최신에 발행된 onNext event를 가져옴
        let replaySubject = ReplaySubject<String>.create(bufferSize: 2)
        
        replaySubject.onNext("issue #1")
        replaySubject.onNext("issue #2")
        replaySubject.onNext("issue #3")
        
        // 최신 2개 이벤트만 가져옴
        replaySubject.subscribe { event in
            print("replaySubject: \(event)")
        }
        
        replaySubject.onNext("Issue #4")
        replaySubject.onNext("Issue #5")
        replaySubject.onNext("Issue #6")
        
        replaySubject.subscribe { event in
            print("replaySubject: \(event)")
        }
        
        // ignore
        let strikes = PublishSubject<String>()
        
        strikes
            .element(at: 2)
            .subscribe(onNext: {
                print("indexReached: \($0)")
            }).disposed(by: disposeBag)
        
        strikes.onNext("A")
        strikes.onNext("B")
        strikes.onNext("C")
        
        // filter
        Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9)
            .filter {
                $0 % 2 == 0
            }
            .subscribe(onNext: {
                print("Filtered: \($0)")
            }).disposed(by: disposeBag)
        
        // skip : count개수만큼 skip함
        Observable.of("A", "B", "C", "D", "E", "F", "G")
            .skip(3)
            .subscribe(onNext: {
                print($0)
            }).disposed(by: disposeBag)
        
        print("=========skipUntil=======")
        // skipUntil
        let mySubject = PublishSubject<String>()
        let trigger = PublishSubject<String>()
        
        mySubject.skip(until: trigger)
            .subscribe(onNext: {
                print($0)
            }).disposed(by: disposeBag)
        
        mySubject.onNext("A")
        mySubject.onNext("B")
        mySubject.onNext("C")
        
        trigger.onNext("Something")
        
        mySubject.onNext("D")
        mySubject.onNext("E")
        mySubject.onNext("F")
        
        // takeWhile : 짝수를 만나기 전까지만 출력 - 7을 만난 이후부터 출력 X
        Observable.of(2, 4, 6, 7, 8, 10)
            .take(while: {
                $0 % 2 == 0
            })
            .subscribe(onNext: {
                print($0)
            }).disposed(by: disposeBag)
        
        
        // map : 각 요소에 연산
        Observable.of(2, 4, 3, 5)
            .map({
                $0 * 2
            }).subscribe(onNext: {
                print($0)
            }).disposed(by: disposeBag)
        
        // merge
        let left = PublishSubject<Int>()
        let right = PublishSubject<Int>()
        
        let source = Observable.of(left.asObserver(), right.asObserver())
        let observable = source.merge()
        
        observable.subscribe(onNext: {
            print($0)
        }).disposed(by: disposeBag)

        left.onNext(1)
        right.onNext(3)
        left.onNext(2)
        right.onNext(4)
    }
}

