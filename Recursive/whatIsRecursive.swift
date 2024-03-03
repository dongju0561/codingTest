/*
 
 [백준] 재귀함수가 뭔가요?
 
 어느 한 컴퓨터공학과 학생이 유명한 교수님을 찾아가 물었다.
 
 "1) 재귀함수가 뭔가요?"
 
 "2) 잘 들어보게. 옛날옛날 한 산 꼭대기에 이세상 모든 지식을 통달한 선인이 있었어.
 마을 사람들은 모두 그 선인에게 수많은 질문을 했고, 모두 지혜롭게 대답해 주었지.
 그의 답은 대부분 옳았다고 하네. 그런데 어느 날, 그 선인에게 한 선비가 찾아와서 물었어."
 
 ____"1) 재귀함수가 뭔가요?"
 
 ____"2) 잘 들어보게. 옛날옛날 한 산 꼭대기에 이세상 모든 지식을 통달한 선인이 있었어.
 ____마을 사람들은 모두 그 선인에게 수많은 질문을 했고, 모두 지혜롭게 대답해 주었지.
 ____그의 답은 대부분 옳았다고 하네. 그런데 어느 날, 그 선인에게 한 선비가 찾아와서 물었어."
 
 ________"1) 재귀함수가 뭔가요?"
 
 ________"3) 재귀함수는 자기 자신을 호출하는 함수라네"
 
 ________4) 라고 답변하였지.
 
 ____4) 라고 답변하였지.
 
 4) 라고 답변하였지.
 */

let numOfRecursive = Int(readLine()!)!
let level = 0

print("어느 한 컴퓨터공학과 학생이 유명한 교수님을 찾아가 물었다.")

func printUnderBar(_ numOfRepeat: Int){
    let underBar = "____"
    for _ in 0..<numOfRepeat{
        print(underBar,terminator: "")
    }
}

func recursive(_ count: Int,_ numOfRepeat: Int){
    //1) 재귀함수를 실행하고 처음 실행되는 영역
    printUnderBar(numOfRepeat)
    print("\"재귀함수가 뭔가요?\"")
    //끝
    
    //재귀함수를 호출하는 조건
    if count > 0{
        //2) 재귀함수 호출 조건에 만족했을때 함수 호출 전 실행되는 영역
        printUnderBar(numOfRepeat)
        print("\"잘 들어보게. 옛날옛날 한 산 꼭대기에 이세상 모든 지식을 통달한 선인이 있었어.")
        printUnderBar(numOfRepeat)
        print("마을 사람들은 모두 그 선인에게 수많은 질문을 했고, 모두 지혜롭게 대답해 주었지.")
        printUnderBar(numOfRepeat)
        print("그의 답은 대부분 옳았다고 하네. 그런데 어느 날, 그 선인에게 한 선비가 찾아와서 물었어.\"")
        //끝
        
        //재귀 함수 호출
        recursive(count - 1, numOfRepeat + 1)
        
        //4)재귀 함수로부터 반환받고 직후 실행되는 영역
        printUnderBar(numOfRepeat)
        print("라고 답변하였지.")
        //끝
    }
    else{
        //3) 재귀 함수 반환하기 전 실행되는 영역
        printUnderBar(numOfRepeat)
        print("\"재귀함수는 자기 자신을 호출하는 함수라네\"")
        printUnderBar(numOfRepeat)
        print("라고 답변하였지.")
        //끝
        
        return
    }
}
recursive(numOfRecursive,level)
