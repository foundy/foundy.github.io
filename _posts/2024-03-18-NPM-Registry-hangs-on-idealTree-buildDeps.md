# NPM - idealTree buildDeps 지연 현상


```bash
# 현재 NPM의 버전을 체크
> npm -v
10.2.4

# NPM 버전 업데이트 시도
> npm i -g npm
# ...sill idealTree buildDeps 출력 후 멈춘상태

# 현재 설정된 registry 체크 (기존에 ts-jest 관련 문제로 mirror로 변경했던 것 같음)
> npm config get registry
https://registry.npmjs.cf/

# 공식 npm registry 주소로 변경
> npm set registry https://registry.npmjs.org/
> npm config get registry
https://registry.npmjs.org/
```
