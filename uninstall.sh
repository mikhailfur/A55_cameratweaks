#!/system/bin/sh

# Путь к оригинальному файлу
ORIG_FILE=/system/cameradata/camera-feature.xml

# Путь к бэкапу внутри модуля
MOD_BACKUP=/data/adb/modules/camera-tweaks-a55/backup/camera-feature.xml.bak

# Проверяем, существует ли бэкап
if [ -f "$MOD_BACKUP" ]; then
  # Восстанавливаем оригинальный файл из бэкапа
  # Используем cp -f для перезаписи, если файл уже существует
  cp -f $MOD_BACKUP $ORIG_FILE
  # Устанавливаем правильные права доступа, как у системных файлов
  chmod 644 $ORIG_FILE
  chown root:root $ORIG_FILE
fi