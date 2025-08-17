# 🚀 Redis Boilerplate 

This repo provides a **turn-key Redis setup** for local development and QA, with support for:

- Redis **8.2.0** in Docker  
- RedisInsight GUI for exploration and monitoring  
- Secure password authentication  
- Reset, backup, and restore scripts  
- Portable structure: ready to be reused in any new project  

---

## 📂 File Structure

```
redis-boilerplate/
├── .env.example # Env variables (copy to .env)
├── docker-compose.yml # Docker services
├── redis/
│ └── redis.conf # Redis configuration
├── scripts/
│ ├── reset-redis.sh # Reset container + volumes
│ ├── backup-redis.sh # Backup Redis to ./backups
│ └── restore-redis.sh # Restore from backup
└── backups/ # Created automatically, stores .rdb files
```


---

## ⚙️ Setup

### 1. Clone repo
```bash
git clone https://github.com/yourname/redis-boilerplate.git
cd redis-boilerplate
```

### 2. Copy .env.example → .env

```
cp .env.example .env
```


### 3. Build / Start containers

```
docker compose build --no-cache redis

docker compose up -d
```

---

## 🖥️ Usage

Connect via CLI directly inside the container:

```
docker exec -it redis-dev redis-cli -a change_me_redis_pw
```

Connect via RedisInsight

```
http://localhost:5540


docker ps --format "table {{.Names}}\t{{.Ports}}"
```

Add a new database connection:

    Host: redis-dev (or localhost)
    Port: 6379
    Password: change_me_redis_pw

----

## 🔄 Scripts


### *Reset Redis

Stops, removes, and rebuilds Redis with a clean state.

```
./scripts/reset-redis.sh
```

### Backup Redis

Forces Redis to persist to disk and copies dump.rdb into ./backups/.

```
./scripts/backup-redis.sh
```

Example output:

```
backups/dump-20250816_173045.rdb
```

### Restore Redis

Restores from a previous backup.

```
./scripts/restore-redis.sh ./backups/dump-20250816_173045.rdb
```


---
