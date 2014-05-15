echo "Installer for twolife.be Qt5 backport to Raspbian"
echo
echo "Warning: this might take a while!"

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key 2578B775
sudo bash -c "echo \"deb http://twolife.be/raspbian/ wheezy main backports\" > /etc/apt/sources.list.d/twolife.list"
sudo apt-get update
sudo apt-get install qt5-default libqt5qml-graphicaleffects libqt5quickparticles5 qtdeclarative5-qtquick2-plugin qtdeclarative5-window-plugin qtdeclarative5-particles-plugin qmlscene
sudo ln -fs /opt/vc/lib/libEGL.so /usr/lib/libEGL.so
sudo ln -fs /opt/vc/lib/libEGL.so /usr/lib/arm-linux-gnueabihf/libEGL.so
sudo ln -fs /opt/vc/lib/libEGL.so /usr/lib/arm-linux-gnueabihf/libEGL.so.1
sudo ln -fs /opt/vc/lib/libEGL_static.a /usr/lib/libEGL_static.a
sudo ln -fs /opt/vc/lib/libEGL_static.a /usr/lib/arm-linux-gnueabihf/libEGL_static.a
sudo ln -fs /opt/vc/lib/libGLESv2.so /usr/lib/libGLESv2.so
sudo ln -fs /opt/vc/lib/libGLESv2.so /usr/lib/arm-linux-gnueabihf/libGLESv2.so
sudo ln -fs /opt/vc/lib/libGLESv2.so /usr/lib/arm-linux-gnueabihf/libGLESv2.so.2
sudo ln -fs /opt/vc/lib/libGLESv2_static.a /usr/lib/libGLESv2_static.a
sudo ln -fs /opt/vc/lib/libGLESv2_static.a /usr/lib/arm-linux-gnueabihf/libGLESv2_static.a
sudo ln -fs /opt/vc/lib/libbcm_host.so /usr/lib/libbcm_host.so
sudo ln -fs /opt/vc/lib/libbcm_host.so /usr/lib/arm-linux-gnueabihf/libbcm_host.so
sudo ln -fs /opt/vc/lib/libvchiq_arm.a /usr/lib/libvchiq_arm.a
sudo ln -fs /opt/vc/lib/libvchiq_arm.a /usr/lib/arm-linux-gnueabihf/libvchiq_arm.a
sudo ln -fs /opt/vc/lib/libvchiq_arm.so /usr/lib/libvchiq_arm.so
sudo ln -fs /opt/vc/lib/libvchiq_arm.so /usr/lib/arm-linux-gnueabihf/libvchiq_arm.so
sudo ln -fs /opt/vc/lib/libvcos.a /usr/lib/libvcos.a
sudo ln -fs /opt/vc/lib/libvcos.a /usr/lib/arm-linux-gnueabihf/libvcos.a
sudo ln -fs /opt/vc/lib/libvcos.so /usr/lib/libvcos.so
sudo ln -fs /opt/vc/lib/libvcos.so /usr/lib/arm-linux-gnueabihf/libvcos.so

echo "We're done, if everything went well you should now be ready to run Qt5 QML applications."
echo
echo "Try typing: \"qmlscene --help\" to see if it works"
echo
echo "To run QML applications optimally without X try the following:"
echo "qmlscene --transparent -platform eglfs <filename>"
echo
