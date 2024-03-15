/*
 [백준] 단어 수학
 - 문자들은 대문자로 이루어짐
 - 각 문자들의 할당된 숫자는 정해지지 않음
 - 다른 문자이면 다른 숫자가 할당되어야 한다.
 - 앞에 출현하는 문자들은 높은 수여야한다.
 
 순서
 XXGCF 5
 ACDEB 5
 9~0
 1. 수 할당
 2. 높은 자리수부터 차례대로 높은 수 할당
 3. 같은 자리수라면 더 먼저있는 수에 먼저할당
 4. 아닐 수 있기 때문에 backtracking

fillX() 함수 설명
환경 설명
가장 자릿수가 높은 문자부터 큰값을 할당해주어야 한다.
그리고 문자간 시작 인덱스와 끝 인덱스가 차이가 나게 된다면 반복 시에 out of range 에러가 발생하므로
인덱스를 맞춰주는 과정이 필요하다고 판단
입력이  아래처럼 들어온 경우
*/
let N = Int(readLine()!)!
var letterDictionary: [String:Int] = ["A":-1,"B":-1,"C":-1,"D":-1,"E":-1,"F":-1,"G":-1,"H":-1,"I":-1,"J":-1,"K":-1,"L":-1,"M":-1,"N":-1,"O":-1,"P":-1,"Q":-1,"R":-1,"S":-1,"T":-1,"U":-1,"V":-1,"W":-1,"X":-1,"Y":-1,"Z":-1]
var maxStrLen = 0
var selectedNum = 9
var strs = [[String]]()
for idx in 0..<N{
    let temp = readLine()!.map{String($0)}
    maxStrLen = max(maxStrLen, temp.count)
    strs.append(temp)
}

let numOfStr = strs.count

func fillAt(){
    for idx in 0..<numOfStr{
        if strs[idx].count < maxStrLen{
            for _ in 0..<maxStrLen - strs[idx].count{
                strs[idx].insert("@", at: 0)
            }
        }
    }
}

var maxSum = 0
func recursive(_ numOfRepeat: Int){
    if numOfRepeat == maxStrLen{
        var sum = 0
        for str in strs{
            var temp: [String] = []
            for idx in 0..<str.count{
                let ch = str[idx]
                if ch != "@"{
                    temp.append(String(letterDictionary[ch]!))
                }
            }
            sum += Int(temp.reduce(""){$0 + $1})!
        }
        maxSum = max(maxSum,sum)
        return
    }
    
    //단어 갯수만큼 반복하여 현재 selectedNum에서 1씩 줄여서
    /*
    XXGCF
    ACDEB
    ECDEB
    */
    for startIdx in 0..<numOfStr{
        var numOfX = 0
        for idx in startIdx..<startIdx + numOfStr{
            let str = strs[idx % numOfStr]
            let ch = str[numOfRepeat]
            if ch != "@" && letterDictionary[ch] == -1{
                letterDictionary[ch] = selectedNum
                selectedNum -= 1
            }
            //X인 경우
            else{
                numOfX += 1
            }
        }
        //back: 할당할 값의 범위 복구 X가 포함되어 있을 경우는 X를 발견한 만큼 문자에 값을 할당하지 않았기 때문에 X 갯수만큼
        recursive(numOfRepeat + 1)
        selectedNum += numOfStr - numOfX
    }
}
fillAt()
recursive(0)
print(maxSum)




