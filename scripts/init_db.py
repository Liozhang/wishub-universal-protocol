#!/usr/bin/env python3
"""
WisHub MVP 数据库初始化脚本
用途：初始化SQLite数据库，创建所有必需的表
"""

import os
import sys
from pathlib import Path

# 添加项目根目录到Python路径
project_root = Path(__file__).parent.parent
sys.path.insert(0, str(project_root))

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from app.models.base import Base
from app.models.wisunit import WisUnit
from app.models.wisdom_core import WisdomCore
from app.models.agent import Agent
from app.models.user import User

# 数据库连接URL
DATABASE_URL = os.getenv(
    "DATABASE_URL",
    "sqlite:///data/wishub.db"
)

def init_database():
    """初始化数据库"""
    print("正在初始化数据库...")

    # 创建数据库目录
    db_path = DATABASE_URL.replace("sqlite:///", "")
    db_dir = os.path.dirname(db_path)
    if db_dir and not os.path.exists(db_dir):
        os.makedirs(db_dir, exist_ok=True)

    # 创建引擎
    engine = create_engine(
        DATABASE_URL,
        echo=False,
        connect_args={"check_same_thread": False} if "sqlite" in DATABASE_URL else {}
    )

    # 创建所有表
    print("创建数据库表...")
    Base.metadata.create_all(bind=engine)

    print(f"数据库初始化完成: {DATABASE_URL}")

    # 创建会话
    SessionLocal = sessionmaker(bind=engine)
    db = SessionLocal()

    try:
        # 检查是否已有数据
        user_count = db.query(User).count()
        if user_count > 0:
            print(f"数据库已包含 {user_count} 个用户，跳过初始化")
            return

        # 创建默认管理员用户
        print("创建默认管理员用户...")
        default_admin = User(
            id="user_admin",
            username="admin",
            email="admin@wishub.local",
            credits=10000,
            reputation=1000
        )
        db.add(default_admin)

        # 提交
        db.commit()

        print("默认管理员用户创建成功:")
        print("  ID: user_admin")
        print("  Username: admin")
        print("  Email: admin@wishub.local")

    except Exception as e:
        db.rollback()
        print(f"错误: 创建默认用户失败 - {e}")
    finally:
        db.close()

def main():
    """主函数"""
    print("=" * 50)
    print("WisHub MVP 数据库初始化")
    print("=" * 50)
    print()

    try:
        init_database()
        print()
        print("=" * 50)
        print("初始化完成!")
        print("=" * 50)
    except Exception as e:
        print(f"错误: 初始化失败 - {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
