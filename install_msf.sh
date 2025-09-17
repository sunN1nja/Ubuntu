#!/bin/bash

# ОФИЦИАЛЬНАЯ установка Metasploit
set -e

echo "=== ОФИЦИАЛЬНАЯ УСТАНОВКА METASPLOIT ==="

if [ "$EUID" -ne 0 ]; then
    echo "Запустите с sudo!"
    exit 1
fi

# Шаг 1: Устанавливаем только PostgreSQL
echo "→ Устанавливаем PostgreSQL..."
apt update
apt install -y postgresql postgresql-contrib
systemctl start postgresql
systemctl enable postgresql

# Шаг 2: Создаем базу данных
echo "→ Создаем базу данных..."
sudo -u postgres psql -c "CREATE USER msfuser WITH PASSWORD 'msfpassword' CREATEDB;" 2>/dev/null || true
sudo -u postgres psql -c "CREATE DATABASE msf_database OWNER msfuser;" 2>/dev/null || true

# Шаг 3: Скачиваем официальный установщик
echo "→ Скачиваем официальный установщик..."
cd /tmp
curl -sSL https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
chmod +x msfinstall

# Шаг 4: Запускаем установку с правильными опциями
echo "→ Запускаем установку..."
./msfinstall --no-install-deps

# Шаг 5: Инициализируем базу данных ЧЕРЕЗ MSFCONSOLE
echo "→ Инициализируем базу данных через msfconsole..."
/opt/metasploit-framework/bin/msfconsole -q -x "db_connect msfuser:msfpassword@127.0.0.1:5432/msf_database; exit"

# Шаг 6: Создаем конфигурационный файл вручную
echo "→ Создаем конфигурационный файл..."
mkdir -p /opt/metasploit-framework/embedded/framework/config
cat > /opt/metasploit-framework/embedded/framework/config/database.yml << 'EOF'
production:
  adapter: postgresql
  database: msf_database
  username: msfuser
  password: msfpassword
  host: localhost
  port: 5432
  pool: 75
  timeout: 5
EOF

# Шаг 7: Создаем симлинки
echo "→ Создаем симлинки..."
ln -sf /opt/metasploit-framework/bin/msfconsole /usr/local/bin/msfconsole
ln -sf /opt/metasploit-framework/bin/msfvenom /usr/local/bin/msfvenom
ln -sf /opt/metasploit-framework/bin/msfdb /usr/local/bin/msfdb

# Шаг 8: Проверяем установку
echo "→ Проверяем установку..."
if /opt/metasploit-framework/bin/msfconsole --version > /dev/null 2>&1; then
    echo "✅ Metasploit успешно установлен!"
    echo "Версия: $(/opt/metasploit-framework/bin/msfconsole --version 2>/dev/null | head -1)"
else
    echo "⚠️  Используйте полный путь: /opt/metasploit-framework/bin/msfconsole"
fi

echo ""
echo "========================================"
echo "УСТАНОВКА ЗАВЕРШЕНА!"
echo "Запустите: msfconsole"
echo "В msfconsole выполните: db_status"
echo "========================================"
