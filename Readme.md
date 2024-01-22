# How

1. make sure init_folder already contain all sql files with desired order!. And make sure the file:"99-grant-privilege" is executed at last

2. Dockerfile exist under the same directory

#  to build the docker image
3. docker build --progress=plain --no-cache --tag mysql-personal-project-image .

#  to export the docker image as tar file
4. docker save -o ./mysql-personal-project-image.tar mysql-personal-project-image

#  to import the docker image from a tar file
5. docker load -i mysql-personal-project-image.tar