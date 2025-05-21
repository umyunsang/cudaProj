# 동적 라이브러리 생성 및 링크 실습 가이드

이 문서는 C 소스 코드를 사용하여 동적 라이브러리(.so 파일)를 생성하고, 이에 대한 심볼릭 링크를 만드는 과정을 안내합니다.

## 실습 환경

*   운영체제: Linux
*   컴파일러: gcc

## 필요 파일 (예시)

*   `mymath.c`: 라이브러리로 만들 함수의 소스 코드 파일
*   `mymath.h`: 라이브러리 함수의 선언을 포함하는 헤더 파일
*   `main.c`: 생성된 라이브러리를 사용하는 예제 프로그램 (선택 사항)

## 실습 단계

1.  **소스 코드 컴파일 (목적 파일 생성)**

    먼저 라이브러리에 포함될 소스 코드(`mymath.c`)를 컴파일하여 위치 독립적인 코드(PIC)를 포함하는 목적 파일(`mymath.o`)을 생성합니다.

    ```bash
    gcc -fPIC -c mymath.c
    ```

    *   `-fPIC`: 공유 라이브러리에서 사용될 수 있도록 위치 독립적인 코드를 생성하는 옵션입니다.
    *   `-c`: 소스 파일을 컴파일만 하고 링크는 하지 않도록 지시하여 목적 파일을 생성합니다.

2.  **동적 라이브러리 생성**

    생성된 목적 파일(`mymath.o`)을 사용하여 동적 라이브러리(`libmymath.so.1.0.1`)를 생성합니다.

    ```bash
    gcc -W -Wall -shared -O2 -o libmymath.so.1.0.1 mymath.o
    ```

    *   `-shared`: 공유 라이브러리를 생성하도록 지시합니다.
    *   `-o libmymath.so.1.0.1`: 생성될 공유 라이브러리의 파일 이름을 `libmymath.so.1.0.1`로 지정합니다. 일반적으로 `lib[라이브러리이름].so.[주버전].[부버전].[패치버전]` 형식을 따릅니다.
    *   `-W -Wall`: 가능한 모든 경고를 표시하도록 합니다.
    *   `-O2`: 코드 최적화 레벨을 설정합니다.
    *   `mymath.o`: 라이브러리를 만드는 데 사용될 목적 파일입니다.

3.  **심볼릭 링크 생성**

    라이브러리 버전 관리를 용이하게 하고, 프로그램에서 라이브러리를 쉽게 링크할 수 있도록 심볼릭 링크를 생성합니다.

    ```bash
    ln -s libmymath.so.1.0.1 libmymath.so
    ```

    *   `ln -s`: 심볼릭 링크를 생성하는 명령어입니다.
    *   `libmymath.so.1.0.1`: 실제 라이브러리 파일입니다.
    *   `libmymath.so`: 생성될 심볼릭 링크의 이름입니다. 프로그램은 보통 `libmymath.so`와 같이 버전 정보가 없는 이름으로 라이브러리를 링크합니다.

## 확인

다음 명령어로 생성된 파일 및 링크를 확인할 수 있습니다.

```bash
ls -l
```

출력 예시:
```
합계 40
drwxrwxr-x 2 student_15030 student_15030  4096  5월 21 12:37 ./
drwxrwxr-x 4 student_15030 student_15030  4096  5월 21 12:24 ../
lrwxrwxrwx 1 student_15030 student_15030    18  5월 21 12:37 libmymath.so -> libmymath.so.1.0.1*
-rwxrwxr-x 1 student_15030 student_15030 15104  5월 21 12:34 libmymath.so.1.0.1*
-rw-rw-r-- 1 student_15030 student_15030   150  5월 21 12:28 main.c
-rw-rw-r-- 1 student_15030 student_15030    68  5월 21 12:28 mymath.c
-rw-rw-r-- 1 student_15030 student_15030    51  5월 21 12:28 mymath.h
-rw-rw-r-- 1 student_15030 student_15030  1224  5월 21 12:29 mymath.o
```

## 라이브러리 사용 (예제 프로그램 컴파일 및 실행)

생성된 동적 라이브러리를 사용하는 예제 프로그램(`main.c`)을 컴파일하고 실행하려면 다음 단계를 따릅니다. (이 부분은 터미널 로그에 없어 일반적인 방법을 안내합니다.)

1.  **프로그램 컴파일**

    ```bash
    gcc main.c -L. -lmymath -o main_program
    ```

    *   `-L.`: 현재 디렉터리(`.`)에서 라이브러리를 찾도록 경로를 지정합니다.
    *   `-lmymath`: `libmymath.so` 라이브러리를 링크하도록 지정합니다. (`lib` 접두사와 `.so` 확장자는 생략하고 `mymath`만 적습니다.)
    *   `-o main_program`: 실행 파일 이름을 `main_program`으로 지정합니다.

2.  **라이브러리 경로 설정**

    실행 시점에서 동적 링커가 라이브러리를 찾을 수 있도록 `LD_LIBRARY_PATH` 환경 변수에 라이브러리 경로를 추가해야 합니다.

    ```bash
    export LD_LIBRARY_PATH=$(pwd):$LD_LIBRARY_PATH
    ```
    또는 시스템 라이브러리 경로에 라이브러리를 설치할 수도 있습니다.

3.  **프로그램 실행**
    ```bash
    ./main_program
    ``` 