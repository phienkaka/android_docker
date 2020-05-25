FROM openjdk:8-jdk
MAINTAINER Phien <phienkv@gmail.com>

ENV VERSION_TOOLS "6200805"
ENV ANDROID_HOME "$PWD/android-sdk-linux"
ENV PATH "$PATH:${ANDROID_HOME}/tools"
ENV PATH "$PATH:${ANDROID_HOME}/platform-tools"
ENV DEBIAN_FRONTEND noninteractive
ENV ANDROID_COMPILE_SDK "28"
ENV ANDROID_BUILD_TOOLS "28.0.2"
ENV ANDROID_SDK_TOOLS "4333796"

RUN apt-get --quiet update --yes \
 && apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 npm

RUN wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip \
 && unzip -d android-sdk-linux android-sdk.zip \
 && echo y | android-sdk-linux/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null \
 && echo y | android-sdk-linux/tools/bin/sdkmanager "platform-tools" >/dev/null \
 && echo y | android-sdk-linux/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null 

RUN npm i -g firebase-tools
