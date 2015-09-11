# MateriAppsLive-writer
Scripts for writing MateriApps LIVE! to USB files on Raspberry PI.

* access.sh    
    * どのUSBがどのsdXに対応するかを判別するためのツール
* format_all.sh
    * USBのパーティションテーブルを空にしてVFATを作るツール
    * /dev/sdXをすべて変更する
* write_all.sh
    * VFATでのフォーマット、ファイルのコピー、/root/${DIR}.md5を使ったmd5sumのチェックを行うツール
    * /dev/sdXをすべて変更する
