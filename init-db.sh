#!/bin/bash
docker-compose exec postgres psql -U n8n -d n8n -c "
CREATE TABLE IF NOT EXISTS articles (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    url TEXT UNIQUE NOT NULL,
    source VARCHAR(255) NOT NULL,
    published_at TIMESTAMP NOT NULL,
    category VARCHAR(255),
    summary TEXT,
    content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);"

docker-compose exec postgres psql -U n8n -d n8n -c "
CREATE INDEX IF NOT EXISTS idx_articles_url ON articles(url);
CREATE INDEX IF NOT EXISTS idx_articles_pubdate ON articles(published_at);
CREATE INDEX IF NOT EXISTS idx_articles_source ON articles(source);
CREATE INDEX IF NOT EXISTS idx_articles_category ON articles(category);"