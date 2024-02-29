#!/usr/bin/env python3

import json
import sqlite3

# Step 1: Read the JSON data
with open("db.json") as f:
    data = json.load(f)

# Step 2: Create an SQLite database and table structure
conn = sqlite3.connect("db.db")
c = conn.cursor()

# Create tables for categories and items
c.execute(
    """CREATE TABLE IF NOT EXISTS categories (
                id INTEGER PRIMARY KEY,
                category TEXT,
                image TEXT,
                description TEXT
             )"""
)

c.execute(
    """CREATE TABLE IF NOT EXISTS items (
                id INTEGER PRIMARY KEY,
                categoryId INTEGER,
                qtty INTEGER,
                name TEXT,
                description TEXT,
                image TEXT,
                FOREIGN KEY (categoryId) REFERENCES categories(id)
             )"""
)

# Step 3: Insert the JSON data into the SQLite database
# Insert categories
for category in data["categories"]:
    c.execute(
        """INSERT INTO categories (id, category, image, description)
                  VALUES (?, ?, ?, ?)""",
        (
            category["id"],
            category["category"],
            category["image"],
            category["description"],
        ),
    )

# Insert items
for item in data["items"]:
    c.execute(
        """INSERT INTO items (id, categoryId, qtty, name, description, image)
                  VALUES (?, ?, ?, ?, ?, ?)""",
        (
            item["id"],
            item["categoryId"],
            item["qtty"],
            item["name"],
            item["description"],
            item["image"],
        ),
    )

# Commit changes and close the connection
conn.commit()
conn.close()
