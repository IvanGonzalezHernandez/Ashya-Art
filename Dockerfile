# Usa una imagen base de Tomcat con JDK
FROM tomcat:9-jdk17-temurin

# Borra cualquier aplicación que venga por defecto en Tomcat (si es necesario)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copia tu archivo WAR generado por Ant a la carpeta webapps de Tomcat
COPY dist/Ashya-Art.war /usr/local/tomcat/webapps/ROOT.war

# Expone el puerto 8080 (el estándar de Tomcat)
EXPOSE 8080

# Comando para ejecutar Tomcat cuando inicie el contenedor
CMD ["catalina.sh", "run"]
