# SonarQube Production Infrastructure

운영 환경용 SonarQube 분석 플랫폼 서버 구축 프로젝트입니다. 
외부 PostgreSQL 데이터베이스를 연동하여 데이터 영속성을 확보하였으며, 보안을 위해 환경 변수를 분리 관리합니다.

## 🛠 포함된 플러그인 (Installed Plugins)

현재 Dockerfile을 통해 이미지 빌드 시 아래의 정적 분석 플러그인이 자동으로 설치됩니다.
- **Sonar-FindBugs (SpotBugs)**: Java 코드의 잠재적 버그 탐지 (v5.0.5)
- **Sonar-PMD**: 코드 스타일 및 복잡도 분석 (v4.2.1)
- **Sonar-Checkstyle**: 코딩 컨벤션 준수 여부 확인 (v10.12.4)

## 🚀 시작하기 (Quick Start)

### 1. 환경 변수 설정
프로젝트 최상단에 `.env` 파일을 생성하고 아래 내용을 입력합니다. (보안을 위해 `.env` 파일은 Git 추적에서 제외됨)

```env
DB_USER=your_user
DB_PASSWORD=your_password
DB_NAME=sonarqube_prod
```

### 2. 실행 및 관리 명령어 (Operations)
모든 명령어는 프로젝트 루트 디렉토리(docker-compose.prod.yml 파일이 있는 곳)에서 실행해야 합니다.

#### 서비스 시작 (Build & Run)
이미지를 빌드하고 컨테이너를 백그라운드에서 실행합니다.
```Bash
docker compose -f docker-compose.prod.yml up -d --build
```

#### 상태 확인
컨테이너가 정상적으로 구동 중인지 확인합니다.
```Bash
docker compose -f docker-compose.prod.yml ps
```

#### 실시간 로그 확인
서버 부팅 및 에러 로그를 실시간으로 모니터링합니다.
```Bash
docker logs -f sonarqube-prod-server
```

#### 서비스 정지 및 삭제
컨테이너를 정지하고 삭제합니다. (볼륨 데이터는 유지됨)
```Bash
docker compose -f docker-compose.prod.yml down
```

#### 데이터 완전 초기화
컨테이너와 모든 데이터 볼륨을 삭제합니다. (주의: 모든 분석 데이터가 유실됨)
```Bash
docker compose -f docker-compose.prod.yml down -v
```

#### 📁 볼륨 구조 (Volume Structure)
운영 데이터 보호를 위해 호스트의 다음 디렉토리에 데이터가 마운트됩니다.
* ./sonarqube_prod_data: 분석 데이터 및 서버 설정
* ./sonarqube_prod_logs: 시스템 로그
* ./sonarqube_prod_extensions: 설치된 플러그인 및 확장 기능
* ./postgres_data: PostgreSQL 데이터베이스 파일

#### ⚠️ 서버 요구 사양 및 정보
* 접속 정보: http://localhost:39000 (초기 계정: admin / admin)
* 메모리 설정: 운영 안정성을 위해 각 프로세스당 1GB(총 3GB 이상)의 JVM 힙 메모리를 할당합니다.
* 권장 사양: 최소 8GB 이상의 시스템 RAM 환경을 권장합니다.
* 보안: 첫 로그인 후 반드시 admin 비밀번호를 변경하십시오.