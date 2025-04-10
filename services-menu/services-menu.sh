#!/bin/bash

mostrar_menu() {
    clear
    echo "===================================="
    echo "          MENÚ DE SERVICIOS         "
    echo "===================================="
    echo "1. Listar contenido de un directorio"
    echo "2. Crear archivo de texto"
    echo "3. Comparar dos archivos de texto"
    echo "4. Ejemplo de uso de AWK"
    echo "5. Ejemplo de uso de GREP"
    echo "6. Salir"
    echo "===================================="
    echo -n "Seleccione una opción [1-6]: "
}

listar_directorio() {
    echo -n "Ingrese la ruta absoluta del directorio: "
    read ruta
    if [ -d "$ruta" ]; then
        echo -e "\nContenido de $ruta:"
        ls -la "$ruta"
    else
        echo "Error: El directorio $ruta no existe."
    fi
    read -p "Presione Enter para continuar..."
}

crear_archivo() {
    echo -n "Ingrese el texto para el archivo: "
    read texto
    echo -n "Ingrese el nombre del archivo (con extensión .txt): "
    read nombre_archivo
    echo "$texto" > "$nombre_archivo"
    echo "Archivo $nombre_archivo creado con éxito."
    read -p "Presione Enter para continuar..."
}

comparar_archivos() {
    echo -n "Ingrese la ruta del primer archivo: "
    read archivo1
    echo -n "Ingrese la ruta del segundo archivo: "
    read archivo2
    
    if [ ! -f "$archivo1" ] || [ ! -f "$archivo2" ]; then
        echo "Error: Uno o ambos archivos no existen."
    else
        if cmp -s "$archivo1" "$archivo2"; then
            echo "Los archivos son idénticos."
        else
            echo "Los archivos son diferentes."
            echo "Diferencias:"
            diff -u "$archivo1" "$archivo2"
        fi
    fi
    read -p "Presione Enter para continuar..."
}

mostrar_awk() {
    echo -e "\nEjemplo de AWK:"
    echo "Mostrando la primera columna del archivo /etc/passwd"
    awk -F: '{print $1}' /etc/passwd | head -n 10
    echo -e "\n(Se muestran solo los primeros 10 resultados)"
    read -p "Presione Enter para continuar..."
}

mostrar_grep() {
    echo -e "\nEjemplo de GREP:"
    echo "Buscando la palabra 'bash' en /etc/passwd"
    grep --color=auto 'bash' /etc/passwd
    read -p "Presione Enter para continuar..."
}

while true; do
    mostrar_menu
    read opcion
    
    case $opcion in
        1) listar_directorio ;;
        2) crear_archivo ;;
        3) comparar_archivos ;;
        4) mostrar_awk ;;
        5) mostrar_grep ;;
        6) 
            echo "Saliendo del programa..."
            exit 0
            ;;
        *)
            echo "Opción no válida. Intente nuevamente."
            read -p "Presione Enter para continuar..."
            ;;
    esac
done
