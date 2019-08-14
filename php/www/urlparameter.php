<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
</head>
<body>
<!-- http://localhost:4000/www/urlparameter.php?name=dave&age=70 -->
    <form action="urlparameter.php" method="get">
        Name: <input type="text" name="name"> <br>
        <input type="submit">
    </form>
    <br><br>

    <?php 
        echo $_GET["age"];
    ?>
</body>
</html>