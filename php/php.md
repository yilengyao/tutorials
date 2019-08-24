# Running a php server


```
%%bash
php -S localhost:4000
```

webpage is accessed using the url [localhost:4000/www/data.php](localhost:4000/www/data.php)

# Get vs Post
get: unformation is stored in url parameter

post: information is not stored in url parameter

Post is more secure

# Associative Array 

Associative Array in PHP is for storing key value pairs

### human readable printing
`print_r(var_name)`# Output Buffering
Don't send output to the browser immediately, send it to a buffer when a function or some calculation has finished then send to the browser.<br>
PHP code and data is runned in the background and not shown to the user untill you <b>echo</b> it out. echo statements are output generators: they "leak out" of PHP code, creating visual output to the user. while most othe PHP code doesn't. "output buffering" is the process of capturing and modifying the output before it is "echoed out".


### ob_start()
Turns on output buffering. In other words, it creates the buffer (invisible holding cell) that will store all output after it is called

### ob_get_contents()
Grabs all the data gathered since we ce called ob_start. i.e. everything in the buffer. Usually, you'll assign this to a variable

### ob_clean()
Removes everything from the output buffer. Note that it doesn not output anything

### ob_end_clean()
basically runs ob_get_contents(), erases the buffer, and turns off output buffering.

### ob_end_flush() 
outputs content from the buffer and ends output buffering. It does not erase the buffer.

## Wen is Output Buffering used
HTTP headers contains information like the type of contents on its way, dated it was last modified, typer of server sending the request. Headers need to be sent before any output or other data is sent from the server.
: used to print human-readable information about a variable, expecially useful for printing key value pari information in an associative array.

# Autoloaders
Class autoloading: load classes automatically on demand, it provides you the name of the class to be loaded before it is called to instantiate an object. You are responsible for implementing the code to require the file containing the class that is in demand.<br>
Right before an object is instantiated from a class, the autoloader, will give the php program of the name of the class that is needed to be required. So it is up to your to implement a code to search for and require the file that contains the class of the same name.
- It's common and good practice to define each class in a separate file
- Before you can use a class that's defined in a separate file, you have to require it
- If you have alot of sepaate files (classes), you can end up with alot of requires in the script
- autoloaders allow you to require the the files containing the class automatically on demand
- how the autoload function works: autoload function provides the name of the class in demand
Autoloading any class
- Each class in a separate file
- The filename matching the class name
- In folders that match the name spaces
- Classes will be automatically required on demand
- No explicit require statements needed

```
<?php
    // using anomynous function
    spl_autoload_register(function($class) {
        require_once("folder/{$class}.php");
     });
     
     // another way
     function my_autoloader($class) {
         require_once("folder/{$class}.php");
     }
     spl_autoload_register('my_autoloader');
?>
```

# Sessions
Sessions: is a way to carry data or information across multiple pages.<br>
Normal a variable set on one page is not accessable on the next<br>
Unlike cookies, session data is not stored on the user's computer, it is stored on the server.<br>
- session_start(): start the session
- the PHP global variable $_SESSION is associative array storing session variables, in a key value pair

```
// storing session variable
<?php
    session_start();
    
    $_SESSION['email'] = "someone@somemail.com";
?>
```

```
// accessing session variable
<?php
    session_start();
    
    $name = $_SESSION['email'];
?>
```

# Redirection with PHP header
```
<?php 
// PHP program to describes header function 
  
// Redirect the browser 
header("Location: http://www.geeksforgeeks.org"); 
  
// The below code does not get executed  
// while redirecting 
exit; 
  
?> 
```

# Magic Constants
Magic constants are predefined constants in PHP whih gets changed on the basis of their usage. They start with double underscore $(__)$ and ends with double underscore.<br>
They are similar to predefined constants but they change their values with the context.

|Name|Description|
|----|-----------|
|$__LINE__$|Represents current line number where it is used.|
|$__FILE__$|Represents full path and file name of the file. If it is used inside an include, name of included file is returned.|
|$__DIR__$|Represents full directory path of the file. Equivaluent to dirname($__file__$). It does not have a trailing slash unless it is a root directory. It also resolves symbolic link.|
|$__FUNCTION__$|Represents the function name where it is used. If it is used outside any function, then it will return blank.|
|$__CLASS__$|Represents the class name where it is used. If it is used outside of any function, then it will return blank.|
|$__TRAIT__$|Represents the trait name where it is used. If it is used outside any function, then it will return blank. It includes namespace it was declared in.|
|$__METHOD__$|Represents the name of the class method where it is used. The method name is returned as it was declared.|
|$__NAMESPACE__$|Represents the name of the current namespace.|

<br>

- file_exists(): checks whether a file or directory exists
- is_file(): tells whether the given file is a regular file
- is_dir(): tells whether the given filename is a directory
```
<?php
    echo __FILE__ . "<br>";
    echo __LINE__ . "<br>";
    echo __DIR__ . "<br>";
    
    if(file_exists(__DIR__)) {
        echo "yes";
    } else {
        echo "no";
    }
    
    if(is_file(__DIR__)) {
        echo "yes";
    } else {
        echo "no";
    }
    
    is(is_dir(__FILE__)) {
        echo "yes";
    } else {
        echo "no";
    }
?>
```

# Uploading Files

php.ini configurations

| Attribute | Description |
|--|--|
|file_uploads| True, 1, or On|
|post_max_size| 8M|
|upload_max_file_size| 2M|
|memory limit| 128M|
|max_input_time| -1 - no limit|
|upload_tmp_dir| NULL|
|max_execution_time| 30 seconds|

This information on XAMPP is available in http://localhost/xampp/ phpinfo()

file path for php.ini on XAMPP on Mac OS is /Applications/XAMPP/etc/php.ini 

after changes to the configuration restart XAMPP services

to view php info in browser use the following function

```
<?php 
    phpinfo();
?>
```

## Submitting file using a Form
- method should be post
- enctype should be multipart/form-data
- input type should be file

```
<form action="upload.php" enctype="multipart/form-data" method="post">
    <input type="file" name="file_upload"><br>
    <input type="submit" name="submit">
</form>
```
## Uploaded File Structure
$_FILES['example_file']

An associative array of items uploaded to current script via the HTTP POST method.


| Attribute | Description |
|--|--|
|name|file name|
|type|jpg, png, gif, doc, txt|
|size| in bytes|
|tmp_name|temborary name|
|error|the error code|

```
<?php 
    print_r($_FILES['file_upload']);
?>
```

## File Upload Errors List

|Constant|Value|Description|
|--|--|--|
|UPLOAD_ERR_OK        | 0| There is no error|
|UPLOAD_ERR_INI_SIZE  | 1| Bigger then the upload_max)filesize directive|
|UPLOAD_ERR_FORM_SIZE | 2| The uploaded file exceed MAX_FILE_SIZE|
|UPLOAD_ERR_PARTIAL   | 3| The uploaded file was only partially uploaded|
|UPLOAD_ERR_NO_FILE   | 4| No file was uploaded
|UPLOAD_ERR_NO_TMP_DIR| 6| Missing a temporary folder. Introduced in PHP 5.0.3|
|UPLOAD_ERR_CANT_WRITE| 7| Failed to write file to disk/ Introduced in PHP 5.1.0|
|UPLOAD_ERR_EXTENSION | 8| A PHP extension stopped the file upload|
```
<?php
    $upload_errors = array(
        UPLOAD_ERR_OK         => "There is no error",
        UPLOAD_ERR_INI_SIZE   => "The uploaded file exceed the upload_max_filesize directive",
        UPLOAD_ERR_FORM_SIZE  => "The upload file exceeds the MAX_FILE_SIZE directive",
        UPLOAD_ERR_PARTIAL    => "The uploaded file is only partially uploaded.",
        UPLOAD_ERR_NO_FILE    => "No file was uploaded.",
        UPLOAD_ERR_NO_TMP_DIR => "Missing a temporary folder.",
        UPLOAD_ERR_CANT_WRITE => "Failed to write file to disk.",
        UPLOAD_ERR_EXTENSION  => "A PHP extension stopped the file upload."
    );

    $the_error = $_FILES['file_upload']['error'];
    $the_message = $upload_error[$the_error];
?>
```

## Moving Uploaded Files
using <b>move_uploaded_file([source],[destination])</b>.
```
%%bash
mkdir uploads # make directory to move the uploaded files into
chmod ugo=rwx uploads # add read write and execute permissions to uploads directory
```
```
<?php 
    if(isset($_FILES['file_upload'])) {
    

        $upload_errors = array(
            UPLOAD_ERR_OK         => "There is no error",
            UPLOAD_ERR_INI_SIZE   => "The uploaded file exceed the upload_max_filesize directive",            
            UPLOAD_ERR_FORM_SIZE  => "The upload file exceeds the MAX_FILE_SIZE directive",
            UPLOAD_ERR_PARTIAL    => "The uploaded file is only partially uploaded.",
            UPLOAD_ERR_NO_FILE    => "No file was uploaded.",
            UPLOAD_ERR_NO_TMP_DIR => "Missing a temporary folder.",
            UPLOAD_ERR_CANT_WRITE => "Failed to write file to disk.",
            UPLOAD_ERR_EXTENSION  => "A PHP extension stopped the file upload."
        );

        $temp_name = $_FILES['file_upload']['tmp_name'];
        $the_file = $_FILES['file_upload']['name'];
        $directory = "uploads";
        
        if(move_uploaded_file($temp_name, $directory . "/" . $the_file)) {
            $the_message = "File uploaded successfully";
        } else {
            $the_error = $_FILES['file_upload']['error'];
            $the_message = $upload_errors[$the_error];
        }
    }
?>
<form action="upload.php" enctype="multipart/form-data" method="post">
   <h2>
        <?php
            if(!empty($upload_errors)) {
                echo $the_message;
            }
        ?>
    </h2>
    <input type="file" name="file_upload"><br>
    <input type="submit" name="submit">
</form>
```

## Cleaning with htmlentities
It attempts to solve the security loophole of attacker inject html code and scripts into your webpage<br>
### Converting HTML into Entities
htmlentities function takes a string and returns the same string with HTML converted into HTML entities.

```
## Cleaning with htmlentities
It attempts to solve the security loophole of attacker inject html code and scripts into your webpage<br>
### Converting HTML into Entities
htmlentities function takes a string and returns the same string with HTML converted into HTML entities. 
```

```
<?php
    /* removes unwanted charaters such as > < etc. */
    function clean($string) {
        return htmlentities($string);
    }
?>
```


# Generate Token
// elaborate later


# Send Email

```
    function send_email($email, $subject, $message, $headers) {
        return mail($email, $subject, $message, $headers);
    }
```
// activation link will come later



# HTML Entity calling PHP Functions

## Form Button calling PHP Functions

```
<form method="post" >
    <?php pressed();?>
    <input type="submit" name="cancel-submit" id="cancel-submit" value="Cancel" />
    <input type="submit" name="recover-submit" id="recover-submit" value="Recover" />
</form>
```

```
<?php
    function pressed() {
        if($_SERVER['REQUEST_METHOD'] == "POST") {    
            if(isset($_POST['cancel-submit'])) {
                echo "Cancel";
            }
            if(isset($_POST['recover-submit'])){
                echo "Recover";
            }
        }
    }
?>
```
