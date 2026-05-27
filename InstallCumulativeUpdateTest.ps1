
# - - - - Начало скрипта - - - - 

# Локальная папка назначения
$destinationPath = "C:\Users\$env:computername\Downloads"
$serverPath = "C:\Users\$env:computername\Documents" # путь до самих KB'шек ❗Измеить
# Имена файлов накопительных  ❗ Изменить
$Updates = @(
    '1.txt',
    '2.txt',
    '3.txt',
    '4.txt'
) 

# - - Выводимая информация
echo "Доступный список накопительных обновлений: "
echo "1. 1.txt"  # ❗ Поменять на нужные
echo "2. 2.txt"  # ❗ Поменять на нужные
echo "3. 3.txt"  # ❗ Поменять на нужные
echo "4. 4.txt"  # ❗ Поменять на нужные

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

sleep 1

echo "Производится установка накопительного обновления"
DISM /Online /Add-Package /PackagePath:$sourcePath

Write-Host "`n✅ Все операции завершены." -ForegroundColor Green
Write-Host "🔹 Нажмите любую клавишу для выхода..." -ForegroundColor Yellow
try {
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
} catch {
    # Фоллбэк для ISE / VS Code, где ReadKey не поддерживается
    Read-Host "Или нажмите Enter" | Out-Null
}
