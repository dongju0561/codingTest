let LC = readLine()!.split(separator: " ").map{Int(String($0))!}
let L = LC[0]
let C = LC[1]

/*
 암호 규칙
 한개의 모음 + 최소 두개의 자음
 모음(a, e, i, o, u)이 아닌 경우 자음
 알파벳 오름차순 정렬
 */
/*
 sort 메소드 VS sorted 메소드
 sort 메소드 = 정렬한 데이터를 자기 자신에게 저장
 sorted 메소드 = 정렬한 데이터를 반환, 해당 데이터 변경 x
 
 문자열 사전순으로 대소비교 가능
 */
let vowels = ["a","e","i","o","u"]
var letters: [String] = readLine()!.split(separator: " ").map{String($0)}
var visited: [Bool] = Array(repeating: false, count: C)
var numOfVowel = 0
var numOfConsonant = 0
var stack = [String]()
var answer = [String]()

func dfs(level: Int, start: Int){
    if level == L{
        if numOfVowel >= 1 && numOfConsonant >= 2{
            let temp = stack.sorted(by: {$0<$1})
            answer.append(temp.joined(separator: ""))
        }
    }
    for idx in start..<C{
        if !visited[idx]{
            visited[idx] = true
            if vowels.contains(letters[idx]){
                numOfVowel += 1
                stack.append(letters[idx])
            }
            else{
                numOfConsonant += 1
                stack.append(letters[idx])
            }
            dfs(level: level + 1,start: idx)
            if vowels.contains(letters[idx]){
                numOfVowel -= 1
            }
            else{
                numOfConsonant -= 1
            }
            stack.removeLast()
            visited[idx] = false
        }
    }
}
dfs(level: 0,start: 0)
answer.sort(by: {$0<$1})

_ = answer.map{print($0)}