#!/system/bin/sh
#
# shellcheck disable=SC2148
#

# Пути к оригинальным файлам, которые были заменены
ORIG_FLOATING_FILE=/system/cameradata/camera-feature.xml

# Пути к резервным копиям внутри модуля
MOD_FLOATING_BACKUP=$MODDIR/system/cameradata/camera-feature.xml

# Восстанавливаем camera-feature.xml
if [ -f "$MOD_FLOATING_BACKUP" ]; then
  ui_print "- Восстановление оригинального camera-feature.xml..."
  cp -a "$MOD_FLOATING_BACKUP" "$ORIG_FLOATING_FILE"
  ui_print "- camera-feature.xml восстановлен!"
else
  ui_print "- Резервная копия camera-feature.xml не найдена."
fi

ui_print "- Модуль успешно удален!"