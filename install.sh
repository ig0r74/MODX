#!/bin/bash

echo "Введите имя БД"
read DATABASE

echo "Установка MODX"

DIRPATH=`pwd`

#############

echo "Создание config.xml"
echo "<modx>
	<database_type>mysql</database_type>
	<database_server>localhost</database_server>
	<database>$DATABASE</database>
	<database_user>пользователь_БД</database_user>
	<database_password>пароль_пользователя_БД</database_password>
	<database_connection_charset>utf8</database_connection_charset>
	<database_charset>utf8</database_charset>
	<database_collation>utf8_unicode_ci</database_collation>
	<table_prefix>modx_</table_prefix>
	<https_port>443</https_port>
	<http_host>`basename $DIRPATH`</http_host>
	<cache_disabled>0</cache_disabled>
	<inplace>1</inplace>
	<unpacked>0</unpacked>
	<language>ru</language>
	<cmsadmin>логин_админа_modx</cmsadmin>
	<cmspassword>пароль_админа</cmspassword>
	<cmsadminemail>mail@mail.ru</cmsadminemail>
	<core_path>$DIRPATH/core/</core_path>
	<context_mgr_path>$DIRPATH/manager/</context_mgr_path>
	<context_mgr_url>/manager/</context_mgr_url>
	<context_connectors_path>$DIRPATH/connectors/</context_connectors_path>
	<context_connectors_url>/connectors/</context_connectors_url>
	<context_web_path>$DIRPATH/</context_web_path>
	<context_web_url>/</context_web_url>
	<remove_setup_directory>1</remove_setup_directory>
</modx>" > $DIRPATH/config.xml

#############

echo "Получаем файл с modx.com..."
wget -O modx.zip http://modx.com/download/latest/
echo "Распаковка файла..."
unzip "./modx.zip" -d ./ > /dev/null

#############

ZDIR=`ls -F | grep "\/" | head -1`
if [ "${ZDIR}" = "/" ]; then
		echo "Не удалось найти каталог..."; exit
fi

if [ -d "${ZDIR}" ]; then
		cd ${ZDIR}
		echo "Выходим из временной директории..."
		mv ./* ../
		cd ../
		rm -r "./${ZDIR}"

		echo "Удаляем zip файл..."
		rm "./modx.zip"

		cd "setup"
		echo "Начинаем установку..."
		php ./index.php --installmode=new --config=$DIRPATH/config.xml

		echo "Готово!"
else
		echo "Не удалось найти каталог: ${ZDIR}"
		exit
fi
