/*
 [백준] 좋은 수열
 
 
 reduce 메소드 공부
 @inlinable public func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) throws -> Result) rethrows -> Result
 
 reduce는 제네릭 함수이므로 다양한 타입으로 연산이 가능하고 해당 타입으로 반환하는 함수이다.
 
 [Result는 뭐지?]
 매번 특정 함수를 함수를 사용하려고 할때 자동완성 기능 아래 관련 메소드의 설명이 뜨게 됩니다.
 
 "reduce(_ initialResult: Result, _ nextPartialResult: (Result, Element) throws -> Result) rethrows -> Result"
 요런 형식으로 뜨게 되었습니다.
 reduce의 관련 설명을 보던 와중 뜬금없이 Result가 보였습니다.
 처음에 Result라는 타입을 보고 내가 알지 못했던 무슨 새로운 타입인가 했지만 
 "제네릭 타입의 이름"이였던것을 알게 되었다.
 
 추가 설명에 제네릭 함수를 선언할때 명명한 제네릭 타입의 이름이 뜨게 됩니다. 위에 경우 제네릭 타입의 이름은 Result로 명명되어 있습니다.
 
 reduce(
    _ initialResult: Result,
    _ nextPartialResult: (Result, Element) throws -> Result
 )
 rethrows -> Result
 
 [throws, rethrows??]
 
 컨테이너의 요소들을 하나로 합치는 기능(문자 숫자의 리스트에서 사용 가능)
 
 기본 형태:
 리스트.reduce(초기값){result == 누적된 값, element == 현재 값}
 
 let list = [1,2,3,4]
 let listString = ["1","2","3","4"]

 print(list.reduce(5) {$0 + $1})
 print(listString.reduce("hello", {$0 + $1 }))

 */


let N = Int(readLine()!)!
let numbers = ["1","2","3"]
var result: [String] = ["1"]
var flag = false

//range 범위 만큼 맨뒤에 요소들 비교 같으면 true, 다르면 false
func compare(_ range: Int) -> Bool{
    let rightStart: Int = result.count - range
    let leftStart: Int = rightStart - range
    for idx in 0..<range{
        //부분수열의 idx별 요소 비교
        if result[leftStart+idx] != result[rightStart+idx]{
            return false
        }
    }
    return true
}

var done = false
func recursive(_ numOfRepeat: Int){
    //N까지 배열이 도달했다면
    if numOfRepeat == N{
        //도달 했으니까 복귀!
        done = true
        return
    }
    //1, 2, 3 하나씩 넣어보면서 조건에 충족하는지 확인
    for num in numbers{
        result.append(num)
        var isEnable = false
        //range(1부터 전체 배열 나누기 2했을때 몫까지) 범위 부분수열 비교
        for range in 1...result.count/2{
            if compare(range){
                //같으면 해당 num은 잘못됨
                result.removeLast()
                //부분 수열이 같은 경우
                isEnable = false
                break
            }
            else{
                //부분 수열이 다른 경우
                isEnable = true
            }
        }
        if isEnable == true{
            recursive(numOfRepeat + 1)
            //성공적으로 N번 반복하고 복귀하는길
            if done == true{return}
            //그런데 최적의 순열이라 생각했지만 다음 반복에서 안됐을때.. back
            result.removeLast()
        }
    }
}

recursive(1)
print(result.reduce(""){$0+$1})

//    if numOfRepeat == N{
//
//        return
//    }
//    for num in numbers{
//        var isEnalbe = false
//        result.append(num)
//
//        for range in 1...result.count/2{
//            if compare(range){
//                isEnalbe = false
//                result.removeLast()
//                break
//            }else{
//                isEnalbe = true
//                recursive(numOfRepeat + 1)
//            }
//        }
//        //용도는 현재 넘이 적합할때
//        if isEnalbe {break}
//    }

//1 2 1 3 1 2 1 3


//import Foundation
//
//let N = Int(readLine()!)!
//let numbers = ["1","2","3"]
//var list = [String]()
//var answer = ""
//
////입력 받은 숫자 count를 1씩 감소 시키면서 recursive 진행
//func dfs(count : Int) {
//    //N - 1번 반복이 끝났다면
//    if count == 0 {
//        if answer != "" { return }//입력된것이 하나도 없으면 그냥
//        if list.count == N {
//            //리스트에 있는 문자들 합치는 코드
//            answer = list.reduce("", { $0 + $1 })
//        }
//        return
//    }else {
//        if answer != "" { return }
//        let before = list.count
//        let interval =  (list.count + 1 ) / 2
//        for n in numbers {
//            list.append(n)
//
//            for i in 1...interval {
//                let left = list[list.count-i-i..<list.count-i]
//                let right = list[list.count-i..<list.count]
//                if left == right {
//                    list.removeLast()
//                    break
//                }
//            }
//            if before + 1 == list.count  {
//                dfs(count: count-1 )
//                list.removeLast()
//            }
//        }
//    }
//}
//
//if N == 1 {
//    print(1)
//}else {
//    list = ["1"]
//    dfs(count: N-1)
//    print(answer)
//}

//넣기 전에 확인

//let N = Int(readLine()!)!
//let caseOfNum = [1,2,3]
//var flags: [Bool] = Array(repeating: false, count: 3)
//var minSequence: Int = Int.max
//func recursive(_ idx: Int,_ result: [Int],_ previousNum: Int){
//    if idx == N{
//        if flags[0] == true && flags[1] == true && flags[2] == true{
//            print(result)
//            //이 과정에서 Int 표현범위 초과
//            let temp = Int(result.map{String($0)}.joined(separator: ""))!
//            //
//            minSequence = min(minSequence, temp)
//        }
//        return
//    }
//    var temp = result
//    for num in caseOfNum{
//        
//        if previousNum == -1{
//            flags[num-1] = true
//            temp.append(num)
//            recursive(idx + 1, temp, num)
//            flags[num-1] = false
//            temp.removeLast()
//        }else{
//            if previousNum == num{
//                continue
//            }
//            else{
//                flags[num-1] = true
//                temp.append(num)
//                recursive(idx + 1, temp, num)
//                flags[num-1] = false
//                temp.removeLast()
//            }
//        }
//    }
//}
//
//recursive(0, [],-1)
//print(minSequence)

//
//let N = Int(readLine()!)!
//
//let pattern = "1213"
//let pattern1 = "12"
//var result = ""
//if N > 4{
//    result += pattern
//    let n = N - 4
//    let numOfRepeat1 = n / 2
//    for _ in 0..<numOfRepeat1+1{
//        result += pattern1
//    }
//    let minus1 = n % 2
//    for _ in 0..<minus1{
//        result.removeLast()
//    }
//}else{ //4 미만인 경우
//    switch N{
//    case 1:
//        result = "1"
//    case 2 :
//        result = "12"
//    case 3 :
//         result = "123"
//    case 4:
//        result = pattern
//    default:
//        print("error")
//    }
//}
//print(result)
