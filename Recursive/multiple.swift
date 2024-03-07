/*
 [백준] 곱셈
 
/*
 var result = A
 for _ in 0..<B{
 result *= A
 }
 result = result % C
*/

 -> 런타임 에러: 뭐가 문제일까?
 에러 내용!: Thread 1: Swift runtime failure: arithmetic overflow
 64비트 컴퓨터에서 Int 타입 64비트 범위 만큼 값을 저장한다.
 64비트 정수 표현 범위: -9223372036854775808 ~ 9223372036854775807
 A(2147483647)을 B(2147483647)번 곱셈을 진행하는 과정에서 9223372036854775807보다 큰 수가 Int 타입으로 설정된 변수에 저장하게 되고
 해당 변수는 overflow가 발생하게 된다. swift에서는 overflow가 발생하게 된다면 error 처리르 해준다.
 해결!: 한번에 A값을 B번 곱하는게 아니라 모듈러 성질을 이용하여 곱해야하는 수를 나머지 연산을 중간중간 진행하여 수가 정수표현범위를 넘지않고 계산을 진행하였습니다.
 
 지수법칙 : a^(n+m) = a^n * a^m
 모듈러 성질 : (a*b)%c = (a%c * b%c)%c        r % C * r % C * A % C     10 % 12 * 100 % 12 * 100 % 12 = 160
 모듈러 분배법칙: (a%c * b%c)%c == (a%c)%c * (b%c)%c 참!
 
 그래서 
 10^11%12 == (10%12 * 10^5%12 * 10^5%12)%12
 (10%12 * 10^2%12 * 10^2%12)%12 == (10 * 10^2 * 10^2)%12
 
 10^2%12 == (10^1%12 * 10^1%12)%12
 
 재귀함수를 활용해서 문제를 해결하는 이유는?
 반복되는 연산을 분할하기 위해서
 
 착각했던 사실
 모듈러 성질을 모르고 있는 상황에서 % 연산자가 * 연산자보다 먼저 실행된다고 착각...
 모듈러 성질 고려
 r % C * r % C * A % C -> (r * r * A)% C
 r % C * r % C -> (r * r) % C
 
 */

/*
 A^B%C
 
 B가 홀수 일때
 (A^B)%C == ((A%C)*(A^B/2%C)*(A^B/2%C))%C
 A^B = (A%C)*(A^B/2%C)*(A^B/2%C) == r(변화하는 수식)
 (A^B)%C == r%C
 (A^B)%C == ((A%C) * r%C * r%C)%C
 
 
 B가 짝수 일때
 (A^B)%C == ((A^B/2%C)*(A^B/2%C))%C
 A ^ B == (A^B/2%C)*(A^B/2%C) == r(변화하는 수식)
 (A^B)%C == r%C
 (A^B)%C == (r%C * r%C)%C
 
 반복되는 연산
 
 B가 0 일때
 A^B%C == 1
 */

import Foundation
let ABC = readLine()!.split(separator: " ").map{Int(String($0))!}
let A = ABC[0]
let B = ABC[1]
let C = ABC[2]

func recursive(N: Int) -> Int{
    if N == 0{return 1}
    
    if N % 2 == 0{
        let r = recursive(N: N/2)
        return (r % C* r% C) % C
    }else {
        let r = recursive(N: (N-1)/2)
        return (r%C * r%C * A%C)%C
        //r % C * r % C * A % C -> 
        //지수법칙 : a^(n+m) = a^n * a^m
        //모듈러 성질 : (a*b)%c = (a%c * b%c)%c 
        //모듈러 분배법칙: (a%c * b%c)%c == (a%c)%c * (b%c)%c 
        //(a*b)%c = (a%c * b%c)%c == (a%c)%c * (b%c)%c 
        /*
        -반례-
        10^11%12 일때 첫번째 재귀 함수의 리턴값은 
        r % C * r % C * A % C == 10%12 * 4 %12 * 4 %12
        이때 계산기를 돌려보면 10^5%12 = 4
        10%12 * 4 %12 * 4 %12
        앞에부터 연산 => 160
        정답은 => 4

        
        */
    }
}

print(recursive(N: B))


