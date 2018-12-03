echo "Running Reset Site script..."

echo "Install requirements"
source /var/venv/app/bin/activate
pip install -r /var/www/app/requirements.txt
deactivate

echo "Clearing database"
sudo su - postgres -c "psql -f /var/www/app/schema.sql"

echo "Executing database migrations"
/var/venv/app/bin/python /var/www/app/manage.py makemigrations --merge
/var/venv/app/bin/python /var/www/app/manage.py migrate --noinput

echo "Download and install potential app_manager bower dependencies"
cd /var/www/app/
bower install --allow-root

# echo "Create admin superuser"
# echo "from django.contrib.auth import get_user_model; get_user_model().objects.create_superuser('admin', 'admin@email.com', 'sc1sys2018@')" | /var/venv/geonode/bin/python /var/www/cartosys/manage.py shell
# echo "from django.contrib.auth import get_user_model; get_user_model().objects.create_user('demo_user_1', 'user@email.com', 'sc1sys2018@')" | /var/venv/geonode/bin/python /var/www/cartosys/manage.py shell
# echo "from django.contrib.auth import get_user_model; get_user_model().objects.create_user('demo_user_2', 'user@email.com', 'sc1sys2018@')" | /var/venv/geonode/bin/python /var/www/cartosys/manage.py shell

/var/venv/app/bin/python /var/www/app/manage.py collectstatic --noinput

echo "Setting file permissions"
chmod -R 777 /var/www/app/ 

echo "Restarting apache..."
service apache2 restart

echo "Apache restarted"

echo "Reset site script complete"
