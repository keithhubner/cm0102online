### to do

- User config in dockerfile for security
- Try and get it working without host mount.

Host server is Ubuntu 20.04

Docker installed

Copy ISO file to server

``` sudo mkdir /mnt/iso```

Mount ISO to cd on boot
```
sudo nano /etc/fstab
/home/keithhubner/cm0102.iso /mnt/iso iso9660 defaults,loop 0 0
```

Build image from docker file:

```
sudo docker build /opt/cm0102/ -t cm0102
```

Run interactively:

```
sudo docker run -it -v /mnt/iso:/mnt/cdrom -p 5900:5900 cm0102
```

Run daemon:

```
sudo docker run -d -it -v /mnt/iso:/mnt/cdrom -v /opt/cm0102/data4:/root/.cm0102 -p 5900:5900 cm0102
```

Run commands:

setup.sh (Initial cm installer)

run.sh (Runs the app)

wine.sh (runs the wine config)

```
docker exec 0fbdec3ee49e /cm0102/run.sh
```