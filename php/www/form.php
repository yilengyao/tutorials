<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Input</title>
</head>
<body>
    <?php ?>
        <form action="form.php" method="get">
            Name: <input type="text" name="username">
            Age: <input type="number" name="age">
            <input type="submit">
        </form>
        <br>
        Your name is <?php echo $_GET["username"];?>
        <br>
        Your age is <?php echo $_GET["age"];?>
</body>
</html>