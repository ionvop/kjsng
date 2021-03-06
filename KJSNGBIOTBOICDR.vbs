set objShell = CreateObject("wscript.shell")
set objFile = CreateObject("scripting.FileSystemObject")
randomize

arrConsonants = array("k", "s", "t", "n", "h", "m", "y", "r", "w", "", "!n")
arrVowels = array("a", "o", "u", "i", "e")
strDirectory = objShell.CurrentDirectory

function funcRand(fMin, fMax)
    funcRand = int((fMax-fMin+1)*rnd+fMin)
end function

function funcConvertToHiragana(fSyllable)
    dim i, strRead, varTranslatePosition
    set objFileOpen = objFile.OpenTextFile(strDirectory & "\ionvop-KJSNGBIOTBOICDR-DataFolder\ionvop-KJSNGBIOTBOICDR-JapaneseHiraganaChart.dat", 1, false, -1)
    i = 0

    do until objFileOpen.AtEndOfStream
        i = i + 1
        strRead = objFileOpen.ReadLine

        if strRead = fSyllable then
            varTranslatePosition = i + 46
        end if
    loop

    objFileOpen.close
    set objFileOpen = objFile.OpenTextFile(strDirectory & "\ionvop-KJSNGBIOTBOICDR-DataFolder\ionvop-KJSNGBIOTBOICDR-JapaneseHiraganaChart.dat", 1, false, -1)

    for i = 1 to varTranslatePosition
        strRead = objFileOpen.ReadLine
    next

    funcConvertToHiragana = strRead
end function

function funcGenerateName(fLength)
    dim i, varOffset, strConsonant, strVowel, strSyllable, strRomaji, strHiragana

    for i = 1 to fLength
        if i = 1 then
            varOffset = -1
        elseif right(strRomaji, 1) = "n" then
            varOffset = -2
        else
         varOffset = 0
        end if

        strConsonant = arrConsonants(funcRand(0,UBound(arrConsonants) + varOffset))

        if strConsonant = "y" then
            varOffset = -2
        elseif strConsonant = "w" then
            varOffset = -3
        end if

        strVowel = arrVowels(funcRand(0,UBound(arrVowels) + varOffset))
        strSyllable = ""

        if strConsonant = "!n" then
            strVowel = ""
            strConsonant = "n"
        elseif strConsonant = "s" or strConsonant = "c" then
            if strVowel = "i" then
                strConsonant = strConsonant & "h"
            end if
        elseif strConsonant = "t" and strVowel = "u" then
            strConsonant = "ts"
        elseif strConsonant = "w" and strVowel = "o" then
            strConsonant = ""
            strSyllable = "wo"
        end if

        if not strSyllable = "wo" then
            strSyllable = strConsonant & strVowel
        end if

        strRomaji = strRomaji & strConsonant & strVowel
        strHiragana = strHiragana & funcConvertToHiragana(strSyllable)
        funcGenerateName = strRomaji & vbCrlf & vbCrlf & strHiragana
    next
end function

function funcCapitalize(fString)
    funcCapitalize = UCase(left(fString, 1)) & mid(fString, 2)
end function

sub sbExit
    objFile.DeleteFolder strDirectory & "\ionvop-KJSNGBIOTBOICDR-DataFolder", false
    wscript.quit
end sub

if not objFile.FolderExists(strDirectory & "\ionvop-KJSNGBIOTBOICDR-DataFolder") then
    objFile.CreateFolder(strDirectory & "\ionvop-KJSNGBIOTBOICDR-DataFolder")
end if

set objFileCreate = objFile.CreateTextFile(strDirectory & "\ionvop-KJSNGBIOTBOICDR-DataFolder\ionvop-KJSNGBIOTBOICDR-JapaneseHiraganaChart.dat", true, true)
objFileCreate.WriteLine("a" & vbCrlf & "i" & vbCrlf & "u" & vbCrlf & "e" & vbCrlf & "o" & vbCrlf & "ka" & vbCrlf & "ki" & vbCrlf & "ku" & vbCrlf & "ke" & vbCrlf & "ko" & vbCrlf & "sa" & vbCrlf & "shi" & vbCrlf & "su" & vbCrlf & "se" & vbCrlf & "so" & vbCrlf & "ta" & vbCrlf & "chi" & vbCrlf & "tsu" & vbCrlf & "te" & vbCrlf & "to" & vbCrlf & "na" & vbCrlf & "ni" & vbCrlf & "nu" & vbCrlf & "ne" & vbCrlf & "no" & vbCrlf & "ha" & vbCrlf & "hi" & vbCrlf & "hu" & vbCrlf & "he" & vbCrlf & "ho" & vbCrlf & "ma" & vbCrlf & "mi" & vbCrlf & "mu" & vbCrlf & "me" & vbCrlf & "mo" & vbCrlf & "ya" & vbCrlf & "yu" & vbCrlf & "yo" & vbCrlf & "ra" & vbCrlf & "ri" & vbCrlf & "ru" & vbCrlf & "re" & vbCrlf & "ro" & vbCrlf & "wa" & vbCrlf & "wo" & vbCrlf & "n" & vbCrlf & "あ" & vbCrlf & "い" & vbCrlf & "う" & vbCrlf & "え" & vbCrlf & "お" & vbCrlf & "か" & vbCrlf & "き" & vbCrlf & "く" & vbCrlf & "け" & vbCrlf & "こ" & vbCrlf & "さ" & vbCrlf & "し" & vbCrlf & "す" & vbCrlf & "せ" & vbCrlf & "そ" & vbCrlf & "た" & vbCrlf & "ち" & vbCrlf & "つ" & vbCrlf & "て" & vbCrlf & "と" & vbCrlf & "な" & vbCrlf & "に" & vbCrlf & "ぬ" & vbCrlf & "ね" & vbCrlf & "の" & vbCrlf & "は" & vbCrlf & "ひ" & vbCrlf & "ふ" & vbCrlf & "へ" & vbCrlf & "ほ" & vbCrlf & "ま" & vbCrlf & "み" & vbCrlf & "む" & vbCrlf & "め" & vbCrlf & "も" & vbCrlf & "や" & vbCrlf & "ゆ" & vbCrlf & "よ" & vbCrlf & "ら" & vbCrlf & "り" & vbCrlf & "る" & vbCrlf & "れ" & vbCrlf & "ろ" & vbCrlf & "わ" & vbCrlf & "を" & vbCrlf & "ん")
objFileCreate.close

do
    varNameLength = InputBox("How many syllables do u want for the name to have?", "KJSNGBIOTBOICDR", varNameLength)

    if varNameLength = "" then
        sbExit
    end if

    MsgBox(funcCapitalize(funcGenerateName(varNameLength)))
loop