#!/bin/bash

echo "Обновление MODX"

DIRPATH=`pwd`

echo "Получаем файл с  modx.com..."
wget -O modx.zip http://modx.com/download/latest/
echo "Распаковка файла..."
unzip "./modx.zip" -d ./ > /dev/null

ZDIR=`ls -F | grep "modx-" | head -1`
if [ "${ZDIR}" = "/" ]; then
        echo "Не удалось найти каталог..."; exit
fi

if [ -d "${ZDIR}" ]; then
        cd ${ZDIR}
        echo "Выходим из временной директории..."
        cp -r ./* ../
        cd ../
        rm -r "./${ZDIR}"

        echo "Удаляем zip файл..."
        rm "./modx.zip"

        cd "setup"
        echo "Запуск установки..."
        php ./index.php --installmode=upgrade --config=$DIRPATH/config.xml

        echo "Готово!"
else
        echo "Не удалось найти каталог: ${ZDIR}"
        exit
fi

echo "Готово"
