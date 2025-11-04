<?php
echo "<h2>PHP info()</h2>";
phpinfo();

$host = '192.168.56.11';   // IP de la VM db
$db   = 'taller_db';
$user = 'taller_user';
$pass = 'taller_pass';
$port = '5432';

echo "<h2>Conexión a PostgreSQL</h2>";
$conn_string = "host={$host} port={$port} dbname={$db} user={$user} password={$pass}";
$pg = @pg_connect($conn_string);

if(!$pg) {
    echo "<p style='color:red;'>Error: no se pudo conectar a PostgreSQL.</p>";
} else {
    $res = pg_query($pg, "SELECT id, name, email FROM persons LIMIT 10");
    if ($res) {
        echo "<table border='1'><tr><th>ID</th><th>Nombre</th><th>Email</th></tr>";
        while ($row = pg_fetch_assoc($res)) {
            echo "<tr><td>{$row['id']}</td><td>{$row['name']}</td><td>{$row['email']}</td></tr>";
        }
        echo "</table>";
    }
    pg_close($pg);
}
?>
