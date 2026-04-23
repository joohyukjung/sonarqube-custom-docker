# 1. 기존에 확인된 SonarQube 베이스 이미지 유지
FROM sonarqube:26.4.0.121862-community

# 2. 시스템 시간(OS 레벨) 변경을 위한 root 권한 임시 전환
# 근거: /etc/localtime 및 /etc/timezone 파일은 root 권한으로만 수정 가능함
USER root

# 3. 운영 환경을 위한 타임존 환경변수 설정 및 OS 시스템 시계 동기화
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 4. 소나큐브 실행을 위한 기본 사용자로 권한 복귀
# 근거: 보안 상의 이유로 컨테이너 내부 서비스는 root가 아닌 지정된 user로 실행되어야 함
USER sonarqube

# 5. ADD 명령어를 통한 플러그인 다이렉트 다운로드 및 소유권(chown) 즉시 부여
ADD --chown=sonarqube:sonarqube https://github.com/spotbugs/sonar-findbugs/releases/download/v4.6.0/sonar-findbugs-plugin-v4.6.0.jar /opt/sonarqube/extensions/plugins/
ADD --chown=sonarqube:sonarqube https://github.com/jborgers/sonar-pmd/releases/download/4.2.1/sonar-pmd-plugin-4.2.1.jar /opt/sonarqube/extensions/plugins/
ADD --chown=sonarqube:sonarqube https://github.com/checkstyle/sonar-checkstyle/releases/download/10.26.1/checkstyle-sonar-plugin-10.26.1.jar /opt/sonarqube/extensions/plugins/