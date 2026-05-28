
# - - - - Начало скрипта - - - - 

# Локальная папка назначения
$userName = Read-Host "Введите имя пользователя: "
$destinationPath = "C:\Users\$userName\Downloads"

$Updates = @(
    '1.txt',
    '2.txt',
    '3.txt',
    '4.txt'
) 

# - - Выводимая информация
Write-Host "Доступный список накопительных обновлений: "
Write-Host "1. 1.txt" 
Write-Host "2. 2.txt"  
Write-Host "3. 3.txt"  
Write-Host "4. 4.txt"  

# Обработка пользователя
$rawInput = Read-Host "Введите номер накопительного обновления:"
$idx = [int]$rawInput -1
$sourcePath = $Updates[$idx]

# - - Выполнение скрипта
#  Проверка доступности источника
if (Test-Path -Path $sourcePath) {
    try {
        # Копирование с принудительной перезаписью (-Force)
        Copy-Item -Path $sourcePath -Destination $destinationPath -Force -ErrorAction Stop
        Write-Host "Файл успешно скопирован в $destinationPath" -ForegroundColor Green
    }
    catch {
        Write-Host "Ошибка копирования: $_" -ForegroundColor Red
        
    }
}
else {
    Write-Host "Файл не найден или сетевой путь недоступен: $sourcePath" -ForegroundColor Yellow
}

Start-Sleep 1

Write-Host "Производится установка накопительного обновления"
DISM /Online /Add-Package /PackagePath:$sourcePath

Write-Host "`n✅ Все операции завершены." -ForegroundColor Green
Write-Host "🔹 Нажмите любую клавишу для выхода..." -ForegroundColor Yellow
try {
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
} catch {
    # Фоллбэк для ISE / VS Code, где ReadKey не поддерживается
    Read-Host "Или нажмите Enter" | Out-Null
}