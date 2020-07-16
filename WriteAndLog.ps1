##
## Positivo Tecnologia S/A
## Engenharia Industrial - Engenharia de Testes - Curitiba - PR
##
## Sistema de Testes Positivo
## 
## Este arquivo é de propriedade da Positivo Tecnologia S/A
## e seu uso é permitido apenas por ela e seus parceiros autorizados.
##
## Autor: Leandro Gustavo Biss Becker
##

# Escreve na saída do console e também em um arquivo de log ao mesmo tempo.
# Parâmetro $ForegroundColor: Cor do texto. Opcional
# Parâmetro $Width: Formata largura do texto. Se negativo, a largura será a largura da console menor o valor do parâmetro. Opcional.
# Parâmetro $NoNewline: Se especificado, não termina string com um enter. Opcional.
# Parâmetro $logstring: Texto a ser logado. Todos os demais parâmetros serão concatenados.
# Parâmetro: $Global:ScriptLogFile Caminho para o arquivo de log.
Function WriteAndLog
{
    Param ([parameter(ParameterSetName="Optionals")][System.Object]$ForegroundColor, 
    [parameter(ParameterSetName="Optionals", HelpMessage="Se negativo, a largura será igual a largura do console menos o valor do parâmetro.")][int]$Width, 
    [switch]$NoNewline,
    [switch]$NoScreen,
    [parameter(ValueFromRemainingArguments=$true, ValueFromPipeline=$true)] $logstring)

    $logstring |% `
    {
        $text = ($_ | Out-String).TrimEnd()
        if ($Width -ne $null -and $Width -ne 0)
        {
            if ($Width -lt 0) { $Width += (Get-Host).UI.RawUI.BufferSize.Width }
        
            if ($text.Length -gt $Width) { $text = $text.Remove($Width) }
            else { $text += (New-Object -typename string -argumentlist '.', ($Width - $text.Length)) }
        }

        if ($NoNewline.IsPresent) { 
            if ($NoScreen.IsPresent -eq $false) {
                if ($ForegroundColor -eq $null) { Write-Host -NoNewline $text }
                else { Write-Host -ForegroundColor $ForegroundColor -NoNewline $text }
            }
            if ($Global:ScriptLogFile -ne $null) {
                [System.IO.File]::AppendAllText($Global:ScriptLogFile, $text, [System.Text.Encoding]::UTF8)
            }
        }
        else {
            if ($NoScreen.IsPresent -eq $false) {
                if ($ForegroundColor -eq $null) { Write-Host $text }
                else { Write-Host -ForegroundColor $ForegroundColor $text }
            }
            if ($Global:ScriptLogFile -ne $null) {
                $text | out-file -FilePath $Global:ScriptLogFile -append -Encoding utf8
            }
        }
    }
}
