# Путь к оригинальному файлу
ORIG_FILE=/system/cameradata/camera-feature.xml

# Путь для бэкапа внутри модуля
MOD_BACKUP=$MODPATH/backup/camera-feature.xml.bak

ui_print "**********************************************"
ui_print "* Camera Tweaks (Samsung A55)           *"
ui_print "* by mikhailfur                         *"
ui_print "**********************************************"

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
else
  ui_print "- Warning: Original camera-feature.xml not found."
  ui_print "- A backup could not be created."
fi

ui_print "- Module installation complete."