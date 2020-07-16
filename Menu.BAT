echo off

cls
color 1f
title Menu.BAT 

Time /t
Date /t
:menu
echo ษออออออออออออออออออออออออออออออออออออออออออออออป
echo บ                                              บ
echo บ    Desenvolvedora: Jaqueline Mara Silva      บ
echo บ                                              บ
echo บ                                              บ
echo บ    ESCOLHA O MODO PARA DISPONIBILIZAR        บ
echo บ    O RECOVERY EM                             บ
echo บ                                              บ
echo บ    E:\Disponibilizacao_Recovery\Temp         บ
echo บ                                              บ
echo บ                                              บ
echo บ    1) Dentro da respectiva pasta             บ
echo บ    2) Na raiz                                บ
echo บ    3) Sair                                   บ
echo บ                                              บ
echo บ                                              บ
echo ศออออออออออออออออออออออออออออออออออออออออออออออผ


set /p opcao=Digite a opcao.......
if %opcao% equ 1 goto 1
if %opcao% equ 2 goto 2
if %opcao% equ 3 goto 3
:1
start powershell.exe -executionpolicy unrestricted -f "%~dp0AutRecovery.ps1"
cls
goto 3

:2
start powershell.exe -executionpolicy unrestricted -f "%~dp0AutRecoveryRoot.ps1"
cls
goto 3

:3
start exit
cls
goto exit