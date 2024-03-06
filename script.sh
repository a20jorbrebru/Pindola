#!/bin/bash

# Redirigir tota l'eixida a un fitxer, borrant contingut previ
exec > analisis_detallat.txt 2>&1

# Funció per separador
print_separator() {
  echo "-------------------------------------------------"
}

echo "ANÀLISI DETALLAT DEL SISTEMA - $(date)"
print_separator

# Distribució i Versió del Sistema
echo "DISTRIBUCIÓ I VERSIÓ DEL SISTEMA:"
lsb_release -a
print_separator

# Configuració de Xarxa
echo "CONFIGURACIÓ DE XARXA:"
ip addr
print_separator

# Connexions de Xarxa Actives
echo "CONNEXIONS DE XARXA ACTIVES:"
sudo ss -tulwn
print_separator

# Serveis en Execució
echo "SERVEIS EN EXECUCIÓ (ALGUNS EXEMPLES):"
systemctl --type=service --state=running | grep ".service"
print_separator

# Estat de Firewall (UFW)
echo "ESTAT DE FIREWALL (UFW):"
sudo ufw status verbose
print_separator

# Regles de iptables
echo "REGLES DE IPTABLES:"
sudo iptables -L -v -n
print_separator

# Registres del Sistema
echo "REGISTRES DEL SISTEMA (ÚLTIMES 20 LÍNIES DE SYSLOG):"
sudo tail -n 20 /var/log/syslog
print_separator

# Actualitzacions de Seguretat Pendents
echo "ACTUALITZACIONS DE SEGURETAT PENDENTS:"
sudo apt list --upgradable
print_separator

# Usuaris del Sistema
echo "USUARIS DEL SISTEMA (NOMÉS NOMS):"
cut -d: -f1 /etc/passwd
print_separator

# Configuracions ocultes de systemd
echo "UNITATS DE SYSTEMD FALLIDES:"
systemctl --failed
print_separator

# Distribució Lògica dels Discs Durs
echo "DISTRIBUCIÓ LÒGICA DELS DISCS DURS:"
lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT,LABEL
print_separator

# Ús del Disc per Directoris Importants
echo "ÚS DEL DISC PER DIRECTORIS IMPORTANTS (/HOME, /ROOT, /VAR):"
du -sh /home /root /var | sort -h
print_separator

# Configuració d'Autenticació PAM
echo "CONFIGURACIÓ D'AUTENTICACIÓ PAM (EXEMPLES):"
sudo cat /etc/pam.d/common-auth
print_separator

# Fi de l'Script
echo "ANÀLISI COMPLETADA."

