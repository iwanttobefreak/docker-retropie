# Descripción
Imagen Docker con Retropie y roms con vídeos para juegos de
- Amstrad
- Super Nintendo
- Arcade (MAME)

# Uso
docker run --rm -v /dev/snd:/dev/snd -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY --privileged -t iwanttobefreak/retropie

# Per fer
- Añadir sonido a los juegos
- Añadir scummvm (emulador juegos PC)
- Seleccionar emulador por defecto MSX y SNES
