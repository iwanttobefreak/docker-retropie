FROM ubuntu:20.04

RUN apt-get update \
    && apt-get upgrade -y 

RUN apt-get install -y --no-install-recommends ca-certificates git lsb-release sudo x11-apps\
    && useradd -d /home/retropie -G sudo -m pi \
    && echo "pi ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/pi

WORKDIR /home/retropie
USER pi
RUN git clone --depth=1 https://github.com/RetroPie/RetroPie-Setup.git \
    && cd RetroPie-Setup \
    && chmod +x retropie_setup.sh \
    && sudo ./retropie_packages.sh setup basic_install

COPY files/roms/mame-libretro/* /home/retropie/RetroPie/roms/mame-libretro/
COPY files/videos/mame-libretro/* /home/retropie/.emulationstation/downloaded_images/mame-libretro/
COPY files/gamelist/mame-libretro/gamelist.xml /opt/retropie/configs/all/emulationstation/gamelists/mame-libretro/gamelist.xml

COPY files/roms/amstradcpc/* /home/retropie/RetroPie/roms/amstradcpc/
COPY files/videos/amstradcpc/* /home/retropie/.emulationstation/downloaded_images/amstradcpc/
COPY files/gamelist/amstradcpc/gamelist.xml /opt/retropie/configs/all/emulationstation/gamelists/amstradcpc/gamelist.xml

COPY files/roms/snes/* /home/retropie/RetroPie/roms/snes/
COPY files/videos/snes/* /home/retropie/.emulationstation/downloaded_images/snes/
COPY files/gamelist/snes/gamelist.xml /opt/retropie/configs/all/emulationstation/gamelists/snes/gamelist.xml

COPY files/roms/msx/* /home/retropie/RetroPie/roms/msx/
COPY files/videos/msx/* /home/retropie/.emulationstation/downloaded_images/msx/
COPY files/gamelist/msx/gamelist.xml /opt/retropie/configs/all/emulationstation/gamelists/msx/gamelist.xml

RUN cd RetroPie-Setup && \
    export TZ=Europe/Madrid && \
    sudo ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    sudo apt-get -y install tzdata && \
    sudo ./retropie_packages.sh openmsx

RUN sudo echo 'default = "openmsx"' >>  /opt/retropie/configs/msx/emulators.cfg && \ 
    sudo echo 'default = "lr-snes9x"' >>  /opt/retropie/configs/snes/emulators.cfg 

RUN sudo chown -R pi.pi /home/retropie \
    && sudo chown -R pi.pi /opt/retropie/configs/all/emulationstation/gamelists/

RUN sudo usermod -aG adm,dialout,cdrom,sudo,audio,video,plugdev,games,users pi
USER root
CMD su - pi -c "export DISPLAY=:0 ; /usr/bin/emulationstation"
