<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Associative Array</title>
</head>
<body>
    <p>Associative Arrays in PHP is to store key value pairs</p>
    <code> $grades = array("Jim" => "A+", "Pam" => "B", "Oscar" => "C+");
        echo $grades["Pam"];</code>
    <br>
    <form action="associativearray.php" method="post">
        Student name: <input type="text" name="student">
        <input type="submit">
    </form>

    <?php
        $grades = array("Jim" => "A+", "Pam" => "B", "Oscar" => "C+");
        echo $grades[$_POST["student"]];
        echo "<br>";
        echo "count: ";
        echo count($grades)
    ?>
</body>
</html>