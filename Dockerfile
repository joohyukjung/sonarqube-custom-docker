# 1. 기존에 확인된 SonarQube 베이스 이미지 유지
FROM sonarqube:26.4.0.121862-community

# 2. ADD 명령어를 통한 플러그인 다이렉트 다운로드 및 소유권(chown) 즉시 부여
# (apt-get, curl 등의 OS 유틸리티 설치 및 root 권한 전환 과정 전면 생략)
ADD --chown=sonarqube:sonarqube https://github.com/spotbugs/sonar-findbugs/releases/download/v4.6.0/sonar-findbugs-plugin-v4.6.0.jar /opt/sonarqube/extensions/plugins/
ADD --chown=sonarqube:sonarqube https://github.com/jborgers/sonar-pmd/releases/download/4.2.1/sonar-pmd-plugin-4.2.1.jar /opt/sonarqube/extensions/plugins/
ADD --chown=sonarqube:sonarqube https://github.com/checkstyle/sonar-checkstyle/releases/download/10.26.1/checkstyle-sonar-plugin-10.26.1.jar /opt/sonarqube/extensions/plugins/

# 3. 운영 환경을 위한 타임존 설정
ENV TZ=Asia/Seoul