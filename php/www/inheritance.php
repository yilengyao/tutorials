<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Constructors</title>
</head>
<body>
    <?php
        class Book {
            var $title;
            var $author;
            var $pages;

            function __construct($aTitle, $aAuthor, $aPages) {
                $this->title = $aTitle;
                $this->author =$aAuthor;
                $this->pages = $aPages;
            }

            function price() {
                return $this->pages/2;
            }
        }

        class ScienceBook extends Book {
            function discount() {
                echo $this->price() * 0.8;
            }
        }

        $book1 = new Book("harry Potter", "JK Rawling", 400);

        echo $book1->author;
        echo "<br>";
        $bio101 = new ScienceBook("Intro to Biology", "Scientist", 100);

        echo $bio101->price();
        echo "<br>";
        echo $bio101->discount();

    ?>
</body>
</html>