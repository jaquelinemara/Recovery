#Versionado no TortoiseSVN 
#Alteracao tiago

# Indicar o diretório corrente do arquivo exf.exe (ExactFile)*
$currentExecutingPath = $MyInvocation.MyCommand.Path | Split-Path -Parent
$RootPath = $currentExecutingPath | Split-Path -Parent 

# Log
.(Join-Path $currentExecutingPath "WriteAndLog.ps1")
$Global:ScriptLogFile = "LOG\log.txt"#caminho

# Declaração de Variáveis
#Pasta Temp
$PastaTemp = "$currentExecutingPath\Temp"
#Pasta Recovery
$PastaRecovery = "$currentExecutingPath\Recovery\"
# Pasta do projeto
$PastaRec = $currentExecutingPath
# Variáveis de Compactação de Arquivos
$programa = "$currentExecutingPath\7z1805-extra\x64\7za.exe"
$acao = "a"


#Origem Pasta Recovery*
#MeuPc
#$Servidor_recovery = "C:\Users\59921\Desktop\Servidor_Manaus" # Mudar para a pasta onde ficam os recoverys de manaus
#PCManaus
$Servidor_recovery = "E:\Midia_Recovery" 

# Importar arquivo recovery.csv com os códigos e descrições de recovery*
$RecFiles = Import-Csv -Path "$PastaRec\recovery.csv" -Delimiter ";"


# Para cada código da lista, verificar se o arquivo existe*
foreach($RecFile in $RecFiles){
    
    # Informar a data no log
    $hoje = Get-date -Format g  
    WriteAndLog -ForegroundColor White -logstring $hoje
    WriteAndLog -ForegroundColor Yellow -logstring $RecFile.cod

    # Testar se a pasta do Recovery existe no Servidor de Manaus*
    if((Test-Path "$Servidor_recovery\$($RecFile.cod)")){
    
        WriteAndLog -Foreground White -logstring "Copiando o arquivo para a pasta do projeto"
            
        try{
        
            Copy-Item -Path "$Servidor_recovery\$($RecFile.cod)" -Destination "$PastaRecovery\$($RecFile.cod)" -Recurse -Force                    
            $flg = $true

        }Catch{
                    
            WriteAndLog -NoScreen -logstring $Error[0]
            $flg = $false

        }
            

        
        if($LASTEXITCODE -eq 0 -or $LASTEXITCODE -eq $null){

            WriteAndLog -ForegroundColor Green -logstring "Pasta copiada com sucesso"
            WriteAndLog -ForegroundColor White -logstring "Arquivo encontrado. Verificando a integridade deste arquivo..."

        # Realizar a validação por linha de comando*
            if(Test-Path $PastaRecovery$($RecFile.cod)\checksums.md5){
                
                .\exf.exe -cv $PastaRecovery$($RecFile.cod)\checksums.md5 > logcheck.txt
                $Logcheck = Get-Content logcheck.txt

                
                if ($Logcheck -like "*pass*"){

                    WriteAndLog -ForegroundColor Green -logstring "Arquivo sem erro."
                    WriteAndLog -ForegroundColor White -logstring "Compactando o arquivo..."
                    # Concatenar saída do arquivo .zip*
                    $Saida = $PastaTemp + "\" + $RecFile.cod + "_"+ $RecFile.desc + ".zip"
                    if(Test-Path $Saida){
                
                    $acao = "u"
                
                }else{
                
                    $acao = "a"
                
                }                   
                                       
                   
                    
                try{

                    #Compress-Archive -Path "$PastaRecovery$($RecFile.cod)\*" -DestinationPath $Saida -Force                       
                    $Entrada = "$PastaRecovery$($RecFile.cod)\*"
                    $ret = Start-Process -FilePath $programa -ArgumentList ("$acao ""$Saida"" ""$Entrada"" -r -ssw")  -Wait -RedirectStandardOutput (Join-Path $currentExecutingPath "LOG\log7zip.txt") -NoNewWindow
                    $flg = $true

                }Catch{
                    
                    WriteAndLog -NoScreen -logstring $Error[0]
                    $flg = $false

                }
                    
                    
                if($LASTEXITCODE -eq 0 -or $LASTEXITCODE -eq $null -and $flg -eq $true){
                    $cod = $RecFile.cod
                    $archive = Get-Item "$PastaTemp\$cod*.zip"  
                    $archive = $archive.name                   
                    WriteAndLog -ForegroundColor Green -logstring "Arquivo compactado com êxito."
                    WriteAndLog -logstring ""
                    New-Item -Path "$PastaTemp\$($RecFile.cod)" -ItemType directory
                    Move-Item -Path $PastaTemp\$archive -Destination "$PastaTemp\$($RecFile.cod)" -Force
                    ### Remover arquivo "$PastaRecovery$($RecFile.cod)" - tentar 10 vezes com 2 segundos de invervalo
                    $tent = 0
                    do{
                        
                            
                        Remove-Item "$PastaRecovery$($RecFile.cod)" -Recurse -Force -ErrorAction SilentlyContinue
                        Start-Sleep -Seconds 2
                        $tent++
                            
                        
                    }While((Test-Path "$PastaRecovery$($RecFile.cod)") -and $tent -lt 10)
                    ###
                        

                }else{
                    
                    WriteAndLog -ForegroundColor Red -logstring "Erro ao compactar o arquivo"
                    WriteAndLog -logstring "" 
                    
                }
                
                }else{

                    WriteAndLog -ForegroundColor Red -logstring "Arquivo com erro. Reportar ao setor de Engenharia de Matriz (Manaus)."
                    WriteAndLog -logstring "" 

                }
        
        
            }else{

                    WriteAndLog -ForegroundColor Red  -logstring "Não existe o arquivo checksum. É necessário criá-lo."
                    WriteAndLog -logstring "" 

            }
        }else{


            WriteAndLog -ForegroundColor Red -logstring "Erro ao copiar a pasta $($RecFile.cod)"
            WriteAndLog -logstring "" 
        
        
        }


    }else{

        WriteAndLog -ForegroundColor Red -logstring "Arquivo não encontrado. Solicitar ao setor de Engenharia de Matriz (Manaus)."
        WriteAndLog -logstring "" 

    }

}

#St-content: apaga tudo e coloca no arquivo 
#Add-content: adiciona 
Get-Content -Path $currentExecutingPath\LOG\log7zip.txt | Add-Content -Path $currentExecutingPath\LOG\log.txt








