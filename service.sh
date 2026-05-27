#!/system/bin/sh

PKG="de.dlyt.yanndroid.dualwallpaper"

log() {
  echo "[DualWallpaper] $1"
}

until [ "$(getprop sys.boot_completed)" = "1" ]; do
  sleep 2
done

sleep 20

log "Applying background rules only"

while true; do

  # Doze whitelist
  cmd deviceidle whitelist +"$PKG" 2>/dev/null
  dumpsys deviceidle whitelist +"$PKG" 2>/dev/null

  # Keep app active, without opening UI
  am set-standby-bucket "$PKG" active 2>/dev/null

  # Background permissions
  cmd appops set "$PKG" RUN_IN_BACKGROUND allow 2>/dev/null
  cmd appops set "$PKG" RUN_ANY_IN_BACKGROUND allow 2>/dev/null
  cmd appops set "$PKG" START_FOREGROUND allow 2>/dev/null
  cmd appops set "$PKG" WAKE_LOCK allow 2>/dev/null

  # Notifications
  cmd appops set "$PKG" POST_NOTIFICATION allow 2>/dev/null
  pm grant "$PKG" android.permission.POST_NOTIFICATIONS 2>/dev/null

  # Storage / media
  pm grant "$PKG" android.permission.READ_EXTERNAL_STORAGE 2>/dev/null
  pm grant "$PKG" android.permission.WRITE_EXTERNAL_STORAGE 2>/dev/null
  pm grant "$PKG" android.permission.READ_MEDIA_IMAGES 2>/dev/null
  pm grant "$PKG" android.permission.READ_MEDIA_VISUAL_USER_SELECTED 2>/dev/null

  # Wallpaper permissions
  pm grant "$PKG" android.permission.SET_WALLPAPER 2>/dev/null
  pm grant "$PKG" android.permission.SET_WALLPAPER_HINTS 2>/dev/null

  # Xiaomi / HyperOS
  cmd appops set "$PKG" AUTO_START allow 2>/dev/null
  cmd appops set "$PKG" SYSTEM_ALERT_WINDOW allow 2>/dev/null

  sleep 60

done