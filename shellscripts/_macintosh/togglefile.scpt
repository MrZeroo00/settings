#!/usr/bin/osascript
on run argv
    set AppName to (first item of argv) & ".app" --第1引数をファイルを開くアプリ名に
    set FilePath to (second item of argv) --第2引数をファイル名に
    set cFile to "" --cFile変数を初期化。アプリ内の最前面ウインドウが名称未設定とか「無し」だとエラーになるため

    if application AppName is frontmost then --指定したアプリが最前面である場合
        tell application AppName
            try --アプリ内の最前面ウインドウが名称未設定とか「無し」だとエラーになるのでtryに入れる
                set cFile to POSIX path of (get file of document 1) --アプリ内の最前面ウインドウで開いているファイルパスを取得
            end try
            if cFile is FilePath then --開いているファイルが指定ファイルと同じである場合
                tell application "System Events" --指定アプリをしまう
                    set frontProcess to first process whose frontmost is true
                    set visible of frontProcess to false
                end tell
            else
                open FilePath
            end if
        end tell
    else --指定アプリが最前面でない場合
        tell application AppName
            activate
            open FilePath
        end tell
    end if
end run
