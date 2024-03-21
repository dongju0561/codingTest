/*
 별 찍기 - 10
 
 N = 3의 거듭제곱
 
 크기 3 = 가운데 공백 이외 칸은 *으로 채워짐
 
 if N > 3
 9 27 81 243 729 2187 6561
 
 */
 
let n = Int(readLine()!)!

func drawStar(n: Int, pattern: [String]) {
    if n == 1 {
        pattern.forEach {
            print($0)
        }
        return
    }
    
    let starLine = pattern.map { $0 + $0 + $0 }
    let emptyLine = pattern.map { $0 + String(repeating: " ", count: $0.count) + $0 }
    drawStar(n: n / 3, pattern: starLine + emptyLine + starLine)
}

drawStar(n: n, pattern: ["*"])
