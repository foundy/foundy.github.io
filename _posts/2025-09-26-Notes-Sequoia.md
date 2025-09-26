---
title: "(Note) Tahoe 어택으로 Sequoia 다운그레이드 😢"
date: 2025-09-26 10:00:00 +0900
categories: [Notes, macOS]
tags: [notes, macOS, Sequoia, Tahoe]
---

## 노트
맥북 프로 인텔 코어 모델에다가 macOS Tahoe를 설치했더니… 성능이 확 떨어지고 자잘한 문제들이 너무 많았다..  
이대로는 도저히 쓸 수가 없겠다 싶어서 결국 Sequoia를 클린 설치하기로 결정.

Sequoia 설치 USB 만들기:
```bash
sudo /Applications/Install\ macOS\ Sequoia.app/Contents/Resources/createinstallmedia --volume /Volumes/MacOS
Password:
Ready to start.
To continue we need to erase the volume at /Volumes/MacOS.
If you wish to continue type (Y) then press return: y
Erasing disk: 0%... 10%... 20%... 30%... 100%
Copying essential files...
Copying the macOS RecoveryOS...
Making disk bootable...
Copying to disk: 0%... 10%... 20%... 30%... 40%... 50%... 60%... 70%... 80%... 90%... 100%
Install media now available at "/Volumes/Install macOS Sequoia"
```

앞으로는 이런 상황에 대비해서 타임머신 설정을 좀 해둬야겠다.  
이걸 핑계로 맥 스튜디오를?😄

### + Error: This request has been automatically failed because it uses a deprecated version of `actions/upload-artifact: v3`

<img width="300" alt="image" src="https://github.com/user-attachments/assets/d2b5e4fb-19ce-49bd-a467-bc08db4ac50a" />

`actions/upload-artifact`의 v3 버전이 deprecated 되었다고 오류를 뱉었다.  
workflows에 `actions/upload-pages-artifact`를 사용 중인데 이 액션에서 `actions/upload-artifact`를 사용 중이다.  
구버전을 사용하다 보니 deprecated된 버전을 사용하고 있어서 일단 `actions/upload-pages-artifact`를 v1 -> v3로 변경하니 pass.  

### + Error: Getting signed artifact URL failed

이번에는 `actions/deploy-pages`의 오류가 발생했다.  
v2 -> v4로 변경하여 pass.  

### + jekyll-theme-chirpy 업그레이드 가이드

[Jekyll theme chirpy Upgrade-Guide](https://github.com/cotes2020/jekyll-theme-chirpy/wiki/Upgrade-Guide)

Chirpy 테마에서 제공하는 가이드 문서가 있다.  
살짝 훑어보니 릴리즈된 소스로 merge를 하라는 내용이다.  
역시 유료 블로그 서비스를 이용하지 않는 대가는 치러야 한다.

