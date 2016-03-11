<!DOCTYPE html>
<html>
<head>
    <title>Index example.it</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <!-- Bootstrap -->
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet" />
</head>
<style>
    div{
        background-color: white;
        width: 800px;
        padding: 30px;
        border: 3px solid #7e7e7e;
        color: #757575;
        margin: 0 auto;
        display: block;
        margin-top: 100px;
    }

    h2 {
        color: #4d9a49;
        margin: 0px;
        margin-bottom: 10px;
    }
    
</style>
<body>
    <div class="message">
        <h2>Your website <?php echo $_SERVER['HTTP_HOST']; ?> is ready.</h2>
        This site has been successfully created and is ready for content to be added. Replace this default page with your own index page.
    </div>
</body>
</html>