#!/system/bin/sh

ui_print() { echo "$1"; }

ui_print "Installing DualWallpaper System Module"
ui_print "Module by: Mohamed Zaitoon"
ui_print ""

SDK="$(getprop ro.build.version.sdk)"
[ -n "$SDK" ] || SDK=0

if [ "$SDK" -lt 26 ]; then
  ui_print "Android 8.0+ is required."
  exit 1
fi

ui_print "Android SDK: $SDK"
ui_print "Device: $(getprop ro.product.manufacturer) $(getprop ro.product.model)"
ui_print ""

ui_print "Setting permissions..."

set_perm_recursive "$MODPATH" 0 0 0755 0644
set_perm "$MODPATH/service.sh" 0 0 0755
set_perm "$MODPATH/customize.sh" 0 0 0755

ui_print ""
ui_print "Done. Reboot device."
ui_print ""

exit 0