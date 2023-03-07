FROM python
LABEL Iván Piña Castillo "ivanpicas88@gmail.com"
WORKDIR /usr/src/app
RUN git clone https://github.com/LainWireless/docker_django_tutorial.git /usr/src/app 
RUN pip --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host=files.pythonhosted.org install --root-user-action=ignore -r requirements.txt
RUN mkdir static
ADD ./django_polls.sh /usr/src/app/django.sh
RUN chmod +x /usr/src/app/django_polls.sh
ENV ALLOWED_HOSTS=*
ENV HOST=mariadb
ENV USUARIO=django
ENV CONTRA=django
ENV BASE_DATOS=django
ENV DJANGO_SUPERUSER_PASSWORD=admin
ENV DJANGO_SUPERUSER_USERNAME=admin
ENV DJANGO_SUPERUSER_EMAIL=admin@example.org
ENTRYPOINT ["/usr/src/app/django_polls.sh"]
