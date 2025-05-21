# Makefile 실습 가이드

이 문서는 간단한 C 프로그램을 `make` 유틸리티와 `Makefile`을 사용하여 빌드하는 과정을 안내합니다.

## 실습 목표

*   `Makefile`의 기본 구조 이해
*   의존성 관리를 통한 효율적인 컴파일 과정 이해
*   목적 파일(.o) 생성 및 최종 실행 파일 빌드 과정 이해

## 필요 파일

*   `Makefile`: 빌드 규칙을 정의하는 파일
*   `main.c`: 주 프로그램 로직을 포함하는 C 소스 파일
*   `test1.c`: `test1` 함수를 포함하는 C 소스 파일
*   `test2.c`: `test2` 함수를 포함하는 C 소스 파일
*   `test.h`: `test1` 및 `test2` 함수의 선언을 포함하는 헤더 파일

## Makefile 내용 분석

```makefile
test.exe: main.o test1.o test2.o
	gcc -o test.exe main.o test1.o test2.o

main.o: main.c test.h
	gcc -c main.c

test1.o: test1.c test.h
	gcc -c test1.c

test2.o: test2.c test.h
	gcc -c test2.c
```

*   **`test.exe: main.o test1.o test2.o`**:
    *   `test.exe`는 최종 목표(target)입니다.
    *   `main.o`, `test1.o`, `test2.o`는 `test.exe`를 만들기 위한 의존성(dependency) 파일들입니다.
    *   `gcc -o test.exe main.o test1.o test2.o`는 `test.exe`를 생성하기 위한 명령(command)입니다.
*   **`main.o: main.c test.h`**:
    *   `main.o`는 목적 파일 목표입니다.
    *   `main.c`와 `test.h`는 `main.o`를 만들기 위한 의존성 파일들입니다.
    *   `gcc -c main.c`는 `main.c`를 컴파일하여 `main.o`를 생성하는 명령입니다. `-c` 옵션은 링크 없이 컴파일만 진행하여 목적 파일을 생성합니다.
*   **`test1.o: test1.c test.h`** 및 **`test2.o: test2.c test.h`** 도 유사한 구조로 각 소스 파일을 컴파일하여 목적 파일을 생성합니다.

## 빌드 과정

1.  터미널에서 `make_sys` 디렉토리로 이동합니다.
    ```bash
    cd ~/cudaProj/make_sys
    ```
2.  `make` 명령어를 실행합니다.
    ```bash
    make
    ```
3.  `make` 유틸리티는 `Makefile`의 첫 번째 목표인 `test.exe`를 빌드하려고 시도합니다.
4.  `test.exe`를 빌드하기 위해 의존성인 `main.o`, `test1.o`, `test2.o`가 필요한지 확인합니다.
5.  각 `.o` 파일이 없거나, 해당 `.c` 또는 `.h` 파일이 `.o` 파일보다 최신인 경우, 각 `.o` 파일을 생성하기 위한 규칙이 실행됩니다.
    *   예를 들어, `main.o`를 만들기 위해 `main.c`가 컴파일됩니다.
6.  모든 목적 파일이 준비되면, `test.exe`를 생성하기 위한 링크 명령이 실행됩니다.

## 오류 해결 과정 (예시)

실습 중 발생했던 오류와 해결 과정은 다음과 같습니다.

*   **`test1.c` 오류**:
    *   **오류 메시지**: `test1.c:5:1: error: expected identifier or ‘(’ before ‘{’ token`
    *   **원인**: 함수 정의 시 `{`가 잘못된 위치에 있었습니다.
    *   **해결**: `void test1(void)` 바로 다음 줄에 `{`를 위치하도록 수정했습니다.
        ```c
        /* 이전 코드 */
        // void test1(void);
        //
        // {
        // }

        /* 수정된 코드 */
        void test1(void)
        {
        }
        ```

*   **`test2.c` 경고**:
    *   **경고 메시지**: `warning: implicit declaration of function ‘printf’`
    *   **원인**: `printf` 함수를 사용하기 위해 필요한 `<stdio.h>` 헤더 파일이 포함되지 않았습니다.
    *   **해결**: `test2.c` 파일 상단에 `#include <stdio.h>`를 추가했습니다.
        ```c
        /* 이전 코드 */
        // /* file - test2.c */
        //
        // void test2(void)
        // {
        //     printf("test2\n");
        // }

        /* 수정된 코드 */
        /* file - test2.c */
        #include <stdio.h>

        void test2(void)
        {
            printf("test2\n");
        }
        ```

## 실행

빌드가 성공적으로 완료되면 `test.exe` 실행 파일이 생성됩니다. 다음 명령으로 실행할 수 있습니다.

```bash
./test.exe
``` 