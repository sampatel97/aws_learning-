from db_connection import dbConnection

def get_redshift_tables(schema_name):
    conn = dbConnection()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT tablename 
        FROM pg_tables 
        WHERE schemaname = %s
    """,(schema_name,))
    tables = cursor.fetchall()
    cursor.close()
    conn.close()
    return tables

def get_redshift_views(schema_name):
    conn = dbConnection()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT viewname 
        FROM pg_views 
        WHERE schemaname = %s
    """,(schema_name,))
    tables = cursor.fetchall()
    cursor.close()
    conn.close()
    return tables

def create_table(schema_tablename,columns):
    conn = dbConnection()
    cur = conn.cursor()
    cur.execute(f"CREATE TABLE IF NOT EXISTS {schema_tablename} ({columns})")
    conn.commit()
    cur.close()
    conn.close()


def get_columns(table_name, schema_name):
    conn = dbConnection()
    cur = conn.cursor()
    cur.execute(f"SELECT column_name FROM information_schema.columns WHERE table_name='{table_name}' AND table_name='{schema_name}")
    columns = [row[0] for row in cur.fetchall()]
    cur.close()
    conn.close()
    return columns