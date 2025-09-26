---
title: "(Note) Tahoe 어택으로 Sequoia 다운그레이드 😢"
date: 2025-09-26 10:00:00 +0900
categories: [Notes, macOS]
tags: [notes, macOS, Sequoia, Tahoe]
---

## 노트
맥북 프로 인텔 코어 모델에다가 macOS Tahoe를 설치했더니… 성능이 확 떨어지고 자잘한 문제들이 너무 많았다..  
이대로는 도저히 쓸 수가 없겠다 싶어서 결국 Sequoia를 클린 설치하기로 결정.  
앞으로는 이런 상황에 대비해서 타임머신 설정을 좀 해두어야겠다. 어디에 할까나..?

### Sequoia 설치 USB 만들기
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
