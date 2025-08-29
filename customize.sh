#!/system/bin/sh

# Путь к оригинальному файлу
ORIG_FILE=/system/cameradata/camera-feature.xml

# Путь для бэкапа внутри модуля
MOD_BACKUP=$MODPATH/backup/camera-feature.xml.bak

# Путь к файлу модуля
MOD_FILE=$MODPATH/system/cameradata/camera-feature.xml

ui_print "**********************************************"
ui_print "* Camera Tweaks (Samsung A55)           *"
ui_print "* by mikhailfur                         *"
ui_print "**********************************************"

ui_print "- Debug: MODPATH = $MODPATH"
ui_print "- Debug: MOD_FILE = $MOD_FILE"
ui_print "- Debug: ORIG_FILE = $ORIG_FILE"

ui_print "- Checking for original camera-feature.xml..."

# Проверяем, существует ли оригинальный файл
if [ -f "$ORIG_FILE" ]; then
  ui_print "- Original file found."
  ui_print "- Creating backup..."
  # Создаем папку для бэкапа
  mkdir -p $(dirname $MOD_BACKUP)
  # Копируем оригинальный файл в бэкап
  cp -f $ORIG_FILE $MOD_BACKUP
  ui_print "- Backup created successfully in module directory."
  
  # Проверяем, существует ли файл модуля
  if [ -f "$MOD_FILE" ]; then
    ui_print "- Module file found, checking system mount status..."
    
    # Перемонтируем систему в режим записи
    ui_print "- Remounting system partition as writable..."
    mount -o rw,remount /system
    
    ui_print "- Replacing original file with module file..."
    # Заменяем оригинальный файл файлом из модуля
    cp -f $MOD_FILE $ORIG_FILE
    # Устанавливаем правильные права доступа
    chmod 644 $ORIG_FILE
    chown root:root $ORIG_FILE
    
    # Проверяем, что замена прошла успешно
    if [ -f "$ORIG_FILE" ]; then
      ui_print "- File replacement completed successfully."
      ui_print "- New file size: $(ls -la $ORIG_FILE | awk '{print $5}') bytes"
    else
      ui_print "- Error: File replacement failed!"
    fi
    
    # Возвращаем систему в режим только для чтения
    mount -o ro,remount /system
    ui_print "- System remounted as read-only"
  else
    ui_print "- Error: Module file not found at $MOD_FILE"
    ui_print "- Available files in module:"
    ls -la $MODPATH/system/cameradata/ || ui_print "  Cannot list module directory"
  fi
else
  ui_print "- Warning: Original camera-feature.xml not found."
  ui_print "- A backup could not be created."
  
  # Даже если оригинального файла нет, пытаемся установить файл модуля
  if [ -f "$MOD_FILE" ]; then
    ui_print "- Installing module file to system..."
    
    # Перемонтируем систему в режим записи
    mount -o rw,remount /system
    
    # Создаем директорию, если её нет
    mkdir -p $(dirname $ORIG_FILE)
    # Копируем файл модуля в систему
    cp -f $MOD_FILE $ORIG_FILE
    # Устанавливаем правильные права доступа
    chmod 644 $ORIG_FILE
    chown root:root $ORIG_FILE
    
    if [ -f "$ORIG_FILE" ]; then
      ui_print "- Module file installed successfully."
    else
      ui_print "- Error: Module file installation failed!"
    fi
    
    # Возвращаем систему в режим только для чтения
    mount -o ro,remount /system
  else
    ui_print "- Error: Module file not found at $MOD_FILE"
  fi
fi

ui_print "- Module installation complete."