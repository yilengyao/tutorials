<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Strings</title>
</head>
<body>
    <?php
        $phrase = "Giraffe Academy";
        echo strtoupper($phrase); // convert string to uppercase
        echo "<br>";
        echo strtolower($phrase); // convert string to lowercase
        echo "<br>";
        echo strlen($phrase); // give number of characters in a string
        echo "<br>";
        echo $phrase[1]; // string index
        echo "<br>";
        echo str_replace("Giraffe", "Panda", $phrase); // string replacement
        echo "<br>";
        echo substr($phrase, 3, 6); // substring 
    ?>
</body>
</html>