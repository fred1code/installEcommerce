
# 1 nombre de la carpeta donde se guardara el hosts
# 2 correo para el hosts
# 3 nombre del hosts
# 4 ip del hosts
# 5 db server
# 6 prefijo de la base de datos
# 7 db user
# 8 db pass
# 9 email

mkdir /var/www/$1
version='0.0.1'
contry="MX"
name="usuario"
letter=0
send=0
key='`key`';
preci='`precision`'
metodo='`method`';
  
docroot="/var/www/$1/"
host='1s/^/'$4
hosts=host'    '
cp template /etc/apache2/sites-available/"$1.conf"
sed -i 's/template.email/'$2'/g' /etc/apache2/sites-available/"$1.conf"
sed -i 's/template.url/'$3'/g' /etc/apache2/sites-available/"$1.conf"
sed -i 's#template.docroot#'$docroot'#g' /etc/apache2/sites-available/"$1.conf"
sed -i '1s/^/'$4'   '$3'\n/' /etc/hosts
a2ensite $1
/etc/init.d/apache2 reload

cp -r /home/fredy/Descargas/ecommerce_1.7.6/prestashop/* /var/www/$1
#eliminamos el index
rm /var/www/$1/index.php
#copiamos el index de instalacion
cp -a /home/fredy/Descargas/ecommerce_1.7.6/index.php /var/www/$1/

#creamos la base de datos
mysql -uroot -e "CREATE DATABASE $1"
#instalamos prestashop
php /var/www/$1/install/index_cli.php --language=es --domain=$3 --db_server=$5 --db_name=$1 --prefix=$6 --nme=$3 --db_user=$7 --db_password=$8 --country=$contry --firstname=$name --lastname=dfg --email=$9 --newsletter=0 --send_email=1
#eliminamos el index de instalacionc
rm -r /var/www/$1/index.php
#copiamos el index 
cp -a /home/fredy/Descargas/ecommerce_1.7.6/indexArch/index.php /var/www/$1/

#borrar la carpeta de instalacion
rm -r /var/www/$1/install/



#execute sql
sed -i -e 's/$1/'$1'/g' /var/www/sql_ecommerce.sql
sed -i -e 's/$6/'$6'/g' /var/www/sql_ecommerce.sql
sed -i -e 's/$metodo/'$metodo'/g' /var/www/sql_ecommerce.sql
sed -i -e 's/$pass/'$pass'/g' /var/www/sql_ecommerce.sql
sed -i -e 's/$passdos/'$passdos'/g' /var/www/sql_ecommerce.sql
sed -i -e 's/${10}/'${10}'/g' /var/www/sql_ecommerce.sql
sed -i -e 's/${11}/'${11}'/g' /var/www/sql_ecommerce.sql
mysql -u root -p12345 $1 < /var/www/sql_ecommerce.sql

#permisos
chmod -R 777 /var/www/$1/ 