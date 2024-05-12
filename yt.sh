#!/bin/bash

# Función para verificar e instalar herramientas necesarias
install_tools() {
  if ! command -v yt-dlp &>/dev/null; then
    echo "yt-dlp no está instalado. Instalando..."
    sudo apt-get install yt-dlp
  fi

  if ! command -v ffmpeg &>/dev/null; then
    echo "ffmpeg no está instalado. Instalando..."
    sudo apt-get install ffmpeg
  fi
}

# Llama a la función de instalación
install_tools

# Solicitar la URL del video de YouTube
echo "Introduce la URL de YouTube:"
read url

# Mostrar los formatos disponibles
yt-dlp -F $url

# Solicitar al usuario que elija el formato del video (número)
echo "Elige el formato del video (número):"
read format

# Descargar el video en el formato seleccionado
yt-dlp -f $format $url -o video.%\(ext\)s

# Extraer el audio y guardarlo como mp3
ffmpeg -i video.* audio.mp3

# Crear un video sin audio
ffmpeg -i video.* -an video_compressed.mp4

# Mostrar información sobre los archivos generados
echo "Información de los archivos generados:"
echo "Audio: $(du -h audio.mp3) | Duración: $(ffmpeg -i audio.mp3 2>&1 | grep Duration)"
echo "Video: $(du -h video_compressed.mp4)"
