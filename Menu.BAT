echo off

cls
color 1f
title Menu.BAT 

Time /t
Date /t
:menu
echo 浜様様様様様様様様様様様様様様様様様様様様様様融
echo �                                              �
echo �    Desenvolvedora: Jaqueline Mara Silva      �
echo �                                              �
echo �                                              �
echo �    ESCOLHA O MODO PARA DISPONIBILIZAR        �
echo �    O RECOVERY EM                             �
echo �                                              �
echo �    E:\Disponibilizacao_Recovery\Temp         �
echo �                                              �
echo �                                              �
echo �    1) Dentro da respectiva pasta             �
echo �    2) Na raiz                                �
echo �    3) Sair                                   �
echo �                                              �
echo �                                              �
echo 藩様様様様様様様様様様様様様様様様様様様様様様夕


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