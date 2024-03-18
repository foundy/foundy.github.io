---
title: NPM CLI 명령어로 package.json 버전 관리하기 (백업 복원)
date: 2024-03-02 05:00:00 +0800
categories: [NPM, VERSIONING]
tags: [npm, versioning]     # TAG names should always be lowercase
---

# Blog 백업 - NPM CLI 명령어로 package.json 버전 관리하기
> package.json의 version

javascript 프로젝트를 진행하다 보면 버전관리를 위해 package.json의 version 정보를 활용하는 경우가 많습니다.

* npm 모듈로 등록된 패키지 버전 관리를 위해 사용
* bundle 또는 minify된 파일에 주석으로 배너형 표기
* package.json을 require(import)하여 Property로 버전 명시

이와같이 다양하게 활용할 수 있습니다. (물론 version 파일을 따로 관리하는 경우도 있습니다.)

그런데 사용하다보면 버전 업데이트 규칙도 자동으로 제어 되었으면 하는 바람도 생기고, 수동으로 관리하는게 생각보다 귀찮아질 때가 있습니다.

git hook이나 shell 설정 또는 npm script에 추가해서 사용할 수도 있겠지만.. 간편하게 사용하기에는 npm 내장 명령어를 사용하는 것도 좋을 것 같아 정리해봅니다.

참고로 package.json의 version은 [Semantic Versioning](https://semver.org/)을 기준으로 명시를 하는데 npm Dependencies로 사용되는 [semver](https://github.com/npm/node-semver) 유틸리티를 사용하여 응용도 가능합니다.

> 수동 업데이트 귀차니즘

버전을 수동으로 업데이트 하다보면 수정하고 커밋하는 일련의 작업들 마저도 귀찮을 때가 있습니다. 이런 경우 npm 명령어를 사용하면 보다 쉽게 관리할 수 있습니다.

npm 문서에 [CLI Commands](https://docs.npmjs.com/)를 보면 많은 기능들이 지원되는데 그 중에 [version](https://docs.npmjs.com/cli/version) 명령어가 있습니다.

이 [version](https://docs.npmjs.com/cli/version) 명령어를 사용하여 관리하는 방법에 대해 살펴 보겠습니다.

- - -

### Usage
`npm version [<newversion> | major | minor | patch | premajor | preminor | prepatch | prerelease | from-git]`

### Version format
`<major>.<minor>.<patch>[-<pre-release>+<metadata>]`

### Release arguments
각 argument에 따라 해당 자리의 버전이 증가되고, *Commit*과 *Tag*가 자동으로 생성됩니다.  
우선 정식 버전을 업데이트하는 `[<newversion> | major | minor | patch]` 명령어를 예제로 살펴보겠습니다.

##### newversion
사용자 정의 버전입니다.

```
$ cat package.json | grep version
"version": "1.0.0",
$ npm version 2.1.1
v2.1.1
$ git log --oneline -1
43f2df4 2.1.1
$ git tag -l
v2.1.1
$ cat package.json | grep version
"version": "2.1.1",
```

자동으로 *Commit*과 *Tag*가 생성되고, 버전은 *v1.0.0*에서 *v2.1.1*로 업데이트 되었습니다.
순차적으로 증가되는 형태가 아닌 버전을 직접 명시할 수 있습니다.

##### major

```
$ cat package.json | grep version
"version": "1.0.0",
$ npm version major
v2.0.0
$ git log --oneline -1
beda9bf 2.0.0
$ git tag -l
v2.0.0
$ cat package.json | grep version
"version": "2.0.0",
```

자동으로 *Commit*과 *Tag*가 생성되고, 버전은 *v1.0.0*에서 *v2.0.0*으로 업데이트 되었습니다.

##### minor

```
$ cat package.json | grep version
"version": "1.0.0",
$ npm version minor
v1.1.0
$ git log --oneline -1
16acfc8 1.1.0
$ git tag -l
v1.1.0
$ cat package.json | grep version
"version": "1.1.0",
```
자동으로 *Commit*과 *Tag*가 생성되고, 버전은 *v1.0.0*에서 *v1.1.0*으로 업데이트 되었습니다.

##### patch

```
$ cat package.json | grep version
"version": "1.0.0",
$ npm version patch
v1.0.1
$ git log --oneline -1
51d070c 1.0.1
$ git tag -l
v1.0.1
$ cat package.json | grep version
"version": "1.0.1",
```
마찬가지로 *Commit*과 *Tag*가 생성됩니다. 버전은 *v1.0.0*에서 *v1.0.1*로 업데이트 되었습니다.

### Pre-release arguments
정식 배포를 하기 전 버전의 업데이트 명령어를 살펴보겠습니다.  
정식 버전 명령어와는 다르게 `-` 구분자가 추가되고, 구분자 뒤에 정식 배포 전 버전을 표기하기 위한 카운트가 추가됩니다.
그리고 마찬가지로 *Commit*과 *Tag*가 자동 생성됩니다.

##### premajor

```
$ cat package.json | grep version
"version": "1.0.0",
$ npm version premajor
v2.0.0-0
```
`<major>` 버전이 증가하고, `-` 구분자 뒤에 *pre-release*를 위한 카운트가 추가됩니다.

##### preminor

```
$ cat package.json | grep version
"version": "1.0.0",
$ npm version preminor
v1.1.0-0
```

`<minor>` 버전이 증가하고, `-` 구분자 뒤에 *pre-release*를 위한 카운트가 추가됩니다.

##### prepatch

```
$ cat package.json | grep version
"version": "1.0.0",
$ npm version prepatch
v1.0.1-0
```

`<patch>` 버전이 증가하고, `-` 구분자 뒤에 *pre-release*를 위한 카운트가 추가됩니다.

##### prerelease

```
$ cat package.json | grep version
"version": "1.0.0",
$ npm version prerelease
v1.0.1-0
```

*pre-release*를 위한 카운트가 없을 경우 기본으로 `<patch>` 버전이 증가하고, `-` 구분자 뒤에 *pre-release*를 위한 카운트가 추가됩니다.

##### from-git

최근 *Tag*의 버전을 적용합니다.

```
$ cat package.json | grep version
"version": "1.0.0",
$ echo 'foo' >> README.md
$ git commit -am 'update README.md'
[master 4ed3042] update README.md
 1 file changed, 1 insertion(+)
$ git tag -a v1.0.1 -m 'Version 1.0.1'
$ git log --oneline --decorate=full -1
4ed3042 (HEAD -> refs/heads/master, tag: refs/tags/v1.0.1) update README.md
$ npm version from-git
v1.0.1
$ git log --oneline --decorate=full -2
5536080 (HEAD -> refs/heads/master) 1.0.1
4ed3042 (tag: refs/tags/v1.0.1) update README.md
```

이 명령어는 어떠한 상황에 사용할지 감이 오지는 않네요. 대략 *Tag*를 별도로 지정하고 해당 *Tag* 기준으로 업데이트를 한다는 정도로 이해하고 있습니다.

참고로 *Tag* 사용할때 *Lightweight Tag* 대신 *Annotated Tag*를 사용해야 합니다.  
*Lightweight Tag*를 사용하게 되면 아래와 같이 `git describe`로 인해 오류가 발생합니다. (참고: [Lightweight & Annotated](https://git-scm.com/book/ko/v1/Git%EC%9D%98-%EA%B8%B0%EC%B4%88-%ED%83%9C%EA%B7%B8))

```
$ cat package.json | grep version
"version": "1.0.0",
$ echo 'foo' >> README.md
$ git commit -am 'update README.md'
[master 5c3d466] update README.md
 1 file changed, 1 insertion(+)
$ git tag v1.0.1
$ git log --oneline --decorate=full -1
5c3d466 (HEAD -> refs/heads/master, tag: refs/tags/v1.0.1) update README.md
$ npm version from-git
...생략
npm ERR! Command failed: git describe --abbrev=0
npm ERR! fatal: No annotated tags can describe '5c3d46676d8ee9b6353efed9acfe3565a9b3d3ea'.
npm ERR! However, there were unannotated tags: try --tags.
...생략
```

### Options
arguments와 함께 사용되는 옵션입니다.

##### -m or --message
*Commit* 메시지를 정의할 수 있습니다.

```
$ cat package.json | grep version
"version": "1.0.0",
$ npm version patch -m 'Version: %s'
v1.0.1
$ git log --oneline -1
60c5544 Version: 1.0.1
```

`%s`를 사용하면 적용되는 버전으로 바꿔줍니다. 보시다시피 *Commit* 메시지에 `%s`가 *1.0.1*로 변경되어 있습니다.

##### --no-git-tag-version
*Commit*과 *Tag* 생성을 비활성화 합니다.

```
$ cat package.json | grep version
"version": "1.0.0",
$ npm version patch --no-git-tag-version
v1.0.1
$ git status
...생략
modified:   package.json
...생략
$ cat package.json | grep version
"version": "1.0.1",
```

`git status`로 보면 *package.json* 파일이 *modified* 상태로 출력됩니다. *Commit*과 *Tag*가 자동으로 생성되지 않고 변경된 상태로만 남게 됩니다.

이 옵션은 아래 예시와 같이 *NPM* 환경설정에 [git-tag-version](#git-tag-version) 옵션으로 *Global*하게 설정도 가능합니다.
```
$ npm config set git-tag-version=false
$ cat ~/.npmrc
git-tag-version=false
$ npm version patch
v1.0.1
$ git status
...생략
modified:   package.json
...생략
$ cat package.json | grep version
"version": "1.0.1",
```

##### -f or --force

기본적으로 작업 디렉토리가 *Clean* 상태가 아닌 경우에는 버전 업데이트가 실패됩니다.  
이 옵션을 사용하면 *Clean* 상태가 아닌 경우에도 강제로 버전 업데이트를 실행 할 수 있습니다.

```
$ cat package.json | grep version
"version": "1.0.0",
$ echo 'foo' >> README.md
$ git status
...생략
modified:   README.md
...생략
$ npm version patch
...생략
npm ERR! Git working directory not clean.
npm ERR! M README.md
...생략
$ npm version patch -f
npm WARN using --force I sure hope you know what you are doing.
v1.0.1
$ git log --oneline -1
96deed7 1.0.1
$ git status
...생략
modified:   README.md
...생략
```

이와같이 **-f** 옵션을 주지 않을 경우 *not clean* 오류가 발생하고, **-f** 옵션을 주게되면 경고 메시지와 함께 실행 결과를 출력합니다.  
`git status`로 상태를 보면 *modified* 상태가 유지됩니다.

### Configuration
NPM config 환경 변수입니다.

##### git-tag-version

[--no-git-tag-version](#no-git-tag-version) 옵션과 동일한 기능으로 CLI 명령어 대신 NPM 환경설정으로 사용할 수 있습니다.

##### sign-git-tag

*GIT*의 *GPG*를 이용하여 *Tag*에 서명을 사용하는 부분 입니다. 설정값이 `true`이면 `npm version` 명령어 내부에서 *Tag*를 생성할때 `-s` 플래그를 사용하도록 합니다.

예를들면 아래와 같이 `-s` 플래그를 사용하는 것과 같습니다.

`git tag -s v1.1.0 -m 'Version 1.1.0'`

이 설정에 대한 자세한 내용은 [Git 도구 - 내 작업에 서명하기](https://git-scm.com/book/ko/v2/Git-%EB%8F%84%EA%B5%AC-%EB%82%B4-%EC%9E%91%EC%97%85%EC%97%90-%EC%84%9C%EB%AA%85%ED%95%98%EA%B8%B0)를 참고하시면 좋을 것 같습니다.

### 응용편 첫번째
pre-release를 통해 카운트하여 정식 버전을 release합니다.

```
$ cat package.json | grep version
"version": "1.0.0",
$ npm version patch
v1.0.1
$ npm version minor
v1.1.0
$ npm version premajor
v2.0.0-0
$ npm version prerelease
v2.0.0-1
$ npm version prerelease
v2.0.0-2
$ npm version major
v2.0.0
$ npm version preminor
v2.1.0-0
$ npm version prerelease
v2.1.0-1
$ npm version minor
v2.1.0
```

### 응용편 두번째
`alpha`, `beta`, `rc` 등의 상태코드를 명시하는 과정이 필요할 때도 있습니다.  
정식 배포를 하기까지의 버저닝 과정을 예제를 통해 살펴보겠습니다.

npm init 또는 package.json 생성 시에 version을 1.0.0-alpha로 시작하는 예시를 보겠습니다.
```
$ cat package.json | grep version
"version": "1.0.0-alpha",
$ npm version prerelease
v1.0.0-alpha.0
$ npm version prerelease
v1.0.0-alpha.1
$ npm version 1.0.0-beta
v1.0.0-beta
$ npm version prerelease
v1.0.0-beta.0
$ npm version prerelease
v1.0.0-beta.1
$ npm version 1.0.0-rc.1
v1.0.0-rc.1
$ npm version prerelease
v1.0.0-rc.2
$ npm version major
v1.0.0
```

보시다시피 식별자를 두는 형태는 좀 불편한 감이 있습니다.  
현재 npm version 명령어에는 [npmversion](https://github.com/rochejul/npmversion) 처럼 다양한 형태의 옵션을 지원하지는 않습니다.

### Outputs
버전별로 명령어에 따라 출력되는 결과를 나열 해보았습니다.

##### *v1.0.0*
```
npm version major           # v2.0.0
npm version minor           # v1.1.0
npm version patch           # v1.0.1
npm version premajor        # v2.0.0-0
npm version preminor        # v1.1.0-0
npm version prepatch        # v1.0.1-0
npm version prerelease      # v1.0.1-0
```

##### *v1.1.0*
```
npm version major           # v2.0.0
npm version minor           # v1.2.0
npm version patch           # v1.1.1
npm version premajor        # v2.0.0-0
npm version preminor        # v1.2.0-0
npm version prepatch        # v1.1.1-0
npm version prerelease      # v1.1.1-0
```

##### *v1.1.1*
```
npm version major           # v2.0.0
npm version minor           # v1.2.0
npm version patch           # v1.1.2
npm version premajor        # v2.0.0-0
npm version preminor        # v1.2.0-0
npm version prepatch        # v1.1.2-0
npm version prerelease      # v1.1.2-0
```

##### *v1.0.0-beta*
```
npm version major           # v1.0.0
npm version minor           # v1.0.0
npm version patch           # v1.0.0
npm version premajor        # v2.0.0-0
npm version preminor        # v1.1.0-0
npm version prepatch        # v1.0.1-0
npm version prerelease      # v1.0.0-beta.0
```

##### *v1.1.0-beta*
```
npm version major           # v2.0.0
npm version minor           # v1.1.0
npm version patch           # v1.1.0
npm version premajor        # v2.0.0-0
npm version preminor        # v1.2.0-0
npm version prepatch        # v1.1.1-0
npm version prerelease      # v1.1.0-beta.0
```

##### *v1.1.1-beta*
```
npm version major           # v2.0.0
npm version minor           # v1.2.0
npm version patch           # v1.1.1
npm version premajor        # v2.0.0-0
npm version preminor        # v1.2.0-0
npm version prepatch        # v1.1.2-0
npm version prerelease      # v1.1.1-beta.0
```

- - -

### 도움이 될 만한 링크

* NPM CLI version : https://docs.npmjs.com/cli/version
* Github node-semver: https://github.com/npm/node-semver
* Semantic Versioning: https://semver.org/
* Semantic Versioning - 김대현님 번역본: https://semver.org/lang/ko/
