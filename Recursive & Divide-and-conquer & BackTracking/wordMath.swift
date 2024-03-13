/*
 [백준] 단어 수학
 - 문자들은 대문자로 이루어짐
 - 각 문자들의 할당된 숫자는 정해지지 않음
 - 다른 문자이면 다른 숫자가 할당되어야 한다.
 - 앞에 출현하는 문자들은 높은 수여야한다.
 
 순서
 1. 수 할당
 2. 높은 자리수부터 차례대로 높은 수 할당
 3. 같은 자리수라면 더 먼저있는 수에 먼저할당
 4. 아닐 수 있기 때문에 backtracking
 
 */
let N = Int(readLine()!)!
var letterDictionary: [String:Int] = ["A":-1,"B":-1,"C":-1,"D":-1,"E":-1,"F":-1,"G":-1,"H":-1,"I":-1,"J":-1]
var letterCase = ["A","B","C","D","E","F","G","H","I"]
var maxStrLen = 0
var selectedNum = 9
var strs = [[String]]()
for idx in 0..<N{
    let temp = readLine()!.map{String($0)}
    maxStrLen = max(maxStrLen, temp.count)
    strs.append(temp)
}

let numOfStr = strs.count

func fillX(){
    for idx in 0..<numOfStr{
        if strs[idx].count < maxStrLen{
            for _ in 0..<maxStrLen - strs[idx].count{
                strs[idx].insert("X", at: 0)
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
                if ch != "X"{
                    temp.append(String(letterDictionary[ch]!))
                }
            }
            sum += Int(temp.reduce(""){$0 + $1})!
        }
        maxSum = max(maxSum,sum)
        return
    }
    
    //단어 갯수만큼 반복하여 현재 selectedNum에서 1씩 줄여서
    for startIdx in 0..<numOfStr{
        var numOfX = 0
        for idx in startIdx..<startIdx + numOfStr{
            let str = strs[idx % numOfStr]
            let ch = str[numOfRepeat]
            if ch != "X" && letterDictionary[ch] == -1{
                letterDictionary[ch] = selectedNum
                selectedNum -= 1
            }
            //X인 경우
            else{
                numOfX += 1
            }
        }
        recursive(numOfRepeat + 1)
        selectedNum += numOfStr - numOfX
    }
}
fillX()
recursive(0)
print(maxSum)

