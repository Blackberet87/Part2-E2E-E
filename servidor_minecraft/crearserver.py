import os
import subprocess
import urllib.request

JAR_URL = "https://github.com/EnigmaticaModpacks/ServerStarter/releases/download/v2.4.0/serverstarter-2.4.0.jar"
JAR_FILE = "serverstarter-2.4.0.jar"

# Cambiar al directorio del script
script_dir = os.path.dirname(os.path.abspath(__file__))
os.chdir(script_dir)

# Verificar si el JAR existe, si no, descargarlo
if not os.path.exists(JAR_FILE):
    print("serverstarter binary not found, downloading serverstarter...")
    urllib.request.urlretrieve(JAR_URL, JAR_FILE)

# Ejecutar el servidor con Java
try:
    subprocess.run(["java", "-jar", JAR_FILE], check=True)
except FileNotFoundError:
    print("Error: Java no está instalado o no se encuentra en el PATH.")
except subprocess.CalledProcessError as e:
    print(f"Error al ejecutar el servidor: {e}")

input("Presiona Enter para salir...")
