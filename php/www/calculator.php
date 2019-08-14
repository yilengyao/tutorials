<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Calculator</title>
</head>
<body>
<?php ?>
    <form action="calculator.php" method="get">
        Number 1: <input type="number" name="num1">
        <br>
        Number 2: <input type="number" name="num2">
        <input type="submit">
    </form>
    <br>
    Answer: <?php echo $_GET["num1"] + $_GET["num2"];?>
</body>
</html>