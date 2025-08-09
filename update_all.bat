echo ===%~f0===

cd /D %~dp0

esphome --version


esphome run bme280_bad.yaml --no-logs
IF %ERRORLEVEL% NEQ 0 (
  pause something went wrong with bme280_bad
)
esphome run bme280_dach.yaml --no-logs
IF %ERRORLEVEL% NEQ 0 (
  pause something went wrong with bme280_dach
)
esphome run bme280_keller.yaml --no-logs
IF %ERRORLEVEL% NEQ 0 (
  pause something went wrong with bme280_keller
)
esphome run bme280_kueche.yaml --no-logs
IF %ERRORLEVEL% NEQ 0 (
  pause something went wrong with bme280_kueche
)
esphome run led-strip-v2.yaml --no-logs
IF %ERRORLEVEL% NEQ 0 (
  pause something went wrong with led-strip-v2
)
esphome run heizung.yaml --no-logs
IF %ERRORLEVEL% NEQ 0 (
  pause something went wrong with heizung
)

pio system prune --cache -f

pause all done
