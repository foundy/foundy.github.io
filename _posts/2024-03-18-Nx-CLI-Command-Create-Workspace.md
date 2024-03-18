---
title: Nx CLI Command - Workspace 생성
date: 2024-03-18 10:30:00 +0800
categories: [Nx, MicroFrontends, Monorepo]
tags: [nx, react, react-monorepo, nonorepo, create-nx-workspace, mfe, microfrontend, microfrontends]     # TAG names should always be lowercase
---

> [Nx Docs](https://nx.dev/nx-api/nx/documents/create-nx-workspace)에는 간략하게 설명되어 있어 파악이 어려운 부분들을 정리하고자 작성한 포스트입니다.
> 
> Version: create-nx-workspace@18.1.1

# create-ax-workspace
Nx workspace를 생성합니다.  (참고: [create-nx-workspace - CLI command](https://nx.dev/nx-api/nx/documents/create-nx-workspace))

## Usage
```bash
create-nx-workspace [name] [options]
```

자주 사용하는 명령어도 아니니 굳이 Global 설치를 해야 할 필요는 없습니다.
```bash
# npx
> npx create-nx-workspace [name] [options]

# yarn
> yarn create nx-workspace [name] [options]

# pnpm
> pnpx create-nx-workspace [name] [options]
```

`name`은 `--name` 옵션과 동일합니다.
```bash
# name을 아래와 같이 option으로 사용 가능합니다.
> pnpx create-nx-workspace --name=sample-workspace
Packages: +56
++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Progress: resolved 56, reused 56, downloaded 0, added 56, done

 NX   Let's create a new workspace [https://nx.dev/getting-started/intro]

? Which stack do you want to use? …
None:          Configures a TypeScript/JavaScript project with minimal structure.
React:         Configures a React application with your framework of choice.
Vue:           Configures a Vue application with your framework of choice.
Angular:       Configures a Angular application with modern tooling.
Node:          Configures a Node API application with your framework of choice.
```

## Options

| Name           | Type    | Default        | Description                                                  |
|----------------|---------|----------------|--------------------------------------------------------------|
| allPrompts     | boolean | false          | true인 경우 아래 대화형 프롬프트를 추가로 보여줍니다.<br>- 메인 브랜치 명 (default main)<br>- 패키지 매니저 (default NPM) |
| appName        | string  |                | 특정 스택과 함께 Monorepo를 사용할 때의 Application 이름입니다.<br>스택으로는 `none`, `react`, `vue`, `angular`, `node`가 있습니다. |
| bundler        | string  |                | Application 빌드시 사용될 번들러 입니다.<br>스택에 따라 선택하는 번들러가 다릅니다.<br>React의 경우  `vite`, `webpack`, `rspack` 중 선택이 가능합니다. |
| commit.email   | string  |                | Git 커밋 작성자 이메일 입니다.<br>workspace 생성시 초기화 커밋에 추가할 정보입니다.<br>`commit`에 대한 명령어는 굳이 구현할 필요가 있었을까 싶습니다. |
| commit.message | string  | Initial commit | Git 커밋 메시지 입니다.                                              |
| commit.name    | string  |                | Git 커밋 작성자 이름 입니다.                                           |
| defaultBase    | string  | main           | 기본 브랜치 명 입니다.<br>주로 `master`로 하고 싶은 경우 사용합니다.                |
| docker         | boolean |                | Node API용 Dockerfile을 생성합니다.                                 |
| e2eTestRunner  | string  |                | E2E 테스트를 위한 테스트 러너 입니다.<br>- `cypress`, `playwright`, `none` 중 선택 |
| framework      | string  |                | 특정 스택과 함께 사용될 프레임워크 입니다.<br>React의 경우 `none`, `nextjs`, `remix`, `expo`, `react-native` 중 선택이 가능합니다. |
| help           | boolean |                | 도움말을 보여줍니다.                                                  |
| interactive    | boolean | true           | presets 설정으로 대화형 모드를 활성화 합니다.                                |
| name           | string  |                | Workspace 이름입니다.<br>생성되는 폴더이며, `package.json`의 `name` 속성에 반영되는 Scope입니다.<br>e.g. @org/sample |
| nextAppDir     | boolean |                | Next.js 용 Application 라우터를 활성화 합니다.                          |
| nextSrcDir     | boolean |                | Next.js 용 `src/` 디렉토리를 생성 합니다.                               |
| nxCloud        | string  |                | Nx Cloud로 CI 기능을 이용하는 경우 사용합니다.<br>- `yes`, `github`, `circleci`, `skip` 중 선택<br>자세한 내용은 [Fast CI · Built for Monorepos](https://nx.app/)에서 확인 가능하며, 플랜에 따라 비용이 발생합니다. |
| packageManager | string  | npm            | 사용할 패키지 매니저 입니다.<br>- `npm`, `yarn`, `pnpm` 중 선택             |
| prefix         | string  |                | Angular 컴포넌트 및 디렉티브에 사용될 Prefix 입니다.                         |
| preset         | string  |                | Workspace의 초기 콘텐츠 세팅시 사용되는 preset 입니다.<br>기본 preset 구성은 [create-nx-workspace - preset](https://nx.dev/nx-api/nx/documents/create-nx-workspace#preset)을 참고해 주세요.<br>별도로 커스터마이징이 가능한데, 이에 대한 설명은 [Create a Preset](https://nx.dev/extending-nx/recipes/create-preset)에서 참고 가능합니다. |
| routing        | boolean | true           | Angular Application에 대한 라우팅 설정을 추가합니다.                       |
| skipGit        | boolean | false          | Git 초기화 설정을 Skip 합니다. (`git init`이 실행되지 않은 폴더 및 파일 구성만 있는 상태) |
| ssr            | boolean |                | Angular Application에 대한 SSR(서버 사이드 렌더링)과 SSG(정적 사이트 제네레이션)를 활성화합니다. |
| standaloneApi  | boolean | true           | Angular Application을 생성하는 경우 독립형 컴포넌트로 사용합니다.<br>create-nx-workspace의 test 코드를 보면 standaloneApi 옵션에 대한 검증은 angular-standalone preset 기준으로 작성되어 있다. |
| style          | string  |                | 특정 스택과 함께 사용되는 Stylesheet 유형입니다.<br>React의 경우 `css`, `sass`, `less`, `tailwind`, `styled-components`, `emotion`, `styled-jsx` 중 선택이 가능합니다. |
| version        | boolean |                | create-nx-workspace의 버전 정보를 보여줍니다.                           |
| workspaceType  | string  |                | 생성할 workspace의 유형입니다.<br>- `integrated`, `package-based`, `standalone` 중 선택<br>스택에 따라 `package-based` 선택이 가능합니다.<br>Monorepo 구성인 경우  `integrated`, 독립형 구성인 경우 `standalone`으로 구분하면 됩니다. |

## Demo
아래는 `React Monorepo` 구성을 위해 대화형을 사용하지 않고, 옵션을 지정한 예시입니다.
```bash
# React Monorepo 구성으로 Nx Workspace 생성
> pnpx create-nx-workspace@18 --appName=myApp --bundler=webpack --defaultBase=master --e2eTestRunner=cypress --framework=none --name=sample-workspace --nxCloud=skip --packageManager=pnpm --preset=react-monorepo --style=styled-components --workspaceType=integrated

Packages: +56
++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Progress: resolved 56, reused 56, downloaded 0, added 56, done

 NX   Let's create a new workspace [https://nx.dev/getting-started/intro]

 NX   Creating your v18.1.1 workspace.

✔ Installing dependencies with pnpm
✔ Successfully created the workspace: sample-workspace.

 NX   Nx CLI is not installed globally.

This means that you will have to use "npx nx" to execute commands in the workspace.
Run "npm i -g nx" to be able to execute command directly.

 NX   First time using Nx? Check out this interactive Nx tutorial.

https://nx.dev/react-tutorial/1-code-generation
```

위 명령어를 기반으로 생성된 결과를 Tree로 보면 아래와 같이 나옵니다.
```bash
.
├── .nx
│   └── cache
│       ├── file-map.json
│       ├── lockfile.hash
│       ├── parsed-lock-file.json
│       └── project-graph.json
├── .vscode
│   └── extensions.json
├── apps
│   ├── my-app
│   │   ├── src
│   │   │   ├── app
│   │   │   │   ├── app.spec.tsx
│   │   │   │   ├── app.tsx
│   │   │   │   └── nx-welcome.tsx
│   │   │   ├── assets
│   │   │   │   └── .gitkeep
│   │   │   ├── favicon.ico
│   │   │   ├── index.html
│   │   │   └── main.tsx
│   │   ├── .babelrc
│   │   ├── .eslintrc.json
│   │   ├── jest.config.ts
│   │   ├── project.json
│   │   ├── tsconfig.app.json
│   │   ├── tsconfig.json
│   │   ├── tsconfig.spec.json
│   │   └── webpack.config.js
│   └── my-app-e2e
│       ├── src
│       │   ├── e2e
│       │   │   └── app.cy.ts
│       │   ├── fixtures
│       │   │   └── example.json
│       │   └── support
│       │       ├── app.po.ts
│       │       ├── commands.ts
│       │       └── e2e.ts
│       ├── .eslintrc.json
│       ├── cypress.config.ts
│       ├── project.json
│       └── tsconfig.json
├── .editorconfig
├── .eslintignore
├── .eslintrc.json
├── .gitignore
├── .npmrc
├── .prettierignore
├── .prettierrc
├── README.md
├── jest.config.ts
├── jest.preset.js
├── nx.json
├── package.json
├── pnpm-lock.yaml
└── tsconfig.base.json

13 directories, 43 files
```

이와 같은 기본적인 구성이 되면 이후에 Nx Generator를 통해 React host 또는 remote application을 생성하여 module federation 구성을 진행할 수 있습니다.
