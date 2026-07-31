# ESPHome Devices — Project Overview

This is a personal collection of **ESPHome YAML configurations** for various IoT devices deployed around a home, all connecting to Home Assistant. The timezone across all devices is `Europe/Berlin`.

## Directory Layout

```
esphome-devices/
├── bme280_bad.yaml          # Bathroom BME280 sensor (ESP8266)
├── functions.h              # C++ helper — get_binary_sensor_color() template
├── heizung.yaml             # Heating/boiler temp monitoring (ESP8266, 6× DS18B20)
├── hyperion.yaml            # Arcade button board (ESP32, 5 buttons)
├── led-strip-v2.yaml        # LED strip + OLED display controller (ESP32, 4 buttons)
├── scarvix.yaml             # LED matrix color/clock display (ESP32-S3, 24×8 WS2812)
├── vehicon.yaml             # LED matrix door status indicator (ESP32-S3, 8×8 WS2812)
├── fonts/
│   ├── Iosevka/             # TTF font (Iosevka Term Nerd Font) — used by led-strip-v2 OLED
│   └── Spleen/              # BDF font — used by scarvix matrix display
├── scripts/
│   └── esphome.sh           # Linux deploy script — scans /dev/ttyUSB*, runs in Docker
├── update_all.bat           # Windows batch deploy (runs all configs sequentially)
└── HoAsEnv.bat              # Home Assistant environment helper
```

## Devices at a Glance

| Device | MCU | Purpose | Key Details |
|---|---|---|---|
| **scarvix** | ESP32-S3 | LED matrix display (24×8 WS2812) | Color selector + clock pages, 4 touch buttons, BDF fonts |
| **vehicon** | ESP32-S3 | LED matrix door status (8×8 WS2812) | Reads Home Assistant door magnet sensors, custom `functions.h` |
| **led-strip-v2** | ESP32 (Wemos D1 Mini 32) | LED strip controller + I2C OLED | 4-button menu for time/effects/brightness/color, Iosevka font |
| **hyperion** | ESP32 (Wemos D1 Mini 32) | Arcade button board | 5 colored push buttons (green/yellow/red/white/blue) |
| **heizung** | ESP8266 (D1 Mini) | Boiler/heating temperature | 6× Dallas DS18B20 on 1-Wire (VL, Boiler, RL, Zirkulation, WW VL, WW RL) |
| **bme280_bad** | ESP8266 (D1 Mini) | Bathroom environment sensor | BME280 I2C (temp/pressure/humidity), 10kHz bus |

## Shared Infrastructure

- **WiFi**: WPA2 with captive portal fallback AP on most devices
- **API**: Encrypted via `!secret api_psk`
- **OTA**: ESPHome OTA with password protection
- **Secrets**: All sensitive values (`wifi_ssid`, `wifi_password`, `api_psk`, `ota_password`, `captive_portal_password`, etc.) externalized via `!secret` — not stored in the repo

## Deployment

- **Linux/macOS**: `scripts/esphome.sh <operation> <device-name>` — scans `/dev/ttyUSB*` automatically, runs ESPHome in Docker
- **Windows**: `update_all.bat` — deploys all configs sequentially via `esphome run`, then prunes PlatformIO cache

## Notable Patterns

- Uses Arduino framework for ESP32 devices; ESP8266 core for D1 Mini boards
- Custom C++ inclusion via `includes:` directive (`vehicon.yaml` → `functions.h`)
- Static IP for `hyperion` via `!secret iot_ip_hyperion`
- Both Linux (Docker-based) and Windows batch deployment scripts — multi-OS workflow
