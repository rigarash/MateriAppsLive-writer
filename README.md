# MateriAppsLive-writer
Scripts for writing MateriApps LIVE! to USB files on Raspberry PI.

* access.sh    
    * どのUSBがどのsdXに対応するかを判別するためのツール
* format_all.sh
    * USBのパーティションテーブルを空にしてVFATを作るツール
    * (注意) /dev/sdXをすべて変更する
* write_all.sh
    * VFATでのフォーマット、ファイルのコピー、/root/${DIR}.md5を使ったmd5sumのチェックを行うツール
    * (注意) /dev/sdXをすべて変更する

* MateriAppsLive.ps1
    * Windows上でMateriAppsLiveを作るPowerShellスクリプト
    * (注意) 認識しているUSBメモリをすべて変更する
